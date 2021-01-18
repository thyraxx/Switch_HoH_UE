namespace Modifiers {enum ModDyn { None, Static, Dynamic }
class Modifier
{
	int m_cloned = 0; // for debugging
	uint m_triggerEffects = ~0;

	void Initialize(SyncVerb verb, uint id, uint modId) {}

	Modifier@ Instance() { return this; }

	float CritChance(bool spell) { return 0; }
	float EvadeChance() { return 0; }ModDyn DynArmorAdd() { return ModDyn::None; } 
bool HasArmorAdd() { return false; }
vec2 ArmorAdd(PlayerBase@ p0, Actor@ p1) { return vec2(); }
ModDyn DynArmorMul() { return ModDyn::None; } 
bool HasArmorMul() { return false; }
vec2 ArmorMul(PlayerBase@ p0, Actor@ p1) { return vec2(1, 1); }
ModDyn DynDamageTakenMul() { return ModDyn::None; } 
bool HasDamageTakenMul() { return false; }
float DamageTakenMul(PlayerBase@ p0, DamageInfo& p1) { return 1; }
ModDyn DynManaDamageTakenMul() { return ModDyn::None; } 
bool HasManaDamageTakenMul() { return false; }
float ManaDamageTakenMul(PlayerBase@ p0) { return 1; }
ModDyn DynDamageBlock() { return ModDyn::None; } 
bool HasDamageBlock() { return false; }
ivec2 DamageBlock(PlayerBase@ p0, Actor@ p1) { return ivec2(); }
ModDyn DynDamageBlockMul() { return ModDyn::None; } 
bool HasDamageBlockMul() { return false; }
vec2 DamageBlockMul(PlayerBase@ p0, Actor@ p1) { return vec2(1, 1); }
ModDyn DynEvasion() { return ModDyn::None; } 
bool HasEvasion() { return false; }
bool Evasion(PlayerBase@ p0, Actor@ p1) { return false; }
ModDyn DynProjectileBlock() { return ModDyn::None; } 
bool HasProjectileBlock() { return false; }
bool ProjectileBlock(PlayerBase@ p0, IProjectile@ p1) { return false; }
ModDyn DynNonLethalDamage() { return ModDyn::None; } 
bool HasNonLethalDamage() { return false; }
bool NonLethalDamage(PlayerBase@ p0, DamageInfo& p1) { return false; }
ModDyn DynDamagePower() { return ModDyn::None; } 
bool HasDamagePower() { return false; }
ivec2 DamagePower(PlayerBase@ p0, Actor@ p1) { return ivec2(); }
ModDyn DynAttackDamageAdd() { return ModDyn::None; } 
bool HasAttackDamageAdd() { return false; }
ivec2 AttackDamageAdd(PlayerBase@ p0, Actor@ p1, DamageInfo@ p2) { return ivec2(); }
ModDyn DynSpellDamageAdd() { return ModDyn::None; } 
bool HasSpellDamageAdd() { return false; }
ivec2 SpellDamageAdd(PlayerBase@ p0, Actor@ p1, DamageInfo@ p2) { return ivec2(); }
ModDyn DynDamageMul() { return ModDyn::None; } 
bool HasDamageMul() { return false; }
vec2 DamageMul(PlayerBase@ p0, Actor@ p1) { return vec2(1, 1); }
ModDyn DynSpellCostMul() { return ModDyn::None; } 
bool HasSpellCostMul() { return false; }
float SpellCostMul(PlayerBase@ p0) { return 1; }
ModDyn DynCrit() { return ModDyn::None; } 
bool HasCrit() { return false; }
int Crit(PlayerBase@ p0, Actor@ p1, bool p2) { return 0; }
ModDyn DynCritMul() { return ModDyn::None; } 
bool HasCritMul() { return false; }
float CritMul(PlayerBase@ p0, Actor@ p1, bool p2) { return 1; }
ModDyn DynCritMulAdd() { return ModDyn::None; } 
bool HasCritMulAdd() { return false; }
float CritMulAdd(PlayerBase@ p0, Actor@ p1, bool p2) { return 0; }
ModDyn DynArmorIgnore() { return ModDyn::None; } 
bool HasArmorIgnore() { return false; }
vec2 ArmorIgnore(PlayerBase@ p0, Actor@ p1, bool p2) { return vec2(1, 1); }
ModDyn DynLifesteal() { return ModDyn::None; } 
bool HasLifesteal() { return false; }
float Lifesteal(PlayerBase@ p0, Actor@ p1, bool p2, int p3) { return 0; }
ModDyn DynStatsAdd() { return ModDyn::None; } 
bool HasStatsAdd() { return false; }
ivec2 StatsAdd(PlayerBase@ p0) { return ivec2(); }
ModDyn DynMaxHealthMul() { return ModDyn::None; } 
bool HasMaxHealthMul() { return false; }
float MaxHealthMul(PlayerBase@ p0) { return 1; }
ModDyn DynMoveSpeedAdd() { return ModDyn::None; } 
bool HasMoveSpeedAdd() { return false; }
float MoveSpeedAdd(PlayerBase@ p0, float p1) { return 0; }
ModDyn DynMoveSpeedMul() { return ModDyn::None; } 
bool HasMoveSpeedMul() { return false; }
float MoveSpeedMul(PlayerBase@ p0, float p1) { return 1; }
ModDyn DynSkillMoveSpeedMul() { return ModDyn::None; } 
bool HasSkillMoveSpeedMul() { return false; }
float SkillMoveSpeedMul(PlayerBase@ p0, float p1) { return 1; }
ModDyn DynSkillMoveSpeedClear() { return ModDyn::None; } 
bool HasSkillMoveSpeedClear() { return false; }
bool SkillMoveSpeedClear(PlayerBase@ p0, float p1) { return false; }
ModDyn DynRegenAdd() { return ModDyn::None; } 
bool HasRegenAdd() { return false; }
vec2 RegenAdd(PlayerBase@ p0) { return vec2(); }
ModDyn DynRegenMul() { return ModDyn::None; } 
bool HasRegenMul() { return false; }
vec2 RegenMul(PlayerBase@ p0) { return vec2(1, 1); }
ModDyn DynExpMul() { return ModDyn::None; } 
bool HasExpMul() { return false; }
float ExpMul(PlayerBase@ p0, Actor@ p1) { return 1; }
ModDyn DynExpMulAdd() { return ModDyn::None; } 
bool HasExpMulAdd() { return false; }
float ExpMulAdd(PlayerBase@ p0, Actor@ p1) { return 0; }
ModDyn DynPotionCharges() { return ModDyn::None; } 
bool HasPotionCharges() { return false; }
int PotionCharges() { return 0; }
ModDyn DynPotionHealMul() { return ModDyn::None; } 
bool HasPotionHealMul() { return false; }
float PotionHealMul(PlayerBase@ p0) { return 1; }
ModDyn DynPotionManaMul() { return ModDyn::None; } 
bool HasPotionManaMul() { return false; }
float PotionManaMul(PlayerBase@ p0) { return 1; }
ModDyn DynTaxMidpoint() { return ModDyn::None; } 
bool HasTaxMidpoint() { return false; }
int TaxMidpoint() { return 0; }
ModDyn DynTaxMidpointMul() { return ModDyn::None; } 
bool HasTaxMidpointMul() { return false; }
float TaxMidpointMul() { return 1; }
ModDyn DynGoldGainScale() { return ModDyn::None; } 
bool HasGoldGainScale() { return false; }
float GoldGainScale(PlayerBase@ p0) { return 1; }
ModDyn DynGoldGainScaleAdd() { return ModDyn::None; } 
bool HasGoldGainScaleAdd() { return false; }
float GoldGainScaleAdd(PlayerBase@ p0) { return 0; }
ModDyn DynOreGainScale() { return ModDyn::None; } 
bool HasOreGainScale() { return false; }
float OreGainScale(PlayerBase@ p0) { return 1; }
ModDyn DynKeyGainScale() { return ModDyn::None; } 
bool HasKeyGainScale() { return false; }
float KeyGainScale(PlayerBase@ p0) { return 1; }
ModDyn DynAllHealthGainScale() { return ModDyn::None; } 
bool HasAllHealthGainScale() { return false; }
float AllHealthGainScale(PlayerBase@ p0) { return 1; }
ModDyn DynHealthGainScale() { return ModDyn::None; } 
bool HasHealthGainScale() { return false; }
float HealthGainScale(PlayerBase@ p0) { return 1; }
ModDyn DynManaGainScale() { return ModDyn::None; } 
bool HasManaGainScale() { return false; }
float ManaGainScale(PlayerBase@ p0) { return 1; }
ModDyn DynManaFromDamage() { return ModDyn::None; } 
bool HasManaFromDamage() { return false; }
int ManaFromDamage(PlayerBase@ p0, int p1) { return 0; }
ModDyn DynSkillTimeMul() { return ModDyn::None; } 
bool HasSkillTimeMul() { return false; }
float SkillTimeMul(PlayerBase@ p0) { return 1; }
ModDyn DynAttackTimeMul() { return ModDyn::None; } 
bool HasAttackTimeMul() { return false; }
float AttackTimeMul(PlayerBase@ p0) { return 1; }
ModDyn DynDamageTaken() { return ModDyn::None; } 
bool HasDamageTaken() { return false; }
void DamageTaken(PlayerBase@ p0, Actor@ p1, int p2) { return ; }
ModDyn DynTriggerEffects() { return ModDyn::None; } 
bool HasTriggerEffects() { return false; }
void TriggerEffects(PlayerBase@ p0, Actor@ p1, EffectTrigger p2) { return ; }
ModDyn DynUpdate() { return ModDyn::None; } 
bool HasUpdate() { return false; }
void Update(PlayerBase@ p0, int p1) { return ; }
ModDyn DynComboEffects() { return ModDyn::None; } 
bool HasComboEffects() { return false; }
array<IEffect@>@ ComboEffects(PlayerBase@ p0) { return null; }
ModDyn DynComboProps() { return ModDyn::None; } 
bool HasComboProps() { return false; }
ivec3 ComboProps(PlayerBase@ p0) { return ivec3(); }
ModDyn DynComboDisabled() { return ModDyn::None; } 
bool HasComboDisabled() { return false; }
bool ComboDisabled(PlayerBase@ p0) { return false; }
ModDyn DynCleaveRangeMul() { return ModDyn::None; } 
bool HasCleaveRangeMul() { return false; }
float CleaveRangeMul(PlayerBase@ p0, Actor@ p1) { return 1; }
ModDyn DynWindScale() { return ModDyn::None; } 
bool HasWindScale() { return false; }
float WindScale(PlayerBase@ p0) { return 1; }
ModDyn DynBuffScale() { return ModDyn::None; } 
bool HasBuffScale() { return false; }
float BuffScale(PlayerBase@ p0) { return 1; }
ModDyn DynDebuffScale() { return ModDyn::None; } 
bool HasDebuffScale() { return false; }
float DebuffScale(PlayerBase@ p0) { return 1; }
ModDyn DynImmuneBuffs() { return ModDyn::None; } 
bool HasImmuneBuffs() { return false; }
uint64 ImmuneBuffs(PlayerBase@ p0) { return 0; }
ModDyn DynSlowScale() { return ModDyn::None; } 
bool HasSlowScale() { return false; }
float SlowScale(PlayerBase@ p0) { return 1; }
ModDyn DynCooldownClear() { return ModDyn::None; } 
bool HasCooldownClear() { return false; }
bool CooldownClear(PlayerBase@ p0, Skills::ActiveSkill@ p1) { return false; }
ModDyn DynLuckAdd() { return ModDyn::None; } 
bool HasLuckAdd() { return false; }
float LuckAdd(PlayerBase@ p0) { return 0; }
ModDyn DynCursesAdd() { return ModDyn::None; } 
bool HasCursesAdd() { return false; }
int CursesAdd(PlayerBase@ p0) { return 0; }
ModDyn DynSkillpointsAdd() { return ModDyn::None; } 
bool HasSkillpointsAdd() { return false; }
int SkillpointsAdd(PlayerBase@ p0) { return 0; }
ModDyn DynShopCostMul() { return ModDyn::None; } 
bool HasShopCostMul() { return false; }
float ShopCostMul(PlayerBase@ p0, Upgrades::UpgradeStep@ p1) { return 1; }
ModDyn DynDungeonStoreItemsAdd() { return ModDyn::None; } 
bool HasDungeonStoreItemsAdd() { return false; }
int DungeonStoreItemsAdd() { return 0; }
}

}