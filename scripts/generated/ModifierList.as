namespace Modifiers {interface IModifierListBase { void RefreshCache(); }
mixin class ModifierListBase : IModifierListBase
{
	array<Modifier@> m_modifiers;		void RefreshCache()
		{

%PROFILE_START ModifierListBase::RefreshCache
			array<array<Modifier@>@> modListList = { m_modsArmorAdd, m_modsArmorMul, m_modsDamageTakenMul, m_modsManaDamageTakenMul, m_modsDamageBlock, m_modsDamageBlockMul, m_modsEvasion, m_modsProjectileBlock, m_modsNonLethalDamage, m_modsDamagePower, m_modsAttackDamageAdd, m_modsSpellDamageAdd, m_modsDamageMul, m_modsSpellCostMul, m_modsCrit, m_modsCritMul, m_modsCritMulAdd, m_modsArmorIgnore, m_modsLifesteal, m_modsStatsAdd, m_modsMaxHealthMul, m_modsMoveSpeedAdd, m_modsMoveSpeedMul, m_modsSkillMoveSpeedMul, m_modsSkillMoveSpeedClear, m_modsRegenAdd, m_modsRegenMul, m_modsExpMul, m_modsExpMulAdd, m_modsPotionCharges, m_modsPotionHealMul, m_modsPotionManaMul, m_modsTaxMidpoint, m_modsTaxMidpointMul, m_modsGoldGainScale, m_modsGoldGainScaleAdd, m_modsOreGainScale, m_modsKeyGainScale, m_modsAllHealthGainScale, m_modsHealthGainScale, m_modsManaGainScale, m_modsManaFromDamage, m_modsSkillTimeMul, m_modsAttackTimeMul, m_modsDamageTaken, m_modsTriggerEffects, m_modsUpdate, m_modsComboEffects, m_modsComboProps, m_modsComboDisabled, m_modsCleaveRangeMul, m_modsWindScale, m_modsBuffScale, m_modsDebuffScale, m_modsImmuneBuffs, m_modsSlowScale, m_modsCooldownClear, m_modsLuckAdd, m_modsCursesAdd, m_modsSkillpointsAdd, m_modsShopCostMul, m_modsDungeonStoreItemsAdd }; 
			m_modsArmorAddConst = vec2();
m_modsArmorMulConst = vec2(1, 1);
m_modsDamageTakenMulConst = 1;
m_modsManaDamageTakenMulConst = 1;
m_modsDamageBlockConst = ivec2();
m_modsDamageBlockMulConst = vec2(1, 1);
m_modsEvasionConst = false;
m_modsProjectileBlockConst = false;
m_modsNonLethalDamageConst = false;
m_modsDamagePowerConst = ivec2();
m_modsAttackDamageAddConst = ivec2();
m_modsSpellDamageAddConst = ivec2();
m_modsDamageMulConst = vec2(1, 1);
m_modsSpellCostMulConst = 1;
m_modsCritConst = 0;
m_modsCritMulConst = 1;
m_modsCritMulAddConst = 0;
m_modsArmorIgnoreConst = vec2(1, 1);
m_modsLifestealConst = 0;
m_modsStatsAddConst = ivec2();
m_modsMaxHealthMulConst = 1;
m_modsMoveSpeedAddConst = 0;
m_modsMoveSpeedMulConst = 1;
m_modsSkillMoveSpeedMulConst = 1;
m_modsSkillMoveSpeedClearConst = false;
m_modsRegenAddConst = vec2();
m_modsRegenMulConst = vec2(1, 1);
m_modsExpMulConst = 1;
m_modsExpMulAddConst = 0;
m_modsPotionChargesConst = 0;
m_modsPotionHealMulConst = 1;
m_modsPotionManaMulConst = 1;
m_modsTaxMidpointConst = 0;
m_modsTaxMidpointMulConst = 1;
m_modsGoldGainScaleConst = 1;
m_modsGoldGainScaleAddConst = 0;
m_modsOreGainScaleConst = 1;
m_modsKeyGainScaleConst = 1;
m_modsAllHealthGainScaleConst = 1;
m_modsHealthGainScaleConst = 1;
m_modsManaGainScaleConst = 1;
m_modsManaFromDamageConst = 0;
m_modsSkillTimeMulConst = 1;
m_modsAttackTimeMulConst = 1;
m_modsComboPropsConst = ivec3();
m_modsComboDisabledConst = false;
m_modsCleaveRangeMulConst = 1;
m_modsWindScaleConst = 1;
m_modsBuffScaleConst = 1;
m_modsDebuffScaleConst = 1;
m_modsImmuneBuffsConst = 0;
m_modsSlowScaleConst = 1;
m_modsCooldownClearConst = false;
m_modsLuckAddConst = 0;
m_modsCursesAddConst = 0;
m_modsSkillpointsAddConst = 0;
m_modsShopCostMulConst = 1;
m_modsDungeonStoreItemsAddConst = 0;
			m_triggerEffects = 0;
			
			for (uint i = 0; i < modListList.length(); i++) 
				modListList[i].removeRange(0, modListList[i].length());

			uint ml = m_modifiers.length();
			for (uint i = 0; i < ml; i++)
			{
				auto modifier = m_modifiers[i];
				
				auto modList = cast<IModifierListBase@>(modifier);
				if (modList !is null)
					modList.RefreshCache();
				
auto dyn = ModDyn::None;

dyn = modifier.DynArmorAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsArmorAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ArmorAdd(null, null);
  m_modsArmorAddConst += val;
}


dyn = modifier.DynArmorMul();
if (dyn == ModDyn::Dynamic)
  { m_modsArmorMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ArmorMul(null, null);
  m_modsArmorMulConst *= val;
}


dyn = modifier.DynDamageTakenMul();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageTakenMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageTakenMul(null, DamageInfo());
  m_modsDamageTakenMulConst *= val;
}


dyn = modifier.DynManaDamageTakenMul();
if (dyn == ModDyn::Dynamic)
  { m_modsManaDamageTakenMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ManaDamageTakenMul(null);
  m_modsManaDamageTakenMulConst *= val;
}


dyn = modifier.DynDamageBlock();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageBlock.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageBlock(null, null);
  m_modsDamageBlockConst += val;
}


dyn = modifier.DynDamageBlockMul();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageBlockMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageBlockMul(null, null);
  m_modsDamageBlockMulConst *= val;
}


dyn = modifier.DynEvasion();
if (dyn == ModDyn::Dynamic)
  { m_modsEvasion.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.Evasion(null, null);
  m_modsEvasionConst = m_modsEvasionConst || val;
}


dyn = modifier.DynProjectileBlock();
if (dyn == ModDyn::Dynamic)
  { m_modsProjectileBlock.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ProjectileBlock(null, null);
  m_modsProjectileBlockConst = m_modsProjectileBlockConst || val;
}


dyn = modifier.DynNonLethalDamage();
if (dyn == ModDyn::Dynamic)
  { m_modsNonLethalDamage.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.NonLethalDamage(null, DamageInfo());
  m_modsNonLethalDamageConst = m_modsNonLethalDamageConst || val;
}


dyn = modifier.DynDamagePower();
if (dyn == ModDyn::Dynamic)
  { m_modsDamagePower.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamagePower(null, null);
  m_modsDamagePowerConst += val;
}


dyn = modifier.DynAttackDamageAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsAttackDamageAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.AttackDamageAdd(null, null, null);
  m_modsAttackDamageAddConst += val;
}


dyn = modifier.DynSpellDamageAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsSpellDamageAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SpellDamageAdd(null, null, null);
  m_modsSpellDamageAddConst += val;
}


dyn = modifier.DynDamageMul();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageMul(null, null);
  m_modsDamageMulConst += val - vec2(1,1);
}


dyn = modifier.DynSpellCostMul();
if (dyn == ModDyn::Dynamic)
  { m_modsSpellCostMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SpellCostMul(null);
  m_modsSpellCostMulConst *= val;
}


dyn = modifier.DynCrit();
if (dyn == ModDyn::Dynamic)
  { m_modsCrit.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.Crit(null, null, false);
  m_modsCritConst += val;
}


dyn = modifier.DynCritMul();
if (dyn == ModDyn::Dynamic)
  { m_modsCritMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CritMul(null, null, false);
  m_modsCritMulConst += val - 1;
}


dyn = modifier.DynCritMulAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsCritMulAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CritMulAdd(null, null, false);
  m_modsCritMulAddConst += val;
}


dyn = modifier.DynArmorIgnore();
if (dyn == ModDyn::Dynamic)
  { m_modsArmorIgnore.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ArmorIgnore(null, null, false);
  m_modsArmorIgnoreConst *= val;
}


