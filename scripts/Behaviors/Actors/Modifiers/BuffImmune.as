namespace Modifiers
{
	class BuffImmune : Modifier
	{
		uint64 m_flags;

		BuffImmune(UnitPtr unit, SValue& params)
		{
			m_flags = GetBuffTags(params);
		}

		ModDyn DynImmuneBuffs() override { return ModDyn::Static; }
		uint64 ImmuneBuffs(PlayerBase@ player) override
		{
			return m_flags;
		}
	}
}
