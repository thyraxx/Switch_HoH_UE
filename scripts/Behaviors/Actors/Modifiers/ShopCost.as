namespace Modifiers
{
	class ShopCost : Modifier
	{
		float m_mul;

		ShopCost(UnitPtr unit, SValue& params)
		{
			m_mul = GetParamFloat(unit, params, "mul");
		}

		ModDyn DynShopCostMul() override { return ModDyn::Static; }
		float ShopCostMul(PlayerBase@ player, Upgrades::UpgradeStep@ step) override
		{
			return m_mul;
		}
	}
}