dyn = modifier.DynLifesteal();
if (dyn == ModDyn::Dynamic)
  { m_modsLifesteal.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.Lifesteal(null, null, false, 0);
  m_modsLifestealConst += val;
}


dyn = modifier.DynStatsAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsStatsAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.StatsAdd(null);
  m_modsStatsAddConst += val;
}


dyn = modifier.DynMaxHealthMul();
if (dyn == ModDyn::Dynamic)
  { m_modsMaxHealthMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.MaxHealthMul(null);
  m_modsMaxHealthMulConst *= val;
}


dyn = modifier.DynMoveSpeedAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsMoveSpeedAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.MoveSpeedAdd(null, 0);
  m_modsMoveSpeedAddConst += val;
}


dyn = modifier.DynMoveSpeedMul();
if (dyn == ModDyn::Dynamic)
  { m_modsMoveSpeedMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.MoveSpeedMul(null, 0);
  m_modsMoveSpeedMulConst *= val;
}


dyn = modifier.DynSkillMoveSpeedMul();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillMoveSpeedMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillMoveSpeedMul(null, 0);
  m_modsSkillMoveSpeedMulConst *= val;
}


dyn = modifier.DynSkillMoveSpeedClear();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillMoveSpeedClear.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillMoveSpeedClear(null, 0);
  m_modsSkillMoveSpeedClearConst = m_modsSkillMoveSpeedClearConst || val;
}


dyn = modifier.DynRegenAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsRegenAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.RegenAdd(null);
  m_modsRegenAddConst += val;
}


dyn = modifier.DynRegenMul();
if (dyn == ModDyn::Dynamic)
  { m_modsRegenMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.RegenMul(null);
  m_modsRegenMulConst *= val;
}


dyn = modifier.DynExpMul();
if (dyn == ModDyn::Dynamic)
  { m_modsExpMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ExpMul(null, null);
  m_modsExpMulConst += val - 1;
}


dyn = modifier.DynExpMulAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsExpMulAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ExpMulAdd(null, null);
  m_modsExpMulAddConst += val;
}


dyn = modifier.DynPotionCharges();
if (dyn == ModDyn::Dynamic)
  { m_modsPotionCharges.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.PotionCharges();
  m_modsPotionChargesConst += val;
}


dyn = modifier.DynPotionHealMul();
if (dyn == ModDyn::Dynamic)
  { m_modsPotionHealMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.PotionHealMul(null);
  m_modsPotionHealMulConst *= val;
}


dyn = modifier.DynPotionManaMul();
if (dyn == ModDyn::Dynamic)
  { m_modsPotionManaMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.PotionManaMul(null);
  m_modsPotionManaMulConst *= val;
}


dyn = modifier.DynTaxMidpoint();
if (dyn == ModDyn::Dynamic)
  { m_modsTaxMidpoint.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.TaxMidpoint();
  m_modsTaxMidpointConst += val;
}


dyn = modifier.DynTaxMidpointMul();
if (dyn == ModDyn::Dynamic)
  { m_modsTaxMidpointMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.TaxMidpointMul();
  m_modsTaxMidpointMulConst *= val;
}


dyn = modifier.DynGoldGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsGoldGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.GoldGainScale(null);
  m_modsGoldGainScaleConst += val - 1;
}


dyn = modifier.DynGoldGainScaleAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsGoldGainScaleAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.GoldGainScaleAdd(null);
  m_modsGoldGainScaleAddConst += val;
}


dyn = modifier.DynOreGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsOreGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.OreGainScale(null);
  m_modsOreGainScaleConst += val - 1;
}


dyn = modifier.DynKeyGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsKeyGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.KeyGainScale(null);
  m_modsKeyGainScaleConst += val - 1;
}


dyn = modifier.DynAllHealthGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsAllHealthGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.AllHealthGainScale(null);
  m_modsAllHealthGainScaleConst *= val;
}


dyn = modifier.DynHealthGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsHealthGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.HealthGainScale(null);
  m_modsHealthGainScaleConst *= val;
}


dyn = modifier.DynManaGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsManaGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ManaGainScale(null);
  m_modsManaGainScaleConst *= val;
}


dyn = modifier.DynManaFromDamage();
if (dyn == ModDyn::Dynamic)
  { m_modsManaFromDamage.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ManaFromDamage(null, 0);
  m_modsManaFromDamageConst += val;
}


dyn = modifier.DynSkillTimeMul();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillTimeMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillTimeMul(null);
  m_modsSkillTimeMulConst += val - 1;
}


dyn = modifier.DynAttackTimeMul();
if (dyn == ModDyn::Dynamic)
  { m_modsAttackTimeMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.AttackTimeMul(null);
  m_modsAttackTimeMulConst += val - 1;
}


dyn = modifier.DynDamageTaken();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageTaken.insertLast(modifier); }

dyn = modifier.DynTriggerEffects();
if (dyn == ModDyn::Dynamic)
  { m_modsTriggerEffects.insertLast(modifier); m_triggerEffects |= modifier.m_triggerEffects; }

dyn = modifier.DynUpdate();
if (dyn == ModDyn::Dynamic)
  { m_modsUpdate.insertLast(modifier); }

dyn = modifier.DynComboEffects();
if (dyn == ModDyn::Dynamic)
  { m_modsComboEffects.insertLast(modifier); }

dyn = modifier.DynComboProps();
if (dyn == ModDyn::Dynamic)
  { m_modsComboProps.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ComboProps(null);
  m_modsComboPropsConst += val;
}


dyn = modifier.DynComboDisabled();
if (dyn == ModDyn::Dynamic)
  { m_modsComboDisabled.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ComboDisabled(null);
  m_modsComboDisabledConst = m_modsComboDisabledConst || val;
}


dyn = modifier.DynCleaveRangeMul();
if (dyn == ModDyn::Dynamic)
  { m_modsCleaveRangeMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CleaveRangeMul(null, null);
  m_modsCleaveRangeMulConst *= val;
}


dyn = modifier.DynWindScale();
if (dyn == ModDyn::Dynamic)
  { m_modsWindScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.WindScale(null);
  m_modsWindScaleConst *= val;
}


dyn = modifier.DynBuffScale();
if (dyn == ModDyn::Dynamic)
  { m_modsBuffScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.BuffScale(null);
  m_modsBuffScaleConst *= val;
}


dyn = modifier.DynDebuffScale();
if (dyn == ModDyn::Dynamic)
  { m_modsDebuffScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DebuffScale(null);
  m_modsDebuffScaleConst *= val;
}


dyn = modifier.DynImmuneBuffs();
if (dyn == ModDyn::Dynamic)
  { m_modsImmuneBuffs.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ImmuneBuffs(null);
  m_modsImmuneBuffsConst |= val;
}


dyn = modifier.DynSlowScale();
if (dyn == ModDyn::Dynamic)
  { m_modsSlowScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SlowScale(null);
  m_modsSlowScaleConst *= val;
}


dyn = modifier.DynCooldownClear();
if (dyn == ModDyn::Dynamic)
  { m_modsCooldownClear.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CooldownClear(null, null);
  m_modsCooldownClearConst = m_modsCooldownClearConst || val;
}


dyn = modifier.DynLuckAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsLuckAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.LuckAdd(null);
  m_modsLuckAddConst += val;
}


dyn = modifier.DynCursesAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsCursesAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CursesAdd(null);
  m_modsCursesAddConst += val;
}


dyn = modifier.DynSkillpointsAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillpointsAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillpointsAdd(null);
  m_modsSkillpointsAddConst += val;
}


dyn = modifier.DynShopCostMul();
if (dyn == ModDyn::Dynamic)
  { m_modsShopCostMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ShopCostMul(null, null);
  m_modsShopCostMulConst *= val;
}


dyn = modifier.DynDungeonStoreItemsAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsDungeonStoreItemsAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DungeonStoreItemsAdd();
  m_modsDungeonStoreItemsAddConst += val;
}

			}		

%PROFILE_STOP
		}
	}

class ModifierList : Modifier, ModifierListBase
{
	string m_id;
	string m_name;

