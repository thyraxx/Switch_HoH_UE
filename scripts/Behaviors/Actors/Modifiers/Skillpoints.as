namespace Modifiers
{
	class Skillpoints : Modifier
	{
		int m_num;

		Skillpoints(UnitPtr unit, SValue& params)
		{
			m_num = GetParamInt(unit, params, "num", false, 0);
		}

		ModDyn DynSkillpointsAdd() override { return ModDyn::Static; }
		int SkillpointsAdd(PlayerBase@ player) override
		{
			return m_num;
		}
	}
}
