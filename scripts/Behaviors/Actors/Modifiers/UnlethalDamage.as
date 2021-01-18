namespace Modifiers
{
	class UnlethalDamage : Modifier
	{
		UnlethalDamage(UnitPtr unit, SValue& params)
		{
		}

		ModDyn DynNonLethalDamage() override { return ModDyn::Static; }
		bool HasNonLethalDamage() override { return true; }
		bool NonLethalDamage(PlayerBase@ player, DamageInfo& dmg) override
		{
			return true;
		}
	}
}