	ModifierList() { m_triggerEffects = 0; }
	ModifierList(string id) { m_triggerEffects = 0; m_id = id; }
	ModifierList(array<Modifier@> modifiers)
	{
		m_triggerEffects = 0;
		for (uint i = 0; i < modifiers.length(); i++)
			Add(modifiers[i]);
	}vec2 m_modsArmorAddConst = vec2();
array<Modifier@> m_modsArmorAdd;
vec2 ArmorAdd(PlayerBase@ p0, Actor@ p1) override { vec2 ret = m_modsArmorAddConst; 
%PROFILE_START ModifiersList:ArmorAdd
uint ml = m_modsArmorAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsArmorAdd[i].ArmorAdd(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynArmorAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynArmorAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasArmorAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynArmorAdd() != ModDyn::None) return true; return false; }

vec2 m_modsArmorMulConst = vec2(1, 1);
array<Modifier@> m_modsArmorMul;
vec2 ArmorMul(PlayerBase@ p0, Actor@ p1) override { vec2 ret = m_modsArmorMulConst; 
%PROFILE_START ModifiersList:ArmorMul
uint ml = m_modsArmorMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsArmorMul[i].ArmorMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynArmorMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynArmorMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasArmorMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynArmorMul() != ModDyn::None) return true; return false; }

float m_modsDamageTakenMulConst = 1;
array<Modifier@> m_modsDamageTakenMul;
float DamageTakenMul(PlayerBase@ p0, DamageInfo& p1) override { float ret = m_modsDamageTakenMulConst; 
%PROFILE_START ModifiersList:DamageTakenMul
uint ml = m_modsDamageTakenMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsDamageTakenMul[i].DamageTakenMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynDamageTakenMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDamageTakenMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDamageTakenMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDamageTakenMul() != ModDyn::None) return true; return false; }

float m_modsManaDamageTakenMulConst = 1;
array<Modifier@> m_modsManaDamageTakenMul;
float ManaDamageTakenMul(PlayerBase@ p0) override { float ret = m_modsManaDamageTakenMulConst; 
%PROFILE_START ModifiersList:ManaDamageTakenMul
uint ml = m_modsManaDamageTakenMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsManaDamageTakenMul[i].ManaDamageTakenMul(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynManaDamageTakenMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynManaDamageTakenMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasManaDamageTakenMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynManaDamageTakenMul() != ModDyn::None) return true; return false; }

ivec2 m_modsDamageBlockConst = ivec2();
array<Modifier@> m_modsDamageBlock;
ivec2 DamageBlock(PlayerBase@ p0, Actor@ p1) override { ivec2 ret = m_modsDamageBlockConst; 
%PROFILE_START ModifiersList:DamageBlock
uint ml = m_modsDamageBlock.length(); for (uint i = 0; i < ml; i++) { ret += m_modsDamageBlock[i].DamageBlock(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynDamageBlock() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDamageBlock(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDamageBlock() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDamageBlock() != ModDyn::None) return true; return false; }

vec2 m_modsDamageBlockMulConst = vec2(1, 1);
array<Modifier@> m_modsDamageBlockMul;
vec2 DamageBlockMul(PlayerBase@ p0, Actor@ p1) override { vec2 ret = m_modsDamageBlockMulConst; 
%PROFILE_START ModifiersList:DamageBlockMul
uint ml = m_modsDamageBlockMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsDamageBlockMul[i].DamageBlockMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynDamageBlockMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDamageBlockMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDamageBlockMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDamageBlockMul() != ModDyn::None) return true; return false; }

bool m_modsEvasionConst = false;
array<Modifier@> m_modsEvasion;
bool Evasion(PlayerBase@ p0, Actor@ p1) override { bool ret = false; 
%PROFILE_START ModifiersList:Evasion
uint ml = m_modsEvasion.length(); for (uint i = 0; i < ml; i++) { if (m_modsEvasion[i].Evasion(p0, p1)) 
%PROFILE_STOP
return true; } 
%PROFILE_STOP
return ret; }
ModDyn DynEvasion() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynEvasion(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasEvasion() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynEvasion() != ModDyn::None) return true; return false; }

bool m_modsProjectileBlockConst = false;
array<Modifier@> m_modsProjectileBlock;
bool ProjectileBlock(PlayerBase@ p0, IProjectile@ p1) override { bool ret = false; 
%PROFILE_START ModifiersList:ProjectileBlock
uint ml = m_modsProjectileBlock.length(); for (uint i = 0; i < ml; i++) { if (m_modsProjectileBlock[i].ProjectileBlock(p0, p1)) 
%PROFILE_STOP
return true; } 
%PROFILE_STOP
return ret; }
ModDyn DynProjectileBlock() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynProjectileBlock(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasProjectileBlock() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynProjectileBlock() != ModDyn::None) return true; return false; }

bool m_modsNonLethalDamageConst = false;
array<Modifier@> m_modsNonLethalDamage;
bool NonLethalDamage(PlayerBase@ p0, DamageInfo& p1) override { bool ret = false; 
%PROFILE_START ModifiersList:NonLethalDamage
uint ml = m_modsNonLethalDamage.length(); for (uint i = 0; i < ml; i++) { if (m_modsNonLethalDamage[i].NonLethalDamage(p0, p1)) 
%PROFILE_STOP
return true; } 
%PROFILE_STOP
return ret; }
ModDyn DynNonLethalDamage() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynNonLethalDamage(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasNonLethalDamage() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynNonLethalDamage() != ModDyn::None) return true; return false; }

ivec2 m_modsDamagePowerConst = ivec2();
array<Modifier@> m_modsDamagePower;
ivec2 DamagePower(PlayerBase@ p0, Actor@ p1) override { ivec2 ret = m_modsDamagePowerConst; 
%PROFILE_START ModifiersList:DamagePower
uint ml = m_modsDamagePower.length(); for (uint i = 0; i < ml; i++) { ret += m_modsDamagePower[i].DamagePower(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynDamagePower() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDamagePower(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDamagePower() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDamagePower() != ModDyn::None) return true; return false; }

ivec2 m_modsAttackDamageAddConst = ivec2();
array<Modifier@> m_modsAttackDamageAdd;
ivec2 AttackDamageAdd(PlayerBase@ p0, Actor@ p1, DamageInfo@ p2) override { ivec2 ret = m_modsAttackDamageAddConst; 
%PROFILE_START ModifiersList:AttackDamageAdd
uint ml = m_modsAttackDamageAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsAttackDamageAdd[i].AttackDamageAdd(p0, p1, p2); } 
%PROFILE_STOP
return ret; }
ModDyn DynAttackDamageAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynAttackDamageAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasAttackDamageAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynAttackDamageAdd() != ModDyn::None) return true; return false; }

ivec2 m_modsSpellDamageAddConst = ivec2();
array<Modifier@> m_modsSpellDamageAdd;
ivec2 SpellDamageAdd(PlayerBase@ p0, Actor@ p1, DamageInfo@ p2) override { ivec2 ret = m_modsSpellDamageAddConst; 
%PROFILE_START ModifiersList:SpellDamageAdd
uint ml = m_modsSpellDamageAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsSpellDamageAdd[i].SpellDamageAdd(p0, p1, p2); } 
%PROFILE_STOP
return ret; }
ModDyn DynSpellDamageAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSpellDamageAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSpellDamageAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSpellDamageAdd() != ModDyn::None) return true; return false; }

vec2 m_modsDamageMulConst = vec2(1, 1);
array<Modifier@> m_modsDamageMul;
vec2 DamageMul(PlayerBase@ p0, Actor@ p1) override { vec2 ret = m_modsDamageMulConst; 
%PROFILE_START ModifiersList:DamageMul
uint ml = m_modsDamageMul.length(); for (uint i = 0; i < ml; i++) { ret += m_modsDamageMul[i].DamageMul(p0, p1) - vec2(1,1); } 
%PROFILE_STOP
return ret; }
ModDyn DynDamageMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDamageMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDamageMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDamageMul() != ModDyn::None) return true; return false; }

float m_modsSpellCostMulConst = 1;
array<Modifier@> m_modsSpellCostMul;
float SpellCostMul(PlayerBase@ p0) override { float ret = m_modsSpellCostMulConst; 
%PROFILE_START ModifiersList:SpellCostMul
uint ml = m_modsSpellCostMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsSpellCostMul[i].SpellCostMul(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynSpellCostMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSpellCostMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSpellCostMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSpellCostMul() != ModDyn::None) return true; return false; }

int m_modsCritConst = 0;
array<Modifier@> m_modsCrit;
int Crit(PlayerBase@ p0, Actor@ p1, bool p2) override { int ret = m_modsCritConst; 
%PROFILE_START ModifiersList:Crit
uint ml = m_modsCrit.length(); for (uint i = 0; i < ml; i++) { ret += m_modsCrit[i].Crit(p0, p1, p2); } 
%PROFILE_STOP
return ret; }
ModDyn DynCrit() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynCrit(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasCrit() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynCrit() != ModDyn::None) return true; return false; }

