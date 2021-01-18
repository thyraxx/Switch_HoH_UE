class EffectBehavior
{
	UnitPtr m_unit;
	uint m_ttl;
	bool m_looping;
	EffectParams@ m_params;
	array<WorldScript@> m_finishTriggers;

	EffectBehavior(UnitPtr unit, SValue& params)
	{
		m_unit = unit;
		m_ttl = 1000;
		m_unit.SetUpdateDistanceLimit(300);
	}
	
	void Initialize(UnitScene@ scene, bool attachToUnit = false)
	{
		if (scene is null)
			return;
	
		@m_params = null;
		m_unit.SetUnitScene(scene, true);
		m_ttl = g_scene.GetTime() + scene.Length();
		auto d = scene.FetchData("data");
		
		if (d !is null)
		{
			if (attachToUnit)
			{
				PlaySound3D(Resources::GetSoundEvent(GetParamString(m_unit, d, "sound", false)), m_unit);
				PlayEffect(GetParamString(m_unit, d, "fx", false), m_unit);
			}
			else
			{
				PlaySound3D(Resources::GetSoundEvent(GetParamString(m_unit, d, "sound", false)), m_unit.GetPosition());
				PlayEffect(GetParamString(m_unit, d, "fx", false), m_unit.GetPosition());
			}
			
			auto gore = LoadGore(GetParamString(m_unit, d, "gore", false));
			if (gore !is null)
				gore.OnDeath(1.0, xy(m_unit.GetPosition()));
		}
	}

	void Initialize(UnitScene@ scene, dictionary params, bool attachToUnit = false)
	{
		Initialize(scene, attachToUnit);
		
		@m_params = m_unit.CreateEffectParams();

		auto keys = params.getKeys();
		for (uint i = 0; i < keys.length(); i++)
		{
			float val;
			params.get(keys[i], val);
			m_params.Set(keys[i], val);
		}
	}

	void Initialize(UnitScene@ scene, EffectParams@ params)
	{
		Initialize(scene);
		
		@m_params = m_unit.CreateEffectParams(params);
	}
	

	void SetParam(string param, float value)
	{
		if (m_params !is null)
			m_params.Set(param, value);
	}

	void Update(int dt)
	{
		if (!m_looping && m_ttl < g_scene.GetTime())
		{
			m_unit.Destroy();
			if (Network::IsServer())
			{
				for (uint i = 0; i < m_finishTriggers.length(); i++)
					m_finishTriggers[i].Execute();
			}
		}
	}
}