/*
  Warnings:

  - You are about to drop the column `charisma` on the `CharacterAbilities` table. All the data in the column will be lost.
  - You are about to drop the column `constitution` on the `CharacterAbilities` table. All the data in the column will be lost.
  - You are about to drop the column `dexterity` on the `CharacterAbilities` table. All the data in the column will be lost.
  - You are about to drop the column `intelligence` on the `CharacterAbilities` table. All the data in the column will be lost.
  - You are about to drop the column `strength` on the `CharacterAbilities` table. All the data in the column will be lost.
  - You are about to drop the column `wisdom` on the `CharacterAbilities` table. All the data in the column will be lost.
  - You are about to drop the column `requiredCharisma` on the `FeatRequirement` table. All the data in the column will be lost.
  - You are about to drop the column `requiredConstitution` on the `FeatRequirement` table. All the data in the column will be lost.
  - You are about to drop the column `requiredDexterity` on the `FeatRequirement` table. All the data in the column will be lost.
  - You are about to drop the column `requiredIntelligence` on the `FeatRequirement` table. All the data in the column will be lost.
  - You are about to drop the column `requiredStrength` on the `FeatRequirement` table. All the data in the column will be lost.
  - You are about to drop the column `requiredWisdom` on the `FeatRequirement` table. All the data in the column will be lost.
  - You are about to drop the `ClassLvlBonuses` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `cha` to the `CharacterAbilities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `con` to the `CharacterAbilities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dex` to the `CharacterAbilities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `int` to the `CharacterAbilities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `str` to the `CharacterAbilities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `wis` to the `CharacterAbilities` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CharacterAbilities" DROP CONSTRAINT "CharacterAbilities_characterId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterClassOnSkill" DROP CONSTRAINT "CharacterClassOnSkill_characterClassId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterClassOnSkill" DROP CONSTRAINT "CharacterClassOnSkill_skillId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterHp" DROP CONSTRAINT "CharacterHp_characterId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterOnClass" DROP CONSTRAINT "CharacterOnClass_characterClassId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterOnClass" DROP CONSTRAINT "CharacterOnClass_characterId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterOnRace" DROP CONSTRAINT "CharacterOnRace_characterId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterOnRace" DROP CONSTRAINT "CharacterOnRace_characterRaceId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterRace" DROP CONSTRAINT "CharacterRace_statsId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterSave" DROP CONSTRAINT "CharacterSave_characterId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterSkill" DROP CONSTRAINT "CharacterSkill_characterId_fkey";

-- DropForeignKey
ALTER TABLE "CharacterSkill" DROP CONSTRAINT "CharacterSkill_skillId_fkey";

-- DropForeignKey
ALTER TABLE "ClassLvlBonuses" DROP CONSTRAINT "ClassLvlBonuses_characterClassId_fkey";

-- DropForeignKey
ALTER TABLE "ClassSpellKnown" DROP CONSTRAINT "ClassSpellKnown_classLevelId_fkey";

-- DropForeignKey
ALTER TABLE "ClassSpellPerDay" DROP CONSTRAINT "ClassSpellPerDay_classLevelId_fkey";

-- DropForeignKey
ALTER TABLE "SkillBonus" DROP CONSTRAINT "SkillBonus_skillId_fkey";

-- AlterTable
ALTER TABLE "CharacterAbilities" DROP COLUMN "charisma",
DROP COLUMN "constitution",
DROP COLUMN "dexterity",
DROP COLUMN "intelligence",
DROP COLUMN "strength",
DROP COLUMN "wisdom",
ADD COLUMN     "cha" INTEGER NOT NULL,
ADD COLUMN     "con" INTEGER NOT NULL,
ADD COLUMN     "dex" INTEGER NOT NULL,
ADD COLUMN     "int" INTEGER NOT NULL,
ADD COLUMN     "str" INTEGER NOT NULL,
ADD COLUMN     "wis" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "CharacterRace" ALTER COLUMN "statsId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "FeatRequirement" DROP COLUMN "requiredCharisma",
DROP COLUMN "requiredConstitution",
DROP COLUMN "requiredDexterity",
DROP COLUMN "requiredIntelligence",
DROP COLUMN "requiredStrength",
DROP COLUMN "requiredWisdom",
ADD COLUMN     "cha" INTEGER,
ADD COLUMN     "con" INTEGER,
ADD COLUMN     "dex" INTEGER,
ADD COLUMN     "int" INTEGER,
ADD COLUMN     "str" INTEGER,
ADD COLUMN     "wis" INTEGER;

-- DropTable
DROP TABLE "ClassLvlBonuses";

-- CreateTable
CREATE TABLE "ClassLvlBonus" (
    "id" SERIAL NOT NULL,
    "characterClassId" INTEGER NOT NULL,
    "level" INTEGER NOT NULL,
    "baseAttack" INTEGER NOT NULL,
    "fortitude" INTEGER NOT NULL,
    "reflex" INTEGER NOT NULL,
    "will" INTEGER NOT NULL,
    "spellPoints" INTEGER NOT NULL,

    CONSTRAINT "ClassLvlBonus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FeatsOnClassLevelBonus" (
    "featId" INTEGER NOT NULL,
    "classLevelBonusId" INTEGER NOT NULL,

    CONSTRAINT "FeatsOnClassLevelBonus_pkey" PRIMARY KEY ("featId","classLevelBonusId")
);

-- CreateIndex
CREATE INDEX "ClassLvlBonus_characterClassId_idx" ON "ClassLvlBonus"("characterClassId");

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
ALTER TABLE "CharacterClassOnSkill" ADD CONSTRAINT "CharacterClassOnSkill_characterClassId_fkey" FOREIGN KEY ("characterClassId") REFERENCES "CharacterClass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterClassOnSkill" ADD CONSTRAINT "CharacterClassOnSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SkillBonus" ADD CONSTRAINT "SkillBonus_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSkill" ADD CONSTRAINT "CharacterSkill_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterSkill" ADD CONSTRAINT "CharacterSkill_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatsOnClassLevelBonus" ADD CONSTRAINT "FeatsOnClassLevelBonus_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FeatsOnClassLevelBonus" ADD CONSTRAINT "FeatsOnClassLevelBonus_classLevelBonusId_fkey" FOREIGN KEY ("classLevelBonusId") REFERENCES "ClassLvlBonus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