float m_modsCritMulConst = 1;
array<Modifier@> m_modsCritMul;
float CritMul(PlayerBase@ p0, Actor@ p1, bool p2) override { float ret = m_modsCritMulConst; 
%PROFILE_START ModifiersList:CritMul
uint ml = m_modsCritMul.length(); for (uint i = 0; i < ml; i++) { ret += m_modsCritMul[i].CritMul(p0, p1, p2) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynCritMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynCritMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasCritMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynCritMul() != ModDyn::None) return true; return false; }

float m_modsCritMulAddConst = 0;
array<Modifier@> m_modsCritMulAdd;
float CritMulAdd(PlayerBase@ p0, Actor@ p1, bool p2) override { float ret = m_modsCritMulAddConst; 
%PROFILE_START ModifiersList:CritMulAdd
uint ml = m_modsCritMulAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsCritMulAdd[i].CritMulAdd(p0, p1, p2); } 
%PROFILE_STOP
return ret; }
ModDyn DynCritMulAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynCritMulAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasCritMulAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynCritMulAdd() != ModDyn::None) return true; return false; }

vec2 m_modsArmorIgnoreConst = vec2(1, 1);
array<Modifier@> m_modsArmorIgnore;
vec2 ArmorIgnore(PlayerBase@ p0, Actor@ p1, bool p2) override { vec2 ret = m_modsArmorIgnoreConst; 
%PROFILE_START ModifiersList:ArmorIgnore
uint ml = m_modsArmorIgnore.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsArmorIgnore[i].ArmorIgnore(p0, p1, p2); } 
%PROFILE_STOP
return ret; }
ModDyn DynArmorIgnore() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynArmorIgnore(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasArmorIgnore() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynArmorIgnore() != ModDyn::None) return true; return false; }

float m_modsLifestealConst = 0;
array<Modifier@> m_modsLifesteal;
float Lifesteal(PlayerBase@ p0, Actor@ p1, bool p2, int p3) override { float ret = m_modsLifestealConst; 
%PROFILE_START ModifiersList:Lifesteal
uint ml = m_modsLifesteal.length(); for (uint i = 0; i < ml; i++) { ret += m_modsLifesteal[i].Lifesteal(p0, p1, p2, p3); } 
%PROFILE_STOP
return ret; }
ModDyn DynLifesteal() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynLifesteal(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasLifesteal() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynLifesteal() != ModDyn::None) return true; return false; }

ivec2 m_modsStatsAddConst = ivec2();
array<Modifier@> m_modsStatsAdd;
ivec2 StatsAdd(PlayerBase@ p0) override { ivec2 ret = m_modsStatsAddConst; 
%PROFILE_START ModifiersList:StatsAdd
uint ml = m_modsStatsAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsStatsAdd[i].StatsAdd(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynStatsAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynStatsAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasStatsAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynStatsAdd() != ModDyn::None) return true; return false; }

float m_modsMaxHealthMulConst = 1;
array<Modifier@> m_modsMaxHealthMul;
float MaxHealthMul(PlayerBase@ p0) override { float ret = m_modsMaxHealthMulConst; 
%PROFILE_START ModifiersList:MaxHealthMul
uint ml = m_modsMaxHealthMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsMaxHealthMul[i].MaxHealthMul(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynMaxHealthMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynMaxHealthMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasMaxHealthMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynMaxHealthMul() != ModDyn::None) return true; return false; }

float m_modsMoveSpeedAddConst = 0;
array<Modifier@> m_modsMoveSpeedAdd;
float MoveSpeedAdd(PlayerBase@ p0, float p1) override { float ret = m_modsMoveSpeedAddConst; 
%PROFILE_START ModifiersList:MoveSpeedAdd
uint ml = m_modsMoveSpeedAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsMoveSpeedAdd[i].MoveSpeedAdd(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynMoveSpeedAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynMoveSpeedAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasMoveSpeedAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynMoveSpeedAdd() != ModDyn::None) return true; return false; }

float m_modsMoveSpeedMulConst = 1;
array<Modifier@> m_modsMoveSpeedMul;
float MoveSpeedMul(PlayerBase@ p0, float p1) override { float ret = m_modsMoveSpeedMulConst; 
%PROFILE_START ModifiersList:MoveSpeedMul
uint ml = m_modsMoveSpeedMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsMoveSpeedMul[i].MoveSpeedMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynMoveSpeedMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynMoveSpeedMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasMoveSpeedMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynMoveSpeedMul() != ModDyn::None) return true; return false; }

float m_modsSkillMoveSpeedMulConst = 1;
array<Modifier@> m_modsSkillMoveSpeedMul;
float SkillMoveSpeedMul(PlayerBase@ p0, float p1) override { float ret = m_modsSkillMoveSpeedMulConst; 
%PROFILE_START ModifiersList:SkillMoveSpeedMul
uint ml = m_modsSkillMoveSpeedMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsSkillMoveSpeedMul[i].SkillMoveSpeedMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynSkillMoveSpeedMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSkillMoveSpeedMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSkillMoveSpeedMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSkillMoveSpeedMul() != ModDyn::None) return true; return false; }

bool m_modsSkillMoveSpeedClearConst = false;
array<Modifier@> m_modsSkillMoveSpeedClear;
bool SkillMoveSpeedClear(PlayerBase@ p0, float p1) override { bool ret = false; 
%PROFILE_START ModifiersList:SkillMoveSpeedClear
uint ml = m_modsSkillMoveSpeedClear.length(); for (uint i = 0; i < ml; i++) { if (m_modsSkillMoveSpeedClear[i].SkillMoveSpeedClear(p0, p1)) 
%PROFILE_STOP
return true; } 
%PROFILE_STOP
return ret; }
ModDyn DynSkillMoveSpeedClear() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSkillMoveSpeedClear(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSkillMoveSpeedClear() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSkillMoveSpeedClear() != ModDyn::None) return true; return false; }

vec2 m_modsRegenAddConst = vec2();
array<Modifier@> m_modsRegenAdd;
vec2 RegenAdd(PlayerBase@ p0) override { vec2 ret = m_modsRegenAddConst; 
%PROFILE_START ModifiersList:RegenAdd
uint ml = m_modsRegenAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsRegenAdd[i].RegenAdd(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynRegenAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynRegenAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasRegenAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynRegenAdd() != ModDyn::None) return true; return false; }

vec2 m_modsRegenMulConst = vec2(1, 1);
array<Modifier@> m_modsRegenMul;
vec2 RegenMul(PlayerBase@ p0) override { vec2 ret = m_modsRegenMulConst; 
%PROFILE_START ModifiersList:RegenMul
uint ml = m_modsRegenMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsRegenMul[i].RegenMul(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynRegenMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynRegenMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasRegenMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynRegenMul() != ModDyn::None) return true; return false; }

float m_modsExpMulConst = 1;
array<Modifier@> m_modsExpMul;
float ExpMul(PlayerBase@ p0, Actor@ p1) override { float ret = m_modsExpMulConst; 
%PROFILE_START ModifiersList:ExpMul
uint ml = m_modsExpMul.length(); for (uint i = 0; i < ml; i++) { ret += m_modsExpMul[i].ExpMul(p0, p1) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynExpMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynExpMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasExpMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynExpMul() != ModDyn::None) return true; return false; }

float m_modsExpMulAddConst = 0;
array<Modifier@> m_modsExpMulAdd;
float ExpMulAdd(PlayerBase@ p0, Actor@ p1) override { float ret = m_modsExpMulAddConst; 
%PROFILE_START ModifiersList:ExpMulAdd
uint ml = m_modsExpMulAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsExpMulAdd[i].ExpMulAdd(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynExpMulAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynExpMulAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasExpMulAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynExpMulAdd() != ModDyn::None) return true; return false; }

int m_modsPotionChargesConst = 0;
array<Modifier@> m_modsPotionCharges;
int PotionCharges() override { int ret = m_modsPotionChargesConst; 
%PROFILE_START ModifiersList:PotionCharges
uint ml = m_modsPotionCharges.length(); for (uint i = 0; i < ml; i++) { ret += m_modsPotionCharges[i].PotionCharges(); } 
%PROFILE_STOP
return ret; }
ModDyn DynPotionCharges() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynPotionCharges(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasPotionCharges() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynPotionCharges() != ModDyn::None) return true; return false; }

float m_modsPotionHealMulConst = 1;
array<Modifier@> m_modsPotionHealMul;
float PotionHealMul(PlayerBase@ p0) override { float ret = m_modsPotionHealMulConst; 
%PROFILE_START ModifiersList:PotionHealMul
uint ml = m_modsPotionHealMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsPotionHealMul[i].PotionHealMul(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynPotionHealMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynPotionHealMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasPotionHealMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynPotionHealMul() != ModDyn::None) return true; return false; }

