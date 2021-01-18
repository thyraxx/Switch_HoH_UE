namespace Modifiers
{
	class Curse : Modifier
	{
		int m_add;
	
		Curse(UnitPtr unit, SValue& params)
		{
			m_add = GetParamInt(unit, params, "add", false, 0);
		}	

		ModDyn DynCursesAdd() override { return ModDyn::Static; }
		int CursesAdd(PlayerBase@ player) override { return m_add; }
	}
}