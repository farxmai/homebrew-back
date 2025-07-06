/*
  Warnings:

  - You are about to drop the column `baseAttack` on the `CharacterClass` table. All the data in the column will be lost.
  - You are about to drop the column `fortitude` on the `CharacterClass` table. All the data in the column will be lost.
  - You are about to drop the column `level` on the `CharacterClass` table. All the data in the column will be lost.
  - You are about to drop the column `reflex` on the `CharacterClass` table. All the data in the column will be lost.
  - You are about to drop the column `skills` on the `CharacterClass` table. All the data in the column will be lost.
  - You are about to drop the column `will` on the `CharacterClass` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `CharacterClass` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `CharacterRace` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `Feat` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `SkillBase` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `baseAttribute` to the `CharacterClass` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CharacterClass" DROP COLUMN "baseAttack",
DROP COLUMN "fortitude",
DROP COLUMN "level",
DROP COLUMN "reflex",
DROP COLUMN "skills",
DROP COLUMN "will",
ADD COLUMN     "baseAttribute" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "CharacterClass_name_key" ON "CharacterClass"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CharacterRace_name_key" ON "CharacterRace"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Feat_name_key" ON "Feat"("name");

-- CreateIndex
CREATE UNIQUE INDEX "SkillBase_name_key" ON "SkillBase"("name");
