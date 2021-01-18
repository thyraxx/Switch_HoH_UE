namespace Modifiers
{
	class CleaveRange : Modifier
	{
		float m_mul;

		CleaveRange(UnitPtr unit, SValue& params)
		{
			m_mul = GetParamFloat(unit, params, "mul", false, 1.0f);
		}

		ModDyn DynCleaveRangeMul() override { return ModDyn::Static; }
		float CleaveRangeMul(PlayerBase@ player, Actor@ enemy) override { return m_mul; }
	}
}
