-- CreateTable
CREATE TABLE "StatsBase" (
    "id" SERIAL NOT NULL,
    "strength" INTEGER NOT NULL,
    "dexterity" INTEGER NOT NULL,
    "constitution" INTEGER NOT NULL,
    "intelligence" INTEGER NOT NULL,
    "wisdom" INTEGER NOT NULL,
    "charisma" INTEGER NOT NULL,
    "fortitude" INTEGER NOT NULL,
    "reflex" INTEGER NOT NULL,
    "will" INTEGER NOT NULL,
    "speedBonus" INTEGER NOT NULL,
    "speedMax" INTEGER NOT NULL,
    "speedMod" INTEGER NOT NULL,
    "size" INTEGER NOT NULL,
    "acArmor" INTEGER NOT NULL,
    "acShield" INTEGER NOT NULL,
    "acNatural" INTEGER NOT NULL,
    "acDeflection" INTEGER NOT NULL,
    "acMisc" INTEGER NOT NULL,
    "acDexterityAvailable" BOOLEAN NOT NULL,
    "acDexterityMax" INTEGER NOT NULL,
    "skillPenalty" INTEGER NOT NULL,
    "attackMelee" INTEGER NOT NULL,
    "attackRanged" INTEGER NOT NULL,
    "attackTouch" INTEGER NOT NULL,
    "attackGrapple" INTEGER NOT NULL,
    "damageMelee" INTEGER NOT NULL,
    "damageRanged" INTEGER NOT NULL,
    "hpTemp" INTEGER NOT NULL,
    "resistSpell" INTEGER NOT NULL,
    "resistPsionic" INTEGER NOT NULL,
    "resistAcid" INTEGER NOT NULL,
    "resistCold" INTEGER NOT NULL,
    "resistElectricity" INTEGER NOT NULL,
    "resistFire" INTEGER NOT NULL,
    "resistSonic" INTEGER NOT NULL,
    "resistForce" INTEGER NOT NULL,
    "resistNegativeEnergy" INTEGER NOT NULL,
    "resistPositiveEnergy" INTEGER NOT NULL,
    "resistPoison" INTEGER NOT NULL,
    "resistDisease" INTEGER NOT NULL,
    "resistDeathEffect" INTEGER NOT NULL,
    "resistBlunt" INTEGER NOT NULL,
    "resistPiercing" INTEGER NOT NULL,
    "resistSlashing" INTEGER NOT NULL,
    "resistGood" INTEGER NOT NULL,
    "resistEvil" INTEGER NOT NULL,
    "resistLawful" INTEGER NOT NULL,
    "resistChaotic" INTEGER NOT NULL,

    CONSTRAINT "StatsBase_pkey" PRIMARY KEY ("id")
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
    "strength" INTEGER NOT NULL,
    "dexterity" INTEGER NOT NULL,
    "constitution" INTEGER NOT NULL,
    "intelligence" INTEGER NOT NULL,
    "wisdom" INTEGER NOT NULL,
    "charisma" INTEGER NOT NULL,
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
    "speed" INTEGER NOT NULL,
    "size" TEXT NOT NULL,
    "statsId" INTEGER NOT NULL,

    CONSTRAINT "CharacterRace_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassLvlBonuses" (
    "id" SERIAL NOT NULL,
    "characterClassId" INTEGER NOT NULL,
    "level" INTEGER NOT NULL,
    "baseAttack" INTEGER NOT NULL,
    "fortitude" INTEGER NOT NULL,
    "reflex" INTEGER NOT NULL,
    "will" INTEGER NOT NULL,
    "spellPoints" INTEGER NOT NULL,

    CONSTRAINT "ClassLvlBonuses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassSpellKnown" (
    "id" SERIAL NOT NULL,
    "spellLevel" INTEGER NOT NULL,
    "knownPerLevel" INTEGER NOT NULL,
    "classLevelId" INTEGER NOT NULL,

    CONSTRAINT "ClassSpellKnown_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassSpellPerDay" (
    "id" SERIAL NOT NULL,
    "spellLevel" INTEGER NOT NULL,
    "perDay" INTEGER NOT NULL,
    "classLevelId" INTEGER NOT NULL,

    CONSTRAINT "ClassSpellPerDay_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterOnClass" (
    "characterId" INTEGER NOT NULL,
    "characterClassId" INTEGER NOT NULL,

    CONSTRAINT "CharacterOnClass_pkey" PRIMARY KEY ("characterId","characterClassId")
);

-- CreateTable
CREATE TABLE "CharacterClass" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "hitDie" INTEGER NOT NULL,
    "baseAttack" INTEGER NOT NULL,
    "fortitude" INTEGER NOT NULL,
    "reflex" INTEGER NOT NULL,
    "will" INTEGER NOT NULL,
    "skills" INTEGER NOT NULL,
    "skillPointsFist" INTEGER NOT NULL,
    "skillPointsAfterFirst" INTEGER NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "CharacterClass_pkey" PRIMARY KEY ("id")
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
    "ability" TEXT NOT NULL,
    "trainedOnly" BOOLEAN NOT NULL,
    "armorCheckPenalty" INTEGER NOT NULL,

    CONSTRAINT "SkillBase_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SkillBonus" (
    "id" SERIAL NOT NULL,
    "skillId" INTEGER NOT NULL,
    "bonus" INTEGER NOT NULL,

    CONSTRAINT "SkillBonus_pkey" PRIMARY KEY ("id")
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
    "type" TEXT NOT NULL,
    "isPassive" BOOLEAN NOT NULL,
    "isFighterBonusFeat" BOOLEAN NOT NULL,
    "statsId" INTEGER,

    CONSTRAINT "Feat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeatsOnSkillBonus" (
    "featId" INTEGER NOT NULL,
    "skillBonusId" INTEGER NOT NULL,

    CONSTRAINT "FeatsOnSkillBonus_pkey" PRIMARY KEY ("featId","skillBonusId")
);

-- CreateTable
CREATE TABLE "FeatRequirement" (
    "id" SERIAL NOT NULL,
    "featId" INTEGER NOT NULL,
    "requiredStrength" INTEGER,
    "requiredDexterity" INTEGER,
    "requiredConstitution" INTEGER,
    "requiredIntelligence" INTEGER,
    "requiredWisdom" INTEGER,
    "requiredCharisma" INTEGER,

    CONSTRAINT "FeatRequirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeatRequirementOnFeat" (
    "featRequirementId" INTEGER NOT NULL,
    "featId" INTEGER NOT NULL,

    CONSTRAINT "FeatRequirementOnFeat_pkey" PRIMARY KEY ("featRequirementId","featId")
);

-- CreateTable
CREATE TABLE "FeatRequirementOnSkill" (
    "featId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,
    "minRank" INTEGER NOT NULL,

    CONSTRAINT "FeatRequirementOnSkill_pkey" PRIMARY KEY ("featId","skillId")
);

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
CREATE INDEX "ClassLvlBonuses_characterClassId_idx" ON "ClassLvlBonuses"("characterClassId");

-- CreateIndex
CREATE INDEX "ClassSpellKnown_classLevelId_idx" ON "ClassSpellKnown"("classLevelId");

-- CreateIndex
CREATE INDEX "ClassSpellPerDay_classLevelId_idx" ON "ClassSpellPerDay"("classLevelId");

-- CreateIndex
CREATE INDEX "SkillBonus_skillId_idx" ON "SkillBonus"("skillId");

-- CreateIndex
CREATE INDEX "CharacterSkill_characterId_idx" ON "CharacterSkill"("characterId");

-- CreateIndex
CREATE INDEX "CharacterSkill_skillId_idx" ON "CharacterSkill"("skillId");

-- CreateIndex
CREATE INDEX "FeatRequirement_featId_idx" ON "FeatRequirement"("featId");

-- AddForeignKey
ALTER TABLE "CharacterHp" ADD CONSTRAINT "CharacterHp_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterAbilities" ADD CONSTRAINT "CharacterAbilities_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSave" ADD CONSTRAINT "CharacterSave_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnRace" ADD CONSTRAINT "CharacterOnRace_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnRace" ADD CONSTRAINT "CharacterOnRace_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterRace" ADD CONSTRAINT "CharacterRace_statsId_fkey" FOREIGN KEY ("statsId") REFERENCES "StatsBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassLvlBonuses" ADD CONSTRAINT "ClassLvlBonuses_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassSpellKnown" ADD CONSTRAINT "ClassSpellKnown_classLevelId_fkey" FOREIGN KEY ("classLevelId") REFERENCES "ClassLvlBonuses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassSpellPerDay" ADD CONSTRAINT "ClassSpellPerDay_classLevelId_fkey" FOREIGN KEY ("classLevelId") REFERENCES "ClassLvlBonuses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnClass" ADD CONSTRAINT "CharacterOnClass_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterOnClass" ADD CONSTRAINT "CharacterOnClass_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterClassOnSkill" ADD CONSTRAINT "CharacterClassOnSkill_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterClassOnSkill" ADD CONSTRAINT "CharacterClassOnSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SkillBonus" ADD CONSTRAINT "SkillBonus_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSkill" ADD CONSTRAINT "CharacterSkill_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSkill" ADD CONSTRAINT "CharacterSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_statsId_fkey" FOREIGN KEY ("statsId") REFERENCES "StatsBase"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatsOnSkillBonus" ADD CONSTRAINT "FeatsOnSkillBonus_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatsOnSkillBonus" ADD CONSTRAINT "FeatsOnSkillBonus_skillBonusId_fkey" FOREIGN KEY ("skillBonusId") REFERENCES "SkillBonus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatRequirement" ADD CONSTRAINT "FeatRequirement_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatRequirementOnFeat" ADD CONSTRAINT "FeatRequirementOnFeat_featRequirementId_fkey" FOREIGN KEY ("featRequirementId") REFERENCES "FeatRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatRequirementOnFeat" ADD CONSTRAINT "FeatRequirementOnFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatRequirementOnSkill" ADD CONSTRAINT "FeatRequirementOnSkill_featId_fkey" FOREIGN KEY ("featId") REFERENCES "FeatRequirement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatRequirementOnSkill" ADD CONSTRAINT "FeatRequirementOnSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
