namespace Modifiers
{
	class ManaGain : Modifier
	{
		float m_scale;
		float m_dmgScale;

		ManaGain(UnitPtr unit, SValue& params)
		{
			m_scale = GetParamFloat(unit, params, "scale", false, 1);
			m_dmgScale = GetParamFloat(unit, params, "damage-scale", false, 1);
		}

		ModDyn DynManaGainScale() override { return ModDyn::Static; }
		ModDyn DynManaDamageTakenMul() override { return ModDyn::Static; }

		float ManaGainScale(PlayerBase@ player) override { return m_scale; }
		float ManaDamageTakenMul(PlayerBase@ player) override { return m_dmgScale; }
	}
}
