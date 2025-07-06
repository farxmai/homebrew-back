/*
  Warnings:

  - You are about to drop the column `classLevel` on the `FeatRequirement` table. All the data in the column will be lost.
  - Added the required column `descriptionShort` to the `CharacterClass` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descriptionShort` to the `CharacterRace` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descriptionShort` to the `Feat` table without a default value. This is not possible if the table is not empty.
  - Added the required column `descriptionShort` to the `SkillBase` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CharacterClass" ADD COLUMN     "descriptionShort" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "CharacterRace" ADD COLUMN     "descriptionShort" TEXT NOT NULL,
ADD COLUMN     "skillPointsAfterFirst" INTEGER,
ADD COLUMN     "skillPointsFist" INTEGER;

-- AlterTable
ALTER TABLE "ClassLvlBonus" ALTER COLUMN "spellPoints" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Feat" ADD COLUMN     "descriptionShort" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "FeatRequirement" DROP COLUMN "classLevel",
ADD COLUMN     "minClassLevel" INTEGER;

-- AlterTable
ALTER TABLE "SkillBase" ADD COLUMN     "descriptionShort" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Language" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "source" TEXT NOT NULL,

    CONSTRAINT "Language_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CharacterLanguages" (
    "languageId" INTEGER NOT NULL,
    "characterId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "RaceOnSkillBonus" (
    "characterRaceId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL,
    "bonus" INTEGER NOT NULL,

    CONSTRAINT "RaceOnSkillBonus_pkey" PRIMARY KEY ("characterRaceId","skillId")
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

-- CreateIndex
CREATE UNIQUE INDEX "Language_name_key" ON "Language"("name");

-- CreateIndex
CREATE INDEX "Language_name_idx" ON "Language"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterLanguages_characterId_key" ON "CharacterLanguages"("characterId");

-- CreateIndex
CREATE INDEX "CharacterLanguages_languageId_characterId_idx" ON "CharacterLanguages"("languageId", "characterId");

-- AddForeignKey
ALTER TABLE "CharacterLanguages" ADD CONSTRAINT "CharacterLanguages_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES "Language"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CharacterLanguages" ADD CONSTRAINT "CharacterLanguages_characterId_fkey" FOREIGN KEY ("characterId") REFERENCES "Character"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnSkillBonus" ADD CONSTRAINT "RaceOnSkillBonus_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnSkillBonus" ADD CONSTRAINT "RaceOnSkillBonus_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnLanguage" ADD CONSTRAINT "RaceOnLanguage_languageId_fkey" FOREIGN KEY ("languageId") REFERENCES "Language"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnLanguage" ADD CONSTRAINT "RaceOnLanguage_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnFeat" ADD CONSTRAINT "RaceOnFeat_featId_fkey" FOREIGN KEY ("featId") REFERENCES "Feat"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RaceOnFeat" ADD CONSTRAINT "RaceOnFeat_characterRaceId_fkey" FOREIGN KEY ("characterRaceId") REFERENCES "CharacterRace"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