float m_modsPotionManaMulConst = 1;
array<Modifier@> m_modsPotionManaMul;
float PotionManaMul(PlayerBase@ p0) override { float ret = m_modsPotionManaMulConst; 
%PROFILE_START ModifiersList:PotionManaMul
uint ml = m_modsPotionManaMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsPotionManaMul[i].PotionManaMul(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynPotionManaMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynPotionManaMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasPotionManaMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynPotionManaMul() != ModDyn::None) return true; return false; }

int m_modsTaxMidpointConst = 0;
array<Modifier@> m_modsTaxMidpoint;
int TaxMidpoint() override { int ret = m_modsTaxMidpointConst; 
%PROFILE_START ModifiersList:TaxMidpoint
uint ml = m_modsTaxMidpoint.length(); for (uint i = 0; i < ml; i++) { ret += m_modsTaxMidpoint[i].TaxMidpoint(); } 
%PROFILE_STOP
return ret; }
ModDyn DynTaxMidpoint() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynTaxMidpoint(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasTaxMidpoint() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynTaxMidpoint() != ModDyn::None) return true; return false; }

float m_modsTaxMidpointMulConst = 1;
array<Modifier@> m_modsTaxMidpointMul;
float TaxMidpointMul() override { float ret = m_modsTaxMidpointMulConst; 
%PROFILE_START ModifiersList:TaxMidpointMul
uint ml = m_modsTaxMidpointMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsTaxMidpointMul[i].TaxMidpointMul(); } 
%PROFILE_STOP
return ret; }
ModDyn DynTaxMidpointMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynTaxMidpointMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasTaxMidpointMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynTaxMidpointMul() != ModDyn::None) return true; return false; }

float m_modsGoldGainScaleConst = 1;
array<Modifier@> m_modsGoldGainScale;
float GoldGainScale(PlayerBase@ p0) override { float ret = m_modsGoldGainScaleConst; 
%PROFILE_START ModifiersList:GoldGainScale
uint ml = m_modsGoldGainScale.length(); for (uint i = 0; i < ml; i++) { ret += m_modsGoldGainScale[i].GoldGainScale(p0) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynGoldGainScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynGoldGainScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasGoldGainScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynGoldGainScale() != ModDyn::None) return true; return false; }

float m_modsGoldGainScaleAddConst = 0;
array<Modifier@> m_modsGoldGainScaleAdd;
float GoldGainScaleAdd(PlayerBase@ p0) override { float ret = m_modsGoldGainScaleAddConst; 
%PROFILE_START ModifiersList:GoldGainScaleAdd
uint ml = m_modsGoldGainScaleAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsGoldGainScaleAdd[i].GoldGainScaleAdd(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynGoldGainScaleAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynGoldGainScaleAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasGoldGainScaleAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynGoldGainScaleAdd() != ModDyn::None) return true; return false; }

float m_modsOreGainScaleConst = 1;
array<Modifier@> m_modsOreGainScale;
float OreGainScale(PlayerBase@ p0) override { float ret = m_modsOreGainScaleConst; 
%PROFILE_START ModifiersList:OreGainScale
uint ml = m_modsOreGainScale.length(); for (uint i = 0; i < ml; i++) { ret += m_modsOreGainScale[i].OreGainScale(p0) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynOreGainScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynOreGainScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasOreGainScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynOreGainScale() != ModDyn::None) return true; return false; }

float m_modsKeyGainScaleConst = 1;
array<Modifier@> m_modsKeyGainScale;
float KeyGainScale(PlayerBase@ p0) override { float ret = m_modsKeyGainScaleConst; 
%PROFILE_START ModifiersList:KeyGainScale
uint ml = m_modsKeyGainScale.length(); for (uint i = 0; i < ml; i++) { ret += m_modsKeyGainScale[i].KeyGainScale(p0) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynKeyGainScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynKeyGainScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasKeyGainScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynKeyGainScale() != ModDyn::None) return true; return false; }

float m_modsAllHealthGainScaleConst = 1;
array<Modifier@> m_modsAllHealthGainScale;
float AllHealthGainScale(PlayerBase@ p0) override { float ret = m_modsAllHealthGainScaleConst; 
%PROFILE_START ModifiersList:AllHealthGainScale
uint ml = m_modsAllHealthGainScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsAllHealthGainScale[i].AllHealthGainScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynAllHealthGainScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynAllHealthGainScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasAllHealthGainScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynAllHealthGainScale() != ModDyn::None) return true; return false; }

float m_modsHealthGainScaleConst = 1;
array<Modifier@> m_modsHealthGainScale;
float HealthGainScale(PlayerBase@ p0) override { float ret = m_modsHealthGainScaleConst; 
%PROFILE_START ModifiersList:HealthGainScale
uint ml = m_modsHealthGainScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsHealthGainScale[i].HealthGainScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynHealthGainScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynHealthGainScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasHealthGainScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynHealthGainScale() != ModDyn::None) return true; return false; }

float m_modsManaGainScaleConst = 1;
array<Modifier@> m_modsManaGainScale;
float ManaGainScale(PlayerBase@ p0) override { float ret = m_modsManaGainScaleConst; 
%PROFILE_START ModifiersList:ManaGainScale
uint ml = m_modsManaGainScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsManaGainScale[i].ManaGainScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynManaGainScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynManaGainScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasManaGainScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynManaGainScale() != ModDyn::None) return true; return false; }

int m_modsManaFromDamageConst = 0;
array<Modifier@> m_modsManaFromDamage;
int ManaFromDamage(PlayerBase@ p0, int p1) override { int ret = m_modsManaFromDamageConst; 
%PROFILE_START ModifiersList:ManaFromDamage
uint ml = m_modsManaFromDamage.length(); for (uint i = 0; i < ml; i++) { ret += m_modsManaFromDamage[i].ManaFromDamage(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynManaFromDamage() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynManaFromDamage(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasManaFromDamage() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynManaFromDamage() != ModDyn::None) return true; return false; }

float m_modsSkillTimeMulConst = 1;
array<Modifier@> m_modsSkillTimeMul;
float SkillTimeMul(PlayerBase@ p0) override { float ret = m_modsSkillTimeMulConst; 
%PROFILE_START ModifiersList:SkillTimeMul
uint ml = m_modsSkillTimeMul.length(); for (uint i = 0; i < ml; i++) { ret += m_modsSkillTimeMul[i].SkillTimeMul(p0) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynSkillTimeMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSkillTimeMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSkillTimeMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSkillTimeMul() != ModDyn::None) return true; return false; }

float m_modsAttackTimeMulConst = 1;
array<Modifier@> m_modsAttackTimeMul;
float AttackTimeMul(PlayerBase@ p0) override { float ret = m_modsAttackTimeMulConst; 
%PROFILE_START ModifiersList:AttackTimeMul
uint ml = m_modsAttackTimeMul.length(); for (uint i = 0; i < ml; i++) { ret += m_modsAttackTimeMul[i].AttackTimeMul(p0) - 1; } 
%PROFILE_STOP
return ret; }
ModDyn DynAttackTimeMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynAttackTimeMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasAttackTimeMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynAttackTimeMul() != ModDyn::None) return true; return false; }

array<Modifier@> m_modsDamageTaken;
void DamageTaken(PlayerBase@ p0, Actor@ p1, int p2) override {  
%PROFILE_START ModifiersList:DamageTaken
uint ml = m_modsDamageTaken.length(); for (uint i = 0; i < ml; i++) { m_modsDamageTaken[i].DamageTaken(p0, p1, p2); }
%PROFILE_STOP
 }
ModDyn DynDamageTaken() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDamageTaken(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDamageTaken() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDamageTaken() != ModDyn::None) return true; return false; }

array<Modifier@> m_modsTriggerEffects;
void TriggerEffects(PlayerBase@ p0, Actor@ p1, EffectTrigger p2) override { if (uint(p2) & m_triggerEffects == 0) return;
 
%PROFILE_START ModifiersList:TriggerEffects
uint ml = m_modsTriggerEffects.length(); for (uint i = 0; i < ml; i++) { m_modsTriggerEffects[i].TriggerEffects(p0, p1, p2); }
%PROFILE_STOP
 }
ModDyn DynTriggerEffects() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynTriggerEffects(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasTriggerEffects() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynTriggerEffects() != ModDyn::None) return true; return false; }

array<Modifier@> m_modsUpdate;
void Update(PlayerBase@ p0, int p1) override {  
%PROFILE_START ModifiersList:Update
uint ml = m_modsUpdate.length(); for (uint i = 0; i < ml; i++) { m_modsUpdate[i].Update(p0, p1); }
%PROFILE_STOP
 }
