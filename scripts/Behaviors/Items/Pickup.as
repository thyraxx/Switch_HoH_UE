class PickupCached : UnitProductionCache::IBase
{
	bool m_bounce;
	bool m_plrOnly;
	bool m_global;
	bool m_secure;
	bool m_shouldDestroy;
	bool m_isOre;
	
	int m_restrictNewGamePlusValue;
	string m_restrictNewGamePlus;
	Modifiers::EffectTrigger m_pickupTrigger;
	SoundEvent@ m_sound;
	
	array<IEffect@>@ m_effects;

	PickupCached(UnitPtr unit, SValue& params)
	{
		@m_effects = LoadEffects(unit, params);

		m_bounce = GetParamBool(unit, params, "bounce", false, true);
		@m_sound = Resources::GetSoundEvent(GetParamString(unit, params, "sound", false));
		m_plrOnly = GetParamBool(unit, params, "player-only", false, true);
		m_global = GetParamBool(unit, params, "global", false, false);
		m_secure = GetParamBool(unit, params, "secure", false, false);
		m_pickupTrigger = Modifiers::ParseEffectTrigger(GetParamString(unit, params, "pickup-trigger", false, ""));

		if (m_secure)
			m_global = true;

		m_shouldDestroy = !IsNetsyncedExistance(unit.GetUnitProducer().GetNetSyncMode()) || (m_global && Network::IsServer());

		m_isOre = GetParamBool(unit, params, "is-ore", false, false);
		m_restrictNewGamePlus = GetParamString(unit, params, "restrict-newgameplus", false);
		m_restrictNewGamePlusValue = GetParamInt(unit, params, "restrict-newgameplus-value", !m_restrictNewGamePlus.isEmpty());
	}
}

class Pickup
{
	UnitPtr m_unit;
	bool m_bounce;
	bool m_plrOnly;
	SoundEvent@ m_sound;
	bool m_global;
	bool m_secure;
	bool m_shouldDestroy;
	
	array<IEffect@>@ m_effects;
	array<IEffect@> m_effectsIgnore;

	bool m_visible;
	
	array<WorldScript::UnitPickedUpTrigger@> m_callbacks;
	Modifiers::EffectTrigger m_pickupTrigger;
	
	
	Pickup(UnitPtr unit, SValue& params)
	{
		auto cache = cast<PickupCached>(UnitProductionCache::GetCached(unit));
		if (cache is null)
			@cache = cast<PickupCached>(UnitProductionCache::AddCached(unit, PickupCached(unit, params)));

	
		m_unit = unit;

		m_bounce = cache.m_bounce;
		@m_sound = cache.m_sound;
		m_plrOnly = cache.m_plrOnly;
		m_global = cache.m_global;
		m_secure = cache.m_secure;
		m_pickupTrigger = cache.m_pickupTrigger;
		m_shouldDestroy = cache.m_shouldDestroy;
		
		@m_effects = CopyOrLoadEffects(cache.m_effects, unit, params);

		// We would like to ignore any ShowFloatingText actions when checking if we can pick up an item, since ShowFloatingText's CanApply always returns true.
		// I don't want to make that return false (it doesn't make a lot of sense to return false there anyway), so we choose to just ignore it in the checks and check it on collide.
		// A better solution could be another function in IEffect that signifies "importance" or "necessary" or something like that, and then a CanApplyNecessaryEffects(), maybe.
		// Anyway, this works for now.
		for (uint i = 0; i < m_effects.length(); i++)
		{
			auto effect = m_effects[i];
			if (cast<ShowFloatingText>(effect) !is null)
				m_effectsIgnore.insertLast(effect);
		}
		
		
		g_totalPickups++;
		g_totalPickupsTotal++;
		m_visible = true;
		
		if (!m_bounce)
		{
			m_unit.SetUpdateFrequency(4);
			m_unit.SetUpdateDistanceLimit(1);
		}
		else
			m_unit.SetUpdateDistanceLimit(300);

		if (cache.m_isOre && Fountain::HasEffect("no_ore"))
			Hide();

		if (!cache.m_restrictNewGamePlus.isEmpty())
		{
			auto localRecord = GetLocalPlayerRecord();
			if (localRecord !is null && localRecord.ngps[cache.m_restrictNewGamePlus] < cache.m_restrictNewGamePlusValue)
				Hide();
		}
	}

