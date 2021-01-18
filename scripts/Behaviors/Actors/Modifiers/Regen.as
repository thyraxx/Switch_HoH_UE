namespace Modifiers
{
	class Regen : Modifier
	{
		vec2 m_add;
		vec2 m_mul;
	
		Regen(UnitPtr unit, SValue& params)
		{
			m_add = vec2(
				GetParamFloat(unit, params, "health", false, 0),
				GetParamFloat(unit, params, "mana", false, 0)
			);
			
			m_mul = vec2(
				GetParamFloat(unit, params, "health-mul", false, 1),
				GetParamFloat(unit, params, "mana-mul", false, 1)
			);
		}
		
		ModDyn DynRegenAdd() override { return (m_add.x != 0 || m_add.y != 0) ? ModDyn::Static : ModDyn::None; }
		ModDyn DynRegenMul() override { return (m_mul.x != 1.0f || m_mul.y != 1.0f) ? ModDyn::Static : ModDyn::None; }

		vec2 RegenAdd(PlayerBase@ player) override { return m_add; }
		vec2 RegenMul(PlayerBase@ player) override { return m_mul; }
	}
}