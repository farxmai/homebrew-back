/*
  Warnings:

  - You are about to drop the column `charisma` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `constitution` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `dexterity` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `intelligence` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistAcid` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistBlunt` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistChaotic` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistCold` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistDeathEffect` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistDisease` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistElectricity` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistEvil` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistFire` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistForce` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistGood` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistLawful` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistNegativeEnergy` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistPiercing` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistPoison` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistPositiveEnergy` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistPsionic` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistSlashing` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistSonic` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `resistSpell` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `strength` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `wisdom` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the `FeatsOnSkillBonus` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `RaceOnSkillBonus` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "FeatsOnSkillBonus" DROP CONSTRAINT "FeatsOnSkillBonus_featId_fkey";

-- DropForeignKey
ALTER TABLE "FeatsOnSkillBonus" DROP CONSTRAINT "FeatsOnSkillBonus_skillId_fkey";

-- DropForeignKey
ALTER TABLE "RaceOnSkillBonus" DROP CONSTRAINT "RaceOnSkillBonus_characterRaceId_fkey";

-- DropForeignKey
ALTER TABLE "RaceOnSkillBonus" DROP CONSTRAINT "RaceOnSkillBonus_skillId_fkey";

-- AlterTable
ALTER TABLE "StatsBase" DROP COLUMN "charisma",
DROP COLUMN "constitution",
DROP COLUMN "dexterity",
DROP COLUMN "intelligence",
DROP COLUMN "resistAcid",
DROP COLUMN "resistBlunt",
DROP COLUMN "resistChaotic",
DROP COLUMN "resistCold",
DROP COLUMN "resistDeathEffect",
DROP COLUMN "resistDisease",
DROP COLUMN "resistElectricity",
DROP COLUMN "resistEvil",
DROP COLUMN "resistFire",
DROP COLUMN "resistForce",
DROP COLUMN "resistGood",
DROP COLUMN "resistLawful",
DROP COLUMN "resistNegativeEnergy",
DROP COLUMN "resistPiercing",
DROP COLUMN "resistPoison",
DROP COLUMN "resistPositiveEnergy",
DROP COLUMN "resistPsionic",
DROP COLUMN "resistSlashing",
DROP COLUMN "resistSonic",
DROP COLUMN "resistSpell",
DROP COLUMN "strength",
DROP COLUMN "wisdom",
ADD COLUMN     "acAgainstMissiles" INTEGER,
ADD COLUMN     "casterLevelMod" INTEGER,
ADD COLUMN     "cha" INTEGER,
ADD COLUMN     "con" INTEGER,
ADD COLUMN     "damageReduction" INTEGER,
ADD COLUMN     "damageReductionBypasses" TEXT,
ADD COLUMN     "dex" INTEGER,
ADD COLUMN     "energyResistAcid" INTEGER,
ADD COLUMN     "energyResistCold" INTEGER,
ADD COLUMN     "energyResistElectricity" INTEGER,
ADD COLUMN     "energyResistFire" INTEGER,
ADD COLUMN     "energyResistForce" INTEGER,
ADD COLUMN     "energyResistNegativeEnergy" INTEGER,
ADD COLUMN     "energyResistPositiveEnergy" INTEGER,
ADD COLUMN     "energyResistSonic" INTEGER,
ADD COLUMN     "int" INTEGER,
ADD COLUMN     "poisonResistance" INTEGER,
ADD COLUMN     "psyPowerResistance" INTEGER,
ADD COLUMN     "resistCritChance" INTEGER,
ADD COLUMN     "spellResistance" INTEGER,
ADD COLUMN     "str" INTEGER,
ADD COLUMN     "wis" INTEGER;

-- DropTable
DROP TABLE "FeatsOnSkillBonus";

-- DropTable
DROP TABLE "RaceOnSkillBonus";

-- CreateTable
CREATE TABLE "SkillBonusOnStatsBase" (
    "statsId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,
    "bonus" INTEGER NOT NULL,

    CONSTRAINT "SkillBonusOnStatsBase_pkey" PRIMARY KEY ("statsId","skillId")
);

-- AddForeignKey
ALTER TABLE "SkillBonusOnStatsBase" ADD CONSTRAINT "SkillBonusOnStatsBase_statsId_fkey" FOREIGN KEY ("statsId") REFERENCES "StatsBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SkillBonusOnStatsBase" ADD CONSTRAINT "SkillBonusOnStatsBase_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