ModDyn DynUpdate() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynUpdate(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasUpdate() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynUpdate() != ModDyn::None) return true; return false; }

array<Modifier@> m_modsComboEffects;
array<IEffect@>@ ComboEffects(PlayerBase@ p0) override { array<IEffect@> ret; 
%PROFILE_START ModifiersList:ComboEffects
uint ml = m_modsComboEffects.length(); for (uint i = 0; i < ml; i++) { auto arr = m_modsComboEffects[i].ComboEffects(p0); if (arr !is null && arr.length() > 0) ret.insertAt(ret.length(), arr); } 
%PROFILE_STOP
return ret; }
ModDyn DynComboEffects() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynComboEffects(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasComboEffects() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynComboEffects() != ModDyn::None) return true; return false; }

ivec3 m_modsComboPropsConst = ivec3();
array<Modifier@> m_modsComboProps;
ivec3 ComboProps(PlayerBase@ p0) override { ivec3 ret = m_modsComboPropsConst; 
%PROFILE_START ModifiersList:ComboProps
uint ml = m_modsComboProps.length(); for (uint i = 0; i < ml; i++) { ret += m_modsComboProps[i].ComboProps(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynComboProps() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynComboProps(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasComboProps() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynComboProps() != ModDyn::None) return true; return false; }

bool m_modsComboDisabledConst = false;
array<Modifier@> m_modsComboDisabled;
bool ComboDisabled(PlayerBase@ p0) override { bool ret = false; 
%PROFILE_START ModifiersList:ComboDisabled
uint ml = m_modsComboDisabled.length(); for (uint i = 0; i < ml; i++) { if (m_modsComboDisabled[i].ComboDisabled(p0)) 
%PROFILE_STOP
return true; } 
%PROFILE_STOP
return ret; }
ModDyn DynComboDisabled() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynComboDisabled(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasComboDisabled() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynComboDisabled() != ModDyn::None) return true; return false; }

float m_modsCleaveRangeMulConst = 1;
array<Modifier@> m_modsCleaveRangeMul;
float CleaveRangeMul(PlayerBase@ p0, Actor@ p1) override { float ret = m_modsCleaveRangeMulConst; 
%PROFILE_START ModifiersList:CleaveRangeMul
uint ml = m_modsCleaveRangeMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsCleaveRangeMul[i].CleaveRangeMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynCleaveRangeMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynCleaveRangeMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasCleaveRangeMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynCleaveRangeMul() != ModDyn::None) return true; return false; }

float m_modsWindScaleConst = 1;
array<Modifier@> m_modsWindScale;
float WindScale(PlayerBase@ p0) override { float ret = m_modsWindScaleConst; 
%PROFILE_START ModifiersList:WindScale
uint ml = m_modsWindScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsWindScale[i].WindScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynWindScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynWindScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasWindScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynWindScale() != ModDyn::None) return true; return false; }

float m_modsBuffScaleConst = 1;
array<Modifier@> m_modsBuffScale;
float BuffScale(PlayerBase@ p0) override { float ret = m_modsBuffScaleConst; 
%PROFILE_START ModifiersList:BuffScale
uint ml = m_modsBuffScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsBuffScale[i].BuffScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynBuffScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynBuffScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasBuffScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynBuffScale() != ModDyn::None) return true; return false; }

float m_modsDebuffScaleConst = 1;
array<Modifier@> m_modsDebuffScale;
float DebuffScale(PlayerBase@ p0) override { float ret = m_modsDebuffScaleConst; 
%PROFILE_START ModifiersList:DebuffScale
uint ml = m_modsDebuffScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsDebuffScale[i].DebuffScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynDebuffScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDebuffScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDebuffScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDebuffScale() != ModDyn::None) return true; return false; }

uint64 m_modsImmuneBuffsConst = 0;
array<Modifier@> m_modsImmuneBuffs;
uint64 ImmuneBuffs(PlayerBase@ p0) override { uint64 ret = m_modsImmuneBuffsConst; 
%PROFILE_START ModifiersList:ImmuneBuffs
uint ml = m_modsImmuneBuffs.length(); for (uint i = 0; i < ml; i++) { ret |= m_modsImmuneBuffs[i].ImmuneBuffs(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynImmuneBuffs() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynImmuneBuffs(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasImmuneBuffs() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynImmuneBuffs() != ModDyn::None) return true; return false; }

float m_modsSlowScaleConst = 1;
array<Modifier@> m_modsSlowScale;
float SlowScale(PlayerBase@ p0) override { float ret = m_modsSlowScaleConst; 
%PROFILE_START ModifiersList:SlowScale
uint ml = m_modsSlowScale.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsSlowScale[i].SlowScale(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynSlowScale() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSlowScale(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSlowScale() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSlowScale() != ModDyn::None) return true; return false; }

bool m_modsCooldownClearConst = false;
array<Modifier@> m_modsCooldownClear;
bool CooldownClear(PlayerBase@ p0, Skills::ActiveSkill@ p1) override { bool ret = false; 
%PROFILE_START ModifiersList:CooldownClear
uint ml = m_modsCooldownClear.length(); for (uint i = 0; i < ml; i++) { if (m_modsCooldownClear[i].CooldownClear(p0, p1)) 
%PROFILE_STOP
return true; } 
%PROFILE_STOP
return ret; }
ModDyn DynCooldownClear() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynCooldownClear(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasCooldownClear() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynCooldownClear() != ModDyn::None) return true; return false; }

float m_modsLuckAddConst = 0;
array<Modifier@> m_modsLuckAdd;
float LuckAdd(PlayerBase@ p0) override { float ret = m_modsLuckAddConst; 
%PROFILE_START ModifiersList:LuckAdd
uint ml = m_modsLuckAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsLuckAdd[i].LuckAdd(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynLuckAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynLuckAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasLuckAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynLuckAdd() != ModDyn::None) return true; return false; }

int m_modsCursesAddConst = 0;
array<Modifier@> m_modsCursesAdd;
int CursesAdd(PlayerBase@ p0) override { int ret = m_modsCursesAddConst; 
%PROFILE_START ModifiersList:CursesAdd
uint ml = m_modsCursesAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsCursesAdd[i].CursesAdd(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynCursesAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynCursesAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasCursesAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynCursesAdd() != ModDyn::None) return true; return false; }

int m_modsSkillpointsAddConst = 0;
array<Modifier@> m_modsSkillpointsAdd;
int SkillpointsAdd(PlayerBase@ p0) override { int ret = m_modsSkillpointsAddConst; 
%PROFILE_START ModifiersList:SkillpointsAdd
uint ml = m_modsSkillpointsAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsSkillpointsAdd[i].SkillpointsAdd(p0); } 
%PROFILE_STOP
return ret; }
ModDyn DynSkillpointsAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynSkillpointsAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasSkillpointsAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynSkillpointsAdd() != ModDyn::None) return true; return false; }

float m_modsShopCostMulConst = 1;
array<Modifier@> m_modsShopCostMul;
float ShopCostMul(PlayerBase@ p0, Upgrades::UpgradeStep@ p1) override { float ret = m_modsShopCostMulConst; 
%PROFILE_START ModifiersList:ShopCostMul
uint ml = m_modsShopCostMul.length(); for (uint i = 0; i < ml; i++) { ret *= m_modsShopCostMul[i].ShopCostMul(p0, p1); } 
%PROFILE_STOP
return ret; }
ModDyn DynShopCostMul() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynShopCostMul(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasShopCostMul() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynShopCostMul() != ModDyn::None) return true; return false; }

int m_modsDungeonStoreItemsAddConst = 0;
array<Modifier@> m_modsDungeonStoreItemsAdd;
int DungeonStoreItemsAdd() override { int ret = m_modsDungeonStoreItemsAddConst; 
%PROFILE_START ModifiersList:DungeonStoreItemsAdd
uint ml = m_modsDungeonStoreItemsAdd.length(); for (uint i = 0; i < ml; i++) { ret += m_modsDungeonStoreItemsAdd[i].DungeonStoreItemsAdd(); } 
%PROFILE_STOP
return ret; }
ModDyn DynDungeonStoreItemsAdd() override { 
 auto ret = ModDyn::None; uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) { auto dyn = m_modifiers[i].DynDungeonStoreItemsAdd(); if (dyn == ModDyn::Dynamic) return ModDyn::Dynamic; if (dyn == ModDyn::Static) ret = ModDyn::Static; } return ret; }

