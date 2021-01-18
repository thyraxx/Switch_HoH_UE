namespace Modifiers
{
	class Damage : Modifier
	{
		ivec2 m_power;
		ivec2 m_bonusAttack;
		vec2 m_damageMul;
	
	
		Damage()
		{
			m_damageMul = vec2(1, 1);
		}

		Damage(UnitPtr unit, SValue& params)
		{
			m_power = ivec2(
				GetParamInt(unit, params, "attack-power", false, 0),
				GetParamInt(unit, params, "spell-power", false, 0));
				
			m_bonusAttack = ivec2(
				GetParamInt(unit, params, "physical-add", false, 0),
				GetParamInt(unit, params, "magical-add", false, 0));

			m_damageMul = vec2(
				GetParamFloat(unit, params, "attack-mul", false, 1),
				GetParamFloat(unit, params, "spell-mul", false, 1));
		
			m_damageMul *= GetParamFloat(unit, params, "mul", false, 1);
		}
		
		ModDyn DynDamagePower() override { return (m_power.x != 0 || m_power.y != 0) ? ModDyn::Static : ModDyn::None; }
		ModDyn DynAttackDamageAdd() override { return (m_bonusAttack.x != 0 || m_bonusAttack.y != 0) ? ModDyn::Static : ModDyn::None; }
		ModDyn DynDamageMul() override { return (m_damageMul.x != 1.0f || m_damageMul.y != 1.0f) ? ModDyn::Static : ModDyn::None; }
		
		ivec2 DamagePower(PlayerBase@ player, Actor@ enemy) override { return m_power; }
		ivec2 AttackDamageAdd(PlayerBase@ player, Actor@ enemy, DamageInfo@ di) override { return m_bonusAttack; }
		vec2 DamageMul(PlayerBase@ player, Actor@ enemy) override { return m_damageMul; }
	}
}