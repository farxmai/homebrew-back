/*
  Warnings:

  - Added the required column `source` to the `CharacterClass` table without a default value. This is not possible if the table is not empty.
  - Added the required column `source` to the `CharacterRace` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isStackable` to the `Feat` table without a default value. This is not possible if the table is not empty.
  - Added the required column `source` to the `Feat` table without a default value. This is not possible if the table is not empty.
  - Added the required column `source` to the `SkillBase` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CharacterClass" ADD COLUMN     "source" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "CharacterRace" ADD COLUMN     "source" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Feat" ADD COLUMN     "isStackable" BOOLEAN NOT NULL,
ADD COLUMN     "source" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "FeatRequirement" ADD COLUMN     "casterOnly" BOOLEAN,
ADD COLUMN     "classId" INTEGER,
ADD COLUMN     "classLevel" INTEGER,
ADD COLUMN     "divineOnly" BOOLEAN,
ADD COLUMN     "minBaseAttack" INTEGER,
ADD COLUMN     "other" TEXT;

-- AlterTable
ALTER TABLE "SkillBase" ADD COLUMN     "source" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "FeatRequirement" ADD CONSTRAINT "FeatRequirement_classId_fkey" FOREIGN KEY ("classId") REFERENCES "CharacterClass"("id") ON DELETE SET NULL ON UPDATE CASCADE;
