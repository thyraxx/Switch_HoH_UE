namespace Modifiers
{
	class Luck : Modifier
	{
		float m_luck;
	
		Luck(UnitPtr unit, SValue& params)
		{
			m_luck = GetParamFloat(unit, params, "add", false, 0);
		}	

		ModDyn DynLuckAdd() override { return ModDyn::Static; }
		float LuckAdd(PlayerBase@ player) override { return m_luck; }
	}
}