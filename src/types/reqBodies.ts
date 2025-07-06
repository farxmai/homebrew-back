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
  skillBonuses?: {
    skillId: number;
    bonus: number;
  }[];
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
  skillBonuses?: {
    skillId: number;
    bonus: number;
  }[];
  requirements?: {
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
  }[];
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
  strength?: number;
  dexterity?: number;
  constitution?: number;
  intelligence?: number;
  wisdom?: number;
  charisma?: number;
  fortitude?: number;
  reflex?: number;
  will?: number;
  speedBonus?: number;
  speedMax?: number;
  speedMod?: number;
  size?: number;
  acArmor?: number;
  acShield?: number;
  acNatural?: number;
  acDeflection?: number;
  acMisc?: number;
  acDexterityAvailable?: boolean;
  acDexterityMax?: number;
  skillPenalty?: number;
  attackMelee?: number;
  attackRanged?: number;
  attackTouch?: number;
  attackGrapple?: number;
  damageMelee?: number;
  damageRanged?: number;
  hpTemp?: number;
  resistSpell?: number;
  resistPsionic?: number;
  resistAcid?: number;
  resistCold?: number;
  resistElectricity?: number;
  resistFire?: number;
  resistSonic?: number;
  resistForce?: number;
  resistNegativeEnergy?: number;
  resistPositiveEnergy?: number;
  resistPoison?: number;
  resistDisease?: number;
  resistDeathEffect?: number;
  resistBlunt?: number;
  resistPiercing?: number;
  resistSlashing?: number;
  resistGood?: number;
  resistEvil?: number;
  resistLawful?: number;
  resistChaotic?: number;
}
