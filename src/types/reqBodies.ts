export interface ReqBodyRace {
  id?: number;
  name: string;
  description: string;
  descriptionShort?: string;
  source?: string;
  speed: number;
  size: number;
  stats?: ReqBodyStatsBase;
  statsId?: number;
  skillPointsFist?: number;
  skillPointsAfterFirst?: number;
  languages?: {
    languageId: number;
    isAutomatic?: boolean; // if true, the character knows this language without needing to spend skill points
  }[];
  raceFeats?: {
    featId: number; // create or update
  }[];
  // raceTraits?: {
  //   traitId?: number; // create or update
  // }[]
}

export interface ReqBodyLanguage {
  id?: number;
  name: string;
  description?: string;
  source?: string;
}

export interface ReqBodyClass {
  id?: number;
  name: string;
  description: string;
  descriptionShort?: string;
  source?: string;
  hitDice: number;
  skillPointsFist: number;
  skillPointsAfterFirst: number;
  baseAttribute: string;
  classLevelBonuses: {
    level: number;
    baseAttack: number;
    fortitude: number;
    reflex: number;
    will: number;
    spellPoints?: number;
    spellsPerDay?: {
      spellLevel: number;
      perDay: number;
    }[];
    spellsKnown?: {
      spellLevel: number;
      knownPerLevel: number;
    }[];
    bonusFeats?: {
      featId: number;
    }[];
  }[];
  classSkills?: {
    skillId: number; // create or update
  }[];
}

export interface ReqBodyRequirement {
  id?: number;
  str?: number;
  dex?: number;
  con?: number;
  int?: number;
  wis?: number;
  cha?: number;
  minBaseAttack?: number;
  minClassLevel?: number;
  classId?: number;
  other?: string;
  casterOnly?: boolean;
  divineOnly?: boolean;
  skills?: {
    skillId: number;
    minRank?: number;
  }[];
  feats?: {
    featRequirementId: number;
  }[];
}

export interface ReqBodyFeat {
  id?: number;
  name: string;
  description: string;
  descriptionShort?: string;
  source?: string;
  type: string;
  isPassive?: boolean;
  isFighterBonusFeat?: boolean;
  isStackable?: boolean;
  stats?: ReqBodyStatsBase;
  statsId?: number;
  requirement?: ReqBodyRequirement;
}

export interface ReqBodySkill {
  id?: number;
  name: string;
  ability: string;
  source?: string;
  description?: string;
  descriptionShort?: string;
  trainedOnly?: boolean;
  armorCheckPenalty?: number;
}

export interface ReqBodyStatsBase {
  // Base stats
  str?: number;
  dex?: number;
  con?: number;
  int?: number;
  wis?: number;
  cha?: number;
  fortitude?: number;
  reflex?: number;
  will?: number;

  // Body stats
  speedBonus?: number;
  speedMax?: number;
  speedMod?: number;
  size?: number;

  // Armor stats
  acArmor?: number;
  acShield?: number;
  acNatural?: number;
  acDeflection?: number;
  acMisc?: number;
  acDexterityAvailable?: boolean;
  acDexterityMax?: number;
  skillPenalty?: number;

  // Attack and damage stats
  attackMelee?: number;
  attackRanged?: number;
  attackTouch?: number;
  attackGrapple?: number;
  damageMelee?: number;
  damageRanged?: number;
  hpTemp?: number;
  // TODO: weapon specific bonuses

  // Defense stats
  damageReduction?: number;
  damageReductionBypasses?: string; // e.g., "slashing", "piercing", "bludgeoning"
  resistCritChance?: number; // percentage chance to resist critical hits

  // Energy resistances (99 = immune)
  energyResistAcid?: number;
  energyResistCold?: number;
  energyResistElectricity?: number;
  energyResistFire?: number;
  energyResistSonic?: number;
  energyResistForce?: number;
  energyResistNegative?: number;
  energyResistPositive?: number;

  // Saves specific bonuses (99 = immune)
  poisonResistance?: number;
  charmResistance?: number;
  fearResistance?: number;
  sleepResistance?: number;
  diseaseResistance?: number;
  mindAffectingResistance?: number;
  deathResistance?: number;
  paralysisResistance?: number;
  fatigueResistance?: number;

  // Spell
  spellResistance?: number;
  psionicResistance?: number;
  casterLevelModifier?: number;

  skillBonuses?: {
    skillId: number;
    bonus: number;
  }[];
}
