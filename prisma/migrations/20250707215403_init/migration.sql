-- CreateTable
CREATE TABLE "StatsBase" (
    "id" SERIAL NOT NULL,
    "str" INTEGER,
    "dex" INTEGER,
    "con" INTEGER,
    "int" INTEGER,
    "wis" INTEGER,
    "cha" INTEGER,
    "fortitude" INTEGER,
    "reflex" INTEGER,
    "will" INTEGER,
    "speedBonus" INTEGER,
    "speedMax" INTEGER,
    "speedMod" INTEGER,
    "size" INTEGER,
    "acArmor" INTEGER,
    "acShield" INTEGER,
    "acNatural" INTEGER,
    "acDeflection" INTEGER,
    "acAgainstMissiles" INTEGER,
    "acMisc" INTEGER,
    "acDexterityAvailable" BOOLEAN,
    "acDexterityMax" INTEGER,
    "skillPenalty" INTEGER,
    "attackMelee" INTEGER,
    "attackRanged" INTEGER,
    "attackTouch" INTEGER,
    "attackGrapple" INTEGER,
    "damageMelee" INTEGER,
    "damageRanged" INTEGER,
    "hpTemp" INTEGER,
    "damageReduction" INTEGER,
    "damageReductionBypasses" TEXT,
    "resistCritChance" INTEGER,
    "energyResistAcid" INTEGER,
    "energyResistCold" INTEGER,
    "energyResistElectricity" INTEGER,
    "energyResistFire" INTEGER,
    "energyResistSonic" INTEGER,
    "energyResistForce" INTEGER,
    "energyResistNegative" INTEGER,
    "energyResistPositive" INTEGER,
    "poisonResistance" INTEGER,
    "charmResistance" INTEGER,
    "fearResistance" INTEGER,
    "sleepResistance" INTEGER,
    "diseaseResistance" INTEGER,
    "mindAffectingResistance" INTEGER,
    "deathResistance" INTEGER,
    "paralysisResistance" INTEGER,
    "fatigueResistance" INTEGER,
    "spellResistance" INTEGER,
    "psionicResistance" INTEGER,
    "casterLevelModifier" INTEGER,

    CONSTRAINT "StatsBase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SkillBonusOnStatsBase" (
    "statsId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,
    "bonus" INTEGER NOT NULL,

    CONSTRAINT "SkillBonusOnStatsBase_pkey" PRIMARY KEY ("statsId","skillId")
);

-- CreateTable
CREATE TABLE "Language" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,

    CONSTRAINT "Language_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Character" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "player" TEXT NOT NULL,
    "alignment" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "gender" TEXT NOT NULL,
    "background" TEXT NOT NULL,

    CONSTRAINT "Character_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterLanguages" (
    "languageId" INTEGER NOT NULL,
    "characterId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "CharacterHp" (
    "id" SERIAL NOT NULL,
    "max" INTEGER NOT NULL,
    "current" INTEGER NOT NULL,
    "temp" INTEGER NOT NULL,
    "nonlethal" INTEGER NOT NULL,
    "characterId" INTEGER NOT NULL,

    CONSTRAINT "CharacterHp_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterAbilities" (
    "id" SERIAL NOT NULL,
    "str" INTEGER NOT NULL,
    "dex" INTEGER NOT NULL,
    "con" INTEGER NOT NULL,
    "int" INTEGER NOT NULL,
    "wis" INTEGER NOT NULL,
    "cha" INTEGER NOT NULL,
    "characterId" INTEGER NOT NULL,

    CONSTRAINT "CharacterAbilities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterSave" (
    "id" SERIAL NOT NULL,
    "fortitude" INTEGER NOT NULL,
    "reflex" INTEGER NOT NULL,
    "will" INTEGER NOT NULL,
    "characterId" INTEGER NOT NULL,

    CONSTRAINT "CharacterSave_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterOnRace" (
    "characterId" INTEGER NOT NULL,
    "characterRaceId" INTEGER NOT NULL,

    CONSTRAINT "CharacterOnRace_pkey" PRIMARY KEY ("characterId","characterRaceId")
);

-- CreateTable
CREATE TABLE "CharacterRace" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "speed" INTEGER NOT NULL,
    "size" INTEGER NOT NULL,
    "statsId" INTEGER,
    "skillPointsFist" INTEGER,
    "skillPointsAfterFirst" INTEGER,

    CONSTRAINT "CharacterRace_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterRaceTranslation" (
    "id" SERIAL NOT NULL,
    "characterRaceId" INTEGER NOT NULL,
    "locale" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,

    CONSTRAINT "CharacterRaceTranslation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RaceOnLanguage" (
    "languageId" INTEGER NOT NULL,
    "isAutomatic" BOOLEAN NOT NULL,
    "characterRaceId" INTEGER NOT NULL,

    CONSTRAINT "RaceOnLanguage_pkey" PRIMARY KEY ("characterRaceId","languageId")
);

-- CreateTable
CREATE TABLE "RaceOnFeat" (
    "featId" INTEGER NOT NULL,
    "characterRaceId" INTEGER NOT NULL,

    CONSTRAINT "RaceOnFeat_pkey" PRIMARY KEY ("characterRaceId","featId")
);

-- CreateTable
CREATE TABLE "ClassLvlBonus" (
    "id" SERIAL NOT NULL,
    "characterClassId" INTEGER NOT NULL,
    "level" INTEGER NOT NULL,
    "baseAttack" INTEGER NOT NULL,
    "fortitude" INTEGER NOT NULL,
    "reflex" INTEGER NOT NULL,
    "will" INTEGER NOT NULL,
    "spellPoints" INTEGER,

    CONSTRAINT "ClassLvlBonus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassSpellKnown" (
    "id" SERIAL NOT NULL,
    "classLevelId" INTEGER NOT NULL,
    "spellLevel" INTEGER NOT NULL,
    "knownPerLevel" INTEGER NOT NULL,

    CONSTRAINT "ClassSpellKnown_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassSpellPerDay" (
    "id" SERIAL NOT NULL,
    "classLevelId" INTEGER NOT NULL,
    "spellLevel" INTEGER NOT NULL,
    "perDay" INTEGER NOT NULL,

    CONSTRAINT "ClassSpellPerDay_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterOnClass" (
    "characterId" INTEGER NOT NULL,
    "characterClassId" INTEGER NOT NULL,
    "level" INTEGER NOT NULL,

    CONSTRAINT "CharacterOnClass_pkey" PRIMARY KEY ("characterId","characterClassId")
);

-- CreateTable
CREATE TABLE "CharacterClass" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "hitDice" INTEGER NOT NULL,
    "skillPointsFist" INTEGER NOT NULL,
    "skillPointsAfterFirst" INTEGER NOT NULL,
    "baseAttribute" TEXT NOT NULL,

    CONSTRAINT "CharacterClass_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterClassTranslation" (
    "id" SERIAL NOT NULL,
    "characterClassId" INTEGER NOT NULL,
    "locale" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,

    CONSTRAINT "CharacterClassTranslation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterClassOnSkill" (
    "characterClassId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,

    CONSTRAINT "CharacterClassOnSkill_pkey" PRIMARY KEY ("characterClassId","skillId")
);

-- CreateTable
CREATE TABLE "SkillBase" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "ability" TEXT NOT NULL,
    "trainedOnly" BOOLEAN NOT NULL,
    "armorCheckPenalty" INTEGER NOT NULL,

    CONSTRAINT "SkillBase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SkillBaseTranslation" (
    "id" SERIAL NOT NULL,
    "skillId" INTEGER NOT NULL,
    "locale" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,

    CONSTRAINT "SkillBaseTranslation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterSkill" (
    "id" SERIAL NOT NULL,
    "characterId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,
    "ranks" INTEGER NOT NULL,

    CONSTRAINT "CharacterSkill_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Feat" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "isPassive" BOOLEAN NOT NULL,
    "isFighterBonusFeat" BOOLEAN NOT NULL,
    "isStackable" BOOLEAN NOT NULL,
    "statsId" INTEGER,
    "requirementId" INTEGER,
    "requirementDescription" TEXT,
    "featRequirementId" INTEGER,

    CONSTRAINT "Feat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeatTranslation" (
    "id" SERIAL NOT NULL,
    "featId" INTEGER NOT NULL,
    "locale" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "descriptionShort" TEXT NOT NULL,
    "requirementDescription" TEXT,

    CONSTRAINT "FeatTranslation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeatsOnClassLevelBonus" (
    "featId" INTEGER NOT NULL,
    "classLevelBonusId" INTEGER NOT NULL,

    CONSTRAINT "FeatsOnClassLevelBonus_pkey" PRIMARY KEY ("featId","classLevelBonusId")
);

-- CreateTable
CREATE TABLE "Requirement" (
    "id" SERIAL NOT NULL,
    "str" INTEGER,
    "dex" INTEGER,
    "con" INTEGER,
    "int" INTEGER,
    "wis" INTEGER,
    "cha" INTEGER,
    "minBaseAttack" INTEGER,
    "casterOnly" BOOLEAN,
    "divineOnly" BOOLEAN,
    "minClassLevel" INTEGER,
    "classId" INTEGER,

    CONSTRAINT "Requirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RequirementOnFeat" (
    "requirementId" INTEGER NOT NULL,
    "featId" INTEGER NOT NULL,

    CONSTRAINT "RequirementOnFeat_pkey" PRIMARY KEY ("requirementId","featId")
);

-- CreateTable
CREATE TABLE "RequirementOnSkill" (
    "requirementId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,
    "minRank" INTEGER NOT NULL,

    CONSTRAINT "RequirementOnSkill_pkey" PRIMARY KEY ("requirementId","skillId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Language_name_key" ON "Language"("name");

-- CreateIndex
CREATE INDEX "Language_name_idx" ON "Language"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterLanguages_characterId_key" ON "CharacterLanguages"("characterId");

-- CreateIndex
CREATE INDEX "CharacterLanguages_languageId_characterId_idx" ON "CharacterLanguages"("languageId", "characterId");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterHp_characterId_key" ON "CharacterHp"("characterId");

-- CreateIndex
CREATE INDEX "CharacterHp_characterId_idx" ON "CharacterHp"("characterId");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterAbilities_characterId_key" ON "CharacterAbilities"("characterId");

-- CreateIndex
CREATE INDEX "CharacterAbilities_characterId_idx" ON "CharacterAbilities"("characterId");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterSave_characterId_key" ON "CharacterSave"("characterId");

-- CreateIndex
CREATE INDEX "CharacterSave_characterId_idx" ON "CharacterSave"("characterId");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterRace_name_key" ON "CharacterRace"("name");

-- CreateIndex
CREATE INDEX "CharacterRaceTranslation_characterRaceId_idx" ON "CharacterRaceTranslation"("characterRaceId");

-- CreateIndex
CREATE INDEX "ClassLvlBonus_characterClassId_idx" ON "ClassLvlBonus"("characterClassId");

-- CreateIndex
CREATE INDEX "ClassSpellKnown_classLevelId_idx" ON "ClassSpellKnown"("classLevelId");

-- CreateIndex
CREATE INDEX "ClassSpellPerDay_classLevelId_idx" ON "ClassSpellPerDay"("classLevelId");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterClass_name_key" ON "CharacterClass"("name");

-- CreateIndex
CREATE INDEX "CharacterClassTranslation_characterClassId_idx" ON "CharacterClassTranslation"("characterClassId");

-- CreateIndex
CREATE UNIQUE INDEX "SkillBase_name_key" ON "SkillBase"("name");

-- CreateIndex
CREATE INDEX "SkillBaseTranslation_skillId_idx" ON "SkillBaseTranslation"("skillId");

-- CreateIndex
CREATE INDEX "CharacterSkill_characterId_skillId_idx" ON "CharacterSkill"("characterId", "skillId");

-- CreateIndex
CREATE UNIQUE INDEX "Feat_name_key" ON "Feat"("name");

-- CreateIndex
CREATE INDEX "FeatTranslation_featId_idx" ON "FeatTranslation"("featId");

-- AddForeignKey
ALTER TABLE "SkillBonusOnStatsBase" ADD CONSTRAINT "SkillBonusOnStatsBase_statsId_fkey" FOREIGN KEY ("statsId") REFERENCES "StatsBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SkillBonusOnStatsBase" ADD CONSTRAINT "SkillBonusOnStatsBase_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterLanguages" ADD CONSTRAINT "CharacterLanguages_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES "Language"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterLanguages" ADD CONSTRAINT "CharacterLanguages_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterHp" ADD CONSTRAINT "CharacterHp_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterAbilities" ADD CONSTRAINT "CharacterAbilities_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSave" ADD CONSTRAINT "CharacterSave_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnRace" ADD CONSTRAINT "CharacterOnRace_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnRace" ADD CONSTRAINT "CharacterOnRace_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterRace" ADD CONSTRAINT "CharacterRace_statsId_fkey" FOREIGN KEY ("statsId") REFERENCES "StatsBase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterRaceTranslation" ADD CONSTRAINT "CharacterRaceTranslation_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnLanguage" ADD CONSTRAINT "RaceOnLanguage_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES "Language"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnLanguage" ADD CONSTRAINT "RaceOnLanguage_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnFeat" ADD CONSTRAINT "RaceOnFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnFeat" ADD CONSTRAINT "RaceOnFeat_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassLvlBonus" ADD CONSTRAINT "ClassLvlBonus_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassSpellKnown" ADD CONSTRAINT "ClassSpellKnown_classLevelId_fkey" FOREIGN KEY ("classLevelId") REFERENCES "ClassLvlBonus"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassSpellPerDay" ADD CONSTRAINT "ClassSpellPerDay_classLevelId_fkey" FOREIGN KEY ("classLevelId") REFERENCES "ClassLvlBonus"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnClass" ADD CONSTRAINT "CharacterOnClass_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnClass" ADD CONSTRAINT "CharacterOnClass_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterClassTranslation" ADD CONSTRAINT "CharacterClassTranslation_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterClassOnSkill" ADD CONSTRAINT "CharacterClassOnSkill_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterClassOnSkill" ADD CONSTRAINT "CharacterClassOnSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SkillBaseTranslation" ADD CONSTRAINT "SkillBaseTranslation_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSkill" ADD CONSTRAINT "CharacterSkill_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSkill" ADD CONSTRAINT "CharacterSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_statsId_fkey" FOREIGN KEY ("statsId") REFERENCES "StatsBase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_featRequirementId_fkey" FOREIGN KEY ("featRequirementId") REFERENCES "Requirement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatTranslation" ADD CONSTRAINT "FeatTranslation_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatsOnClassLevelBonus" ADD CONSTRAINT "FeatsOnClassLevelBonus_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatsOnClassLevelBonus" ADD CONSTRAINT "FeatsOnClassLevelBonus_classLevelBonusId_fkey" FOREIGN KEY ("classLevelBonusId") REFERENCES "ClassLvlBonus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Requirement" ADD CONSTRAINT "Requirement_classId_fkey" FOREIGN KEY ("classId") REFERENCES "CharacterClass"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequirementOnFeat" ADD CONSTRAINT "RequirementOnFeat_requirementId_fkey" FOREIGN KEY ("requirementId") REFERENCES "Requirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequirementOnFeat" ADD CONSTRAINT "RequirementOnFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequirementOnSkill" ADD CONSTRAINT "RequirementOnSkill_requirementId_fkey" FOREIGN KEY ("requirementId") REFERENCES "Requirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RequirementOnSkill" ADD CONSTRAINT "RequirementOnSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
