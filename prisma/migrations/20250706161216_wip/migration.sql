/*
  Warnings:

  - You are about to drop the column `casterLevelMod` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `energyResistNegativeEnergy` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `energyResistPositiveEnergy` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the column `psyPowerResistance` on the `StatsBase` table. All the data in the column will be lost.
  - You are about to drop the `FeatRequirement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FeatRequirementOnFeat` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FeatRequirementOnSkill` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "FeatRequirement" DROP CONSTRAINT "FeatRequirement_classId_fkey";

-- DropForeignKey
ALTER TABLE "FeatRequirement" DROP CONSTRAINT "FeatRequirement_featId_fkey";

-- DropForeignKey
ALTER TABLE "FeatRequirementOnFeat" DROP CONSTRAINT "FeatRequirementOnFeat_featId_fkey";

-- DropForeignKey
ALTER TABLE "FeatRequirementOnFeat" DROP CONSTRAINT "FeatRequirementOnFeat_featRequirementId_fkey";

-- DropForeignKey
ALTER TABLE "FeatRequirementOnSkill" DROP CONSTRAINT "FeatRequirementOnSkill_featId_fkey";

-- DropForeignKey
ALTER TABLE "FeatRequirementOnSkill" DROP CONSTRAINT "FeatRequirementOnSkill_skillId_fkey";

-- AlterTable
ALTER TABLE "Feat" ADD COLUMN     "featRequirementId" INTEGER,
ADD COLUMN     "requirementId" INTEGER;

-- AlterTable
ALTER TABLE "StatsBase" DROP COLUMN "casterLevelMod",
DROP COLUMN "energyResistNegativeEnergy",
DROP COLUMN "energyResistPositiveEnergy",
DROP COLUMN "psyPowerResistance",
ADD COLUMN     "casterLevelModifier" INTEGER,
ADD COLUMN     "charmResistance" INTEGER,
ADD COLUMN     "deathResistance" INTEGER,
ADD COLUMN     "diseaseResistance" INTEGER,
ADD COLUMN     "energyResistNegative" INTEGER,
ADD COLUMN     "energyResistPositive" INTEGER,
ADD COLUMN     "fatigueResistance" INTEGER,
ADD COLUMN     "fearResistance" INTEGER,
ADD COLUMN     "mindAffectingResistance" INTEGER,
ADD COLUMN     "paralysisResistance" INTEGER,
ADD COLUMN     "psionicResistance" INTEGER,
ADD COLUMN     "sleepResistance" INTEGER;

-- DropTable
DROP TABLE "FeatRequirement";

-- DropTable
DROP TABLE "FeatRequirementOnFeat";

-- DropTable
DROP TABLE "FeatRequirementOnSkill";

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
    "other" TEXT,
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

-- AddForeignKey
ALTER TABLE "Feat" ADD CONSTRAINT "Feat_featRequirementId_fkey" FOREIGN KEY ("featRequirementId") REFERENCES "Requirement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

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