bool HasDungeonStoreItemsAdd() override { uint ml = m_modifiers.length(); for (uint i = 0; i < ml; i++) if (m_modifiers[i].DynDungeonStoreItemsAdd() != ModDyn::None) return true; return false; }

array<Modifier@>@ GetAllModifiers() { return m_modifiers; }
void Clear()
{
m_triggerEffects = 0;
array<array<Modifier@>@> modListList = { m_modsArmorAdd, m_modsArmorMul, m_modsDamageTakenMul, m_modsManaDamageTakenMul, m_modsDamageBlock, m_modsDamageBlockMul, m_modsEvasion, m_modsProjectileBlock, m_modsNonLethalDamage, m_modsDamagePower, m_modsAttackDamageAdd, m_modsSpellDamageAdd, m_modsDamageMul, m_modsSpellCostMul, m_modsCrit, m_modsCritMul, m_modsCritMulAdd, m_modsArmorIgnore, m_modsLifesteal, m_modsStatsAdd, m_modsMaxHealthMul, m_modsMoveSpeedAdd, m_modsMoveSpeedMul, m_modsSkillMoveSpeedMul, m_modsSkillMoveSpeedClear, m_modsRegenAdd, m_modsRegenMul, m_modsExpMul, m_modsExpMulAdd, m_modsPotionCharges, m_modsPotionHealMul, m_modsPotionManaMul, m_modsTaxMidpoint, m_modsTaxMidpointMul, m_modsGoldGainScale, m_modsGoldGainScaleAdd, m_modsOreGainScale, m_modsKeyGainScale, m_modsAllHealthGainScale, m_modsHealthGainScale, m_modsManaGainScale, m_modsManaFromDamage, m_modsSkillTimeMul, m_modsAttackTimeMul, m_modsDamageTaken, m_modsTriggerEffects, m_modsUpdate, m_modsComboEffects, m_modsComboProps, m_modsComboDisabled, m_modsCleaveRangeMul, m_modsWindScale, m_modsBuffScale, m_modsDebuffScale, m_modsImmuneBuffs, m_modsSlowScale, m_modsCooldownClear, m_modsLuckAdd, m_modsCursesAdd, m_modsSkillpointsAdd, m_modsShopCostMul, m_modsDungeonStoreItemsAdd, m_modifiers }; m_modsArmorAddConst = vec2();
m_modsArmorMulConst = vec2(1, 1);
m_modsDamageTakenMulConst = 1;
m_modsManaDamageTakenMulConst = 1;
m_modsDamageBlockConst = ivec2();
m_modsDamageBlockMulConst = vec2(1, 1);
m_modsEvasionConst = false;
m_modsProjectileBlockConst = false;
m_modsNonLethalDamageConst = false;
m_modsDamagePowerConst = ivec2();
m_modsAttackDamageAddConst = ivec2();
m_modsSpellDamageAddConst = ivec2();
m_modsDamageMulConst = vec2(1, 1);
m_modsSpellCostMulConst = 1;
m_modsCritConst = 0;
m_modsCritMulConst = 1;
m_modsCritMulAddConst = 0;
m_modsArmorIgnoreConst = vec2(1, 1);
m_modsLifestealConst = 0;
m_modsStatsAddConst = ivec2();
m_modsMaxHealthMulConst = 1;
m_modsMoveSpeedAddConst = 0;
m_modsMoveSpeedMulConst = 1;
m_modsSkillMoveSpeedMulConst = 1;
m_modsSkillMoveSpeedClearConst = false;
m_modsRegenAddConst = vec2();
m_modsRegenMulConst = vec2(1, 1);
m_modsExpMulConst = 1;
m_modsExpMulAddConst = 0;
m_modsPotionChargesConst = 0;
m_modsPotionHealMulConst = 1;
m_modsPotionManaMulConst = 1;
m_modsTaxMidpointConst = 0;
m_modsTaxMidpointMulConst = 1;
m_modsGoldGainScaleConst = 1;
m_modsGoldGainScaleAddConst = 0;
m_modsOreGainScaleConst = 1;
m_modsKeyGainScaleConst = 1;
m_modsAllHealthGainScaleConst = 1;
m_modsHealthGainScaleConst = 1;
m_modsManaGainScaleConst = 1;
m_modsManaFromDamageConst = 0;
m_modsSkillTimeMulConst = 1;
m_modsAttackTimeMulConst = 1;
m_modsComboPropsConst = ivec3();
m_modsComboDisabledConst = false;
m_modsCleaveRangeMulConst = 1;
m_modsWindScaleConst = 1;
m_modsBuffScaleConst = 1;
m_modsDebuffScaleConst = 1;
m_modsImmuneBuffsConst = 0;
m_modsSlowScaleConst = 1;
m_modsCooldownClearConst = false;
m_modsLuckAddConst = 0;
m_modsCursesAddConst = 0;
m_modsSkillpointsAddConst = 0;
m_modsShopCostMulConst = 1;
m_modsDungeonStoreItemsAddConst = 0;

for (uint i = 0; i < modListList.length(); i++) modListList[i].removeRange(0, modListList[i].length());
}


void Remove(Modifier@ toRemove) { bool removed = false;
for (uint i = 0; i < m_modifiers.length(); i++) { if (toRemove is m_modifiers[i]) { m_modifiers.removeAt(i--); removed = true; } }
if (removed) RefreshCache();
}


		Modifier@ Add(Modifier@ modifier)
		{

%PROFILE_START ModifierList::Add
			@modifier = modifier.Instance();
			m_modifiers.insertAt(m_modifiers.length(), modifier);
auto dyn = ModDyn::None;

dyn = modifier.DynArmorAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsArmorAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ArmorAdd(null, null);
  m_modsArmorAddConst += val;
}


dyn = modifier.DynArmorMul();
if (dyn == ModDyn::Dynamic)
  { m_modsArmorMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ArmorMul(null, null);
  m_modsArmorMulConst *= val;
}


dyn = modifier.DynDamageTakenMul();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageTakenMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageTakenMul(null, DamageInfo());
  m_modsDamageTakenMulConst *= val;
}


dyn = modifier.DynManaDamageTakenMul();
if (dyn == ModDyn::Dynamic)
  { m_modsManaDamageTakenMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ManaDamageTakenMul(null);
  m_modsManaDamageTakenMulConst *= val;
}


dyn = modifier.DynDamageBlock();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageBlock.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageBlock(null, null);
  m_modsDamageBlockConst += val;
}


dyn = modifier.DynDamageBlockMul();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageBlockMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageBlockMul(null, null);
  m_modsDamageBlockMulConst *= val;
}


dyn = modifier.DynEvasion();
if (dyn == ModDyn::Dynamic)
  { m_modsEvasion.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.Evasion(null, null);
  m_modsEvasionConst = m_modsEvasionConst || val;
}


dyn = modifier.DynProjectileBlock();
if (dyn == ModDyn::Dynamic)
  { m_modsProjectileBlock.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ProjectileBlock(null, null);
  m_modsProjectileBlockConst = m_modsProjectileBlockConst || val;
}


dyn = modifier.DynNonLethalDamage();
if (dyn == ModDyn::Dynamic)
  { m_modsNonLethalDamage.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.NonLethalDamage(null, DamageInfo());
  m_modsNonLethalDamageConst = m_modsNonLethalDamageConst || val;
}


dyn = modifier.DynDamagePower();
if (dyn == ModDyn::Dynamic)
  { m_modsDamagePower.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamagePower(null, null);
  m_modsDamagePowerConst += val;
}


dyn = modifier.DynAttackDamageAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsAttackDamageAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.AttackDamageAdd(null, null, null);
  m_modsAttackDamageAddConst += val;
}


dyn = modifier.DynSpellDamageAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsSpellDamageAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SpellDamageAdd(null, null, null);
  m_modsSpellDamageAddConst += val;
}


dyn = modifier.DynDamageMul();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DamageMul(null, null);
  m_modsDamageMulConst += val - vec2(1,1);
}


dyn = modifier.DynSpellCostMul();
if (dyn == ModDyn::Dynamic)
  { m_modsSpellCostMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SpellCostMul(null);
  m_modsSpellCostMulConst *= val;
}


dyn = modifier.DynCrit();
if (dyn == ModDyn::Dynamic)
  { m_modsCrit.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.Crit(null, null, false);
  m_modsCritConst += val;
}


dyn = modifier.DynCritMul();
if (dyn == ModDyn::Dynamic)
  { m_modsCritMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CritMul(null, null, false);
  m_modsCritMulConst += val - 1;
}


dyn = modifier.DynCritMulAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsCritMulAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CritMulAdd(null, null, false);
  m_modsCritMulAddConst += val;
}


