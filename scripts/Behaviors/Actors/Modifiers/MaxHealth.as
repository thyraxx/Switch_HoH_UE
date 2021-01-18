namespace Modifiers
{
	class MaxHealth : Modifier
	{
		float m_mul;

		MaxHealth(UnitPtr unit, SValue& params)
		{
			m_mul = GetParamFloat(unit, params, "mul");
		}

		ModDyn DynMaxHealthMul() override { return ModDyn::Static; }
		float MaxHealthMul(PlayerBase@ player) override { return m_mul; }
	}
}
