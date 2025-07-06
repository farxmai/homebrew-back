/*
  Warnings:

  - The primary key for the `FeatsOnSkillBonus` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `skillBonusId` on the `FeatsOnSkillBonus` table. All the data in the column will be lost.
  - You are about to drop the `SkillBonus` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `bonus` to the `FeatsOnSkillBonus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `skillId` to the `FeatsOnSkillBonus` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "FeatsOnSkillBonus" DROP CONSTRAINT "FeatsOnSkillBonus_skillBonusId_fkey";

-- DropForeignKey
ALTER TABLE "SkillBonus" DROP CONSTRAINT "SkillBonus_skillId_fkey";

-- AlterTable
ALTER TABLE "FeatsOnSkillBonus" DROP CONSTRAINT "FeatsOnSkillBonus_pkey",
DROP COLUMN "skillBonusId",
ADD COLUMN     "bonus" INTEGER NOT NULL,
ADD COLUMN     "skillId" INTEGER NOT NULL,
ADD CONSTRAINT "FeatsOnSkillBonus_pkey" PRIMARY KEY ("featId", "skillId");

-- DropTable
DROP TABLE "SkillBonus";

-- AddForeignKey
ALTER TABLE "FeatsOnSkillBonus" ADD CONSTRAINT "FeatsOnSkillBonus_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "SkillBase"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
