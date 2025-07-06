/*
  Warnings:

  - You are about to drop the column `hitDie` on the `CharacterClass` table. All the data in the column will be lost.
  - Added the required column `hitDice` to the `CharacterClass` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "CharacterSkill_characterId_idx";

-- DropIndex
DROP INDEX "CharacterSkill_skillId_idx";

-- AlterTable
ALTER TABLE "CharacterClass" DROP COLUMN "hitDie",
ADD COLUMN     "hitDice" INTEGER NOT NULL;

-- CreateIndex
CREATE INDEX "CharacterSkill_characterId_skillId_idx" ON "CharacterSkill"("characterId", "skillId");
