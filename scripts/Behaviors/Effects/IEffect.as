interface IEffect
{
	bool Apply(Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, bool husk);
	bool CanApply(Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity);
	void SetWeaponInformation(uint weapon);
}

interface IEffectCopyable
{
	IEffect@ Copy();
}

class NullEffect : IEffect, IEffectCopyable
{
	bool Apply(Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, bool husk) { return false; }
	bool CanApply(Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity) { return false; }
	void SetWeaponInformation(uint weapon) {}
	IEffect@ Copy() { return this; }
}


bool FilterHuskDamage(Actor@ owner, UnitPtr target, bool husk)
{
	bool tHusk = (owner !is null) ? owner.IsHusk() : !Network::IsServer();
	//if (husk != tHusk)
	//	PrintError("Damage husk and Owner husk does not match!");

	
	auto player = cast<PlayerBase>(target.GetScriptBehavior());
	if (player !is null)
		return !player.IsHusk(); // && !husk;
	
	return !tHusk;
}

array<IEffect@>@ LoadEffects(UnitPtr owner, SValue& params, string prefix = "")
{
%PROFILE_START LoadEffects
	array<IEffect@> effects;

	array<SValue@>@ effectArr = GetParamArray(owner, params, prefix + "effects", false);
	if (effectArr !is null)
	{
		for (uint i = 0; i < effectArr.length(); i++)
		{
			string c = GetParamString(owner, effectArr[i], "class");
			IEffect@ effect = cast<IEffect>(InstantiateClass(c, owner, effectArr[i]));
			
			if (effect is null)
			{
				PrintError(c + " is not an IEffect!");
				effects.insertLast(NullEffect());
			}
			else
				effects.insertLast(effect);
		}
	}
	else
	{
		SValue@ dat = GetParamDictionary(owner, params, prefix + "effect", false);
		if (dat !is null)
		{
			string c = GetParamString(owner, dat, "class");
			IEffect@ effect = cast<IEffect>(InstantiateClass(c, owner, dat));
			
			if (effect is null)
			{
				PrintError(c + " is not an IEffect!");
				effects.insertLast(NullEffect());
			}
			else
				effects.insertLast(effect);
		}
	}
%PROFILE_STOP
	return effects;
}

array<IEffect@>@ CopyOrLoadEffects(array<IEffect@>@ copyFrom, UnitPtr owner, SValue& params, string prefix = "")
{
	array<IEffect@> effects;
	if (copyFrom is null || copyFrom.length() <= 0)
		return effects;

%PROFILE_START CopyOrLoadEffects
	uint copyFromLen = copyFrom.length();
	bool needToCreate = false;
	for (uint i = 0; i < copyFromLen; i++)
	{
		auto copyable = cast<IEffectCopyable>(copyFrom[i]);
		IEffect@ copy = null;
		
		if (copyable !is null)
			@copy = copyable.Copy();
		
		if (copy is null)
			needToCreate = true;

		effects.insertLast(copy);
	}

	if (needToCreate)
	{
		array<SValue@>@ effectArr = GetParamArray(owner, params, prefix + "effects", false);
		if (effectArr !is null)
		{
			uint effectsLen = effects.length();
			for (uint i = 0; i < effectsLen; i++)
			{
				if (effects[i] !is null)
					continue;
		
				string c = GetParamString(owner, effectArr[i], "class");
				@effects[i] = cast<IEffect>(InstantiateClass(c, owner, effectArr[i]));
				
				if (effects[i] is null)
				{
					@effects[i] = NullEffect();
					PrintError(c + " is not an IEffect!");
				}
			}
		}
		else
		{
			SValue@ dat = GetParamDictionary(owner, params, prefix + "effect", false);
			if (dat !is null)
			{
				string c = GetParamString(owner, dat, "class");
				@effects[0] = cast<IEffect>(InstantiateClass(c, owner, dat));
				
				if (effects[0] is null)
				{
					@effects[0] = NullEffect();
					PrintError(c + " is not an IEffect!");
				}
			}
		}
	}
%PROFILE_STOP
	return effects;
}


bool ApplyEffects(array<IEffect@>@ effects, Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, bool husk)
{
	bool any = false;
	for (uint i = 0; i < effects.length(); i++)
	{
		if (effects[i].Apply(owner, target, pos, dir, intensity, husk))
			any = true;
	}

	return any;
}

bool ApplyEffects(array<IEffect@>@ effects, Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, bool husk, float selfDmg, float teamDmg, float enemyDmg = 1.0)
{
	Actor@ a = cast<Actor>(target.GetScriptBehavior());
	float f = FilterAction(a, owner, selfDmg, teamDmg, enemyDmg, 1.0);

	bool any = false;
	for (uint i = 0; i < effects.length(); i++)
	{
		if (f <= 0)
			continue;

		if (effects[i].Apply(owner, target, pos, dir, f * intensity, husk))
			any = true;
	}

	return any;
}

bool CanApplyEffects(array<IEffect@>@ effects, Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity)
{
	for (uint i = 0; i < effects.length(); i++)
	{
		if (effects[i].CanApply(owner, target, pos, dir, intensity))
			return true;
	}
	return false;
}

bool CanApplyEffects(array<IEffect@>@ effects, Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, array<IEffect@>@ ignoreEffects)
{
	for (uint i = 0; i < effects.length(); i++)
	{
		auto effect = effects[i];

		if (ignoreEffects.findByRef(effect) != -1)
			continue;

		if (effect.CanApply(owner, target, pos, dir, intensity))
			return true;
	}
	return false;
}

bool CanApplyEffects(array<IEffect@>@ effects, Actor@ owner, UnitPtr target, vec2 pos, vec2 dir, float intensity, float selfDmg, float teamDmg)
{
	Actor@ a = cast<Actor>(target.GetScriptBehavior());
	float f = FilterAction(a, owner, selfDmg, teamDmg, 1.0);

	for (uint i = 0; i < effects.length(); i++)
	{
		if (f <= 0)
			continue;

		if (effects[i].CanApply(owner, target, pos, dir, f * intensity))
			return true;
	}

	return false;
}

void PropagateWeaponInformation(array<IEffect@>@ effects, uint weapon)
{
	if (effects is null)
		return;
		
	for (uint i = 0; i < effects.length(); i++)
		effects[i].SetWeaponInformation(weapon);
}
