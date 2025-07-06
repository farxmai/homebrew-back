import { z } from "zod";

export const featSchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  type: z.string().min(1),
  stats: z
    .object({
      id: z.number().int().optional(),
      strength: z.number().int().optional(),
      dexterity: z.number().int().optional(),
      constitution: z.number().int().optional(),
      intelligence: z.number().int().optional(),
      wisdom: z.number().int().optional(),
      charisma: z.number().int().optional(),
      fortitude: z.number().int().optional(),
      reflex: z.number().int().optional(),
      will: z.number().int().optional(),
      speedBonus: z.number().int().optional(),
      speedMax: z.number().int().optional(),
      speedMod: z.number().int().optional(),
      size: z.number().int().optional(),
      acArmor: z.number().int().optional(),
      acShield: z.number().int().optional(),
      acNatural: z.number().int().optional(),
      acDeflection: z.number().int().optional(),
      acMisc: z.number().int().optional(),
      acDexterityAvailable: z.number().int().optional(),
      acDexterityMax: z.number().int().optional(),
      skillPenalty: z.number().int().optional(),
      attackMelee: z.number().int().optional(),
      attackRanged: z.number().int().optional(),
      attackTouch: z.number().int().optional(),
      attackGrapple: z.number().int().optional(),
      damageMelee: z.number().int().optional(),
      damageRanged: z.number().int().optional(),
      hpTemp: z.number().int().optional(),
      resistSpell: z.number().int().optional(),
      resistPsionic: z.number().int().optional(),
      resistAcid: z.number().int().optional(),
      resistCold: z.number().int().optional(),
      resistElectricity: z.number().int().optional(),
      resistFire: z.number().int().optional(),
      resistSonic: z.number().int().optional(),
      resistForce: z.number().int().optional(),
      resistNegativeEnergy: z.number().int().optional(),
      resistPositiveEnergy: z.number().int().optional(),
      resistPoison: z.number().int().optional(),
      resistDisease: z.number().int().optional(),
      resistDeathEffect: z.number().int().optional(),
      resistBlunt: z.number().int().optional(),
      resistPiercing: z.number().int().optional(),
      resistSlashing: z.number().int().optional(),
      resistGood: z.number().int().optional(),
      resistEvil: z.number().int().optional(),
      resistLawful: z.number().int().optional(),
      resistChaotic: z.number().int().optional(),
    })
    .optional(),
  skillsBonuses: z
    .array(
      z.object({
        id: z.number().int().optional(),
        skillId: z.number().int(),
        bonus: z.number().int(),
      })
    )
    .optional(),
  requirements: z.array(
    z.object({
      id: z.number().int().optional(),
      str: z.number().int().optional(),
      dex: z.number().int().optional(),
      con: z.number().int().optional(),
      int: z.number().int().optional(),
      wis: z.number().int().optional(),
      cha: z.number().int().optional(),
      skills: z
        .array(
          z.object({
            skillId: z.number().int(),
            minRank: z.number().int(),
          })
        )
        .optional(),
      feats: z
        .array(
          z.object({
            featId: z.number().int(),
          })
        )
        .optional(),
    })
  ),
});