dyn = modifier.DynArmorIgnore();
if (dyn == ModDyn::Dynamic)
  { m_modsArmorIgnore.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ArmorIgnore(null, null, false);
  m_modsArmorIgnoreConst *= val;
}


dyn = modifier.DynLifesteal();
if (dyn == ModDyn::Dynamic)
  { m_modsLifesteal.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.Lifesteal(null, null, false, 0);
  m_modsLifestealConst += val;
}


dyn = modifier.DynStatsAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsStatsAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.StatsAdd(null);
  m_modsStatsAddConst += val;
}


dyn = modifier.DynMaxHealthMul();
if (dyn == ModDyn::Dynamic)
  { m_modsMaxHealthMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.MaxHealthMul(null);
  m_modsMaxHealthMulConst *= val;
}


dyn = modifier.DynMoveSpeedAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsMoveSpeedAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.MoveSpeedAdd(null, 0);
  m_modsMoveSpeedAddConst += val;
}


dyn = modifier.DynMoveSpeedMul();
if (dyn == ModDyn::Dynamic)
  { m_modsMoveSpeedMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.MoveSpeedMul(null, 0);
  m_modsMoveSpeedMulConst *= val;
}


dyn = modifier.DynSkillMoveSpeedMul();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillMoveSpeedMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillMoveSpeedMul(null, 0);
  m_modsSkillMoveSpeedMulConst *= val;
}


dyn = modifier.DynSkillMoveSpeedClear();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillMoveSpeedClear.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillMoveSpeedClear(null, 0);
  m_modsSkillMoveSpeedClearConst = m_modsSkillMoveSpeedClearConst || val;
}


dyn = modifier.DynRegenAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsRegenAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.RegenAdd(null);
  m_modsRegenAddConst += val;
}


dyn = modifier.DynRegenMul();
if (dyn == ModDyn::Dynamic)
  { m_modsRegenMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.RegenMul(null);
  m_modsRegenMulConst *= val;
}


dyn = modifier.DynExpMul();
if (dyn == ModDyn::Dynamic)
  { m_modsExpMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ExpMul(null, null);
  m_modsExpMulConst += val - 1;
}


dyn = modifier.DynExpMulAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsExpMulAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ExpMulAdd(null, null);
  m_modsExpMulAddConst += val;
}


dyn = modifier.DynPotionCharges();
if (dyn == ModDyn::Dynamic)
  { m_modsPotionCharges.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.PotionCharges();
  m_modsPotionChargesConst += val;
}


dyn = modifier.DynPotionHealMul();
if (dyn == ModDyn::Dynamic)
  { m_modsPotionHealMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.PotionHealMul(null);
  m_modsPotionHealMulConst *= val;
}


dyn = modifier.DynPotionManaMul();
if (dyn == ModDyn::Dynamic)
  { m_modsPotionManaMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.PotionManaMul(null);
  m_modsPotionManaMulConst *= val;
}


dyn = modifier.DynTaxMidpoint();
if (dyn == ModDyn::Dynamic)
  { m_modsTaxMidpoint.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.TaxMidpoint();
  m_modsTaxMidpointConst += val;
}


dyn = modifier.DynTaxMidpointMul();
if (dyn == ModDyn::Dynamic)
  { m_modsTaxMidpointMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.TaxMidpointMul();
  m_modsTaxMidpointMulConst *= val;
}


dyn = modifier.DynGoldGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsGoldGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.GoldGainScale(null);
  m_modsGoldGainScaleConst += val - 1;
}


dyn = modifier.DynGoldGainScaleAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsGoldGainScaleAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.GoldGainScaleAdd(null);
  m_modsGoldGainScaleAddConst += val;
}


dyn = modifier.DynOreGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsOreGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.OreGainScale(null);
  m_modsOreGainScaleConst += val - 1;
}


dyn = modifier.DynKeyGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsKeyGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.KeyGainScale(null);
  m_modsKeyGainScaleConst += val - 1;
}


dyn = modifier.DynAllHealthGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsAllHealthGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.AllHealthGainScale(null);
  m_modsAllHealthGainScaleConst *= val;
}


dyn = modifier.DynHealthGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsHealthGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.HealthGainScale(null);
  m_modsHealthGainScaleConst *= val;
}


dyn = modifier.DynManaGainScale();
if (dyn == ModDyn::Dynamic)
  { m_modsManaGainScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ManaGainScale(null);
  m_modsManaGainScaleConst *= val;
}


dyn = modifier.DynManaFromDamage();
if (dyn == ModDyn::Dynamic)
  { m_modsManaFromDamage.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ManaFromDamage(null, 0);
  m_modsManaFromDamageConst += val;
}


dyn = modifier.DynSkillTimeMul();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillTimeMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillTimeMul(null);
  m_modsSkillTimeMulConst += val - 1;
}


dyn = modifier.DynAttackTimeMul();
if (dyn == ModDyn::Dynamic)
  { m_modsAttackTimeMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.AttackTimeMul(null);
  m_modsAttackTimeMulConst += val - 1;
}


dyn = modifier.DynDamageTaken();
if (dyn == ModDyn::Dynamic)
  { m_modsDamageTaken.insertLast(modifier); }

dyn = modifier.DynTriggerEffects();
if (dyn == ModDyn::Dynamic)
  { m_modsTriggerEffects.insertLast(modifier); m_triggerEffects |= modifier.m_triggerEffects; }

dyn = modifier.DynUpdate();
if (dyn == ModDyn::Dynamic)
  { m_modsUpdate.insertLast(modifier); }

dyn = modifier.DynComboEffects();
if (dyn == ModDyn::Dynamic)
  { m_modsComboEffects.insertLast(modifier); }

dyn = modifier.DynComboProps();
if (dyn == ModDyn::Dynamic)
  { m_modsComboProps.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ComboProps(null);
  m_modsComboPropsConst += val;
}


dyn = modifier.DynComboDisabled();
if (dyn == ModDyn::Dynamic)
  { m_modsComboDisabled.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ComboDisabled(null);
  m_modsComboDisabledConst = m_modsComboDisabledConst || val;
}


dyn = modifier.DynCleaveRangeMul();
if (dyn == ModDyn::Dynamic)
  { m_modsCleaveRangeMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CleaveRangeMul(null, null);
  m_modsCleaveRangeMulConst *= val;
}


dyn = modifier.DynWindScale();
if (dyn == ModDyn::Dynamic)
  { m_modsWindScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.WindScale(null);
  m_modsWindScaleConst *= val;
}


dyn = modifier.DynBuffScale();
if (dyn == ModDyn::Dynamic)
  { m_modsBuffScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.BuffScale(null);
  m_modsBuffScaleConst *= val;
}


dyn = modifier.DynDebuffScale();
if (dyn == ModDyn::Dynamic)
  { m_modsDebuffScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DebuffScale(null);
  m_modsDebuffScaleConst *= val;
}


dyn = modifier.DynImmuneBuffs();
if (dyn == ModDyn::Dynamic)
  { m_modsImmuneBuffs.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ImmuneBuffs(null);
  m_modsImmuneBuffsConst |= val;
}


dyn = modifier.DynSlowScale();
if (dyn == ModDyn::Dynamic)
  { m_modsSlowScale.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SlowScale(null);
  m_modsSlowScaleConst *= val;
}


dyn = modifier.DynCooldownClear();
if (dyn == ModDyn::Dynamic)
  { m_modsCooldownClear.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CooldownClear(null, null);
  m_modsCooldownClearConst = m_modsCooldownClearConst || val;
}


dyn = modifier.DynLuckAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsLuckAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.LuckAdd(null);
  m_modsLuckAddConst += val;
}


dyn = modifier.DynCursesAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsCursesAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.CursesAdd(null);
  m_modsCursesAddConst += val;
}


dyn = modifier.DynSkillpointsAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsSkillpointsAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.SkillpointsAdd(null);
  m_modsSkillpointsAddConst += val;
}


dyn = modifier.DynShopCostMul();
if (dyn == ModDyn::Dynamic)
  { m_modsShopCostMul.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.ShopCostMul(null, null);
  m_modsShopCostMulConst *= val;
}


dyn = modifier.DynDungeonStoreItemsAdd();
if (dyn == ModDyn::Dynamic)
  { m_modsDungeonStoreItemsAdd.insertLast(modifier); }
else if (dyn == ModDyn::Static)
{
  auto val = modifier.DungeonStoreItemsAdd();
  m_modsDungeonStoreItemsAddConst += val;
}


%PROFILE_STOP
			return modifier;
		}

		bool Has(Modifier@ modifier)
		{
			return (m_modifiers.findByRef(modifier) != -1);
		}
	}}