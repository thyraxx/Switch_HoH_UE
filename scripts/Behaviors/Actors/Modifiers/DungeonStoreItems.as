namespace Modifiers
{
	class DungeonStoreItems : Modifier
	{
		int m_num;

		DungeonStoreItems(UnitPtr unit, SValue& params)
		{
			m_num = GetParamInt(unit, params, "num");
		}

		ModDyn DynDungeonStoreItemsAdd() override { return ModDyn::Static; }
		int DungeonStoreItemsAdd() override
		{
			return m_num;
		}
	}
}