	SValue@ Save()
	{
		SValueBuilder sval;
		sval.PushDictionary();
		
		sval.PushBoolean("visible", m_visible);
		
		return sval.Build();
	}
	
	void PostLoad(SValue@ data)
	{
		auto visible = data.GetDictionaryEntry("visible");
		if (visible !is null && visible.GetType() == SValueType::Boolean)
		{
			if (!visible.GetBoolean())
				Hide();
		}
	}

	void Hide()
	{
		if (!m_visible)
			return;
			
		m_visible = false;

		m_unit.SetHidden(true);
		m_unit.SetShouldCollide(false);
		m_unit.SetUpdateDistanceLimit(300);
	}

	bool Picked(UnitPtr unit, bool force = false)
	{
		if (!m_visible && !force)
			return false;

		if (ApplyEffects(m_effects, null, unit, xy(m_unit.GetPosition()), vec2(0, 0), 1.0, false))
		{
			if (m_global)
			{
				if (cast<PlayerBase>(unit.GetScriptBehavior()) !is null)
					Hide();
			}
			else
			{
				if (cast<Player>(unit.GetScriptBehavior()) !is null)
					Hide();
			}

			Player@ plr = cast<Player>(unit.GetScriptBehavior());
			if (plr !is null)
			{
				plr.m_record.pickups++;
				plr.m_record.pickupsTotal++;
				
				if (m_pickupTrigger != Modifiers::EffectTrigger::None)
				{
					plr.m_record.GetModifiers().TriggerEffects(plr, plr, Modifiers::EffectTrigger::Pickup);
					if (m_pickupTrigger != Modifiers::EffectTrigger::Pickup)
						plr.m_record.GetModifiers().TriggerEffects(plr, plr, m_pickupTrigger);
				}
			}
			else
				PlaySound3D(m_sound, m_unit.GetPosition());

			return true;
		}

		return false;
	}

	bool NetPicked(UnitPtr unit)
	{
		if (!m_visible && Network::IsServer())
			return false;
		
		Picked(unit, true);
		PickedLocalFeedback();
		
		return true;
	}

	void PickedLocalFeedback()
	{
		PlaySound3D(m_sound, m_unit.GetPosition());
		Hide();
	}
	
	void Collide(UnitPtr unit, vec2 pos, vec2 normal)
	{
		if (!m_visible)
			return;

		ref@ b = unit.GetScriptBehavior();
		Player@ a = cast<Player>(b);
		if ((a is null && m_plrOnly) || (a !is null && a.m_record.IsDead()))
			return;
		
		bool picked = false;
		
		if (CanApplyEffects(m_effects, null, unit, xy(m_unit.GetPosition()), vec2(0, 0), 1.0, m_effectsIgnore))
		{
			if (!m_secure || Network::IsServer())
			{
				if (Picked(unit))
				{
					PickedLocalFeedback();
					picked = true;
					
					if (m_global)
						(Network::Message("UnitPicked") << m_unit << unit).SendToAll();

					if (a !is null)
						(Network::Message("PlayerPickups") << a.m_record.pickups << a.m_record.pickupsTotal).SendToAll();
				}
			}
			else
			{
				PickedLocalFeedback();
				picked = true;
				
				(Network::Message("UnitPickSecure") << m_unit << unit).SendToHost();
			}
		}
		
		if (picked && m_callbacks.length() > 0)
		{
			if (m_unit.GetUnitProducer().GetNetSyncMode() != NetSyncMode::None)
			{
				if (!Network::IsServer())
					(Network::Message("UnitPickCallback") << m_unit << unit).SendToHost();
				else
					CallbackPicked(unit);
			}
		}
	}
	
	void CallbackPicked(UnitPtr picker)
	{
		for (uint i = 0; i < m_callbacks.length(); i++)
			m_callbacks[i].UnitPicked(m_unit, picker);
	}
	

	void Update(int dt)
	{
		if (!m_visible)
		{
			Destroy();
			return;
		}

		if (m_bounce)
		{
			const int tPeriod = 1000;
	
			uint time = g_scene.GetTime() % tPeriod;
			float h = (sin(time * PI * 2 / tPeriod) + 1.0) * 1.5;

			m_unit.SetPositionZ(h, true);
		}
	}
	
	void Destroy()
	{
		if (m_shouldDestroy)
			m_unit.Destroy();
	}
	
}

int g_totalPickups;
int g_totalPickupsTotal;
