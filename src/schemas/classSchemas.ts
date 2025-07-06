import { z } from "zod/v4";

export const classSchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  descriptionShort: z.string().min(1).default(""),
  source: z.string().min(1).default("Players Handbook 1"),
  hitDice: z.number().int().positive(),
  skillPointsFist: z.number().int().nonnegative(),
  skillPointsAfterFirst: z.number().int().nonnegative(),
  baseAttribute: z.string().min(1),
  classLevelBonuses: z.array(
    z.object({
      level: z.number().int().positive(),
      baseAttack: z.number().int(),
      fortitude: z.number().int(),
      reflex: z.number().int(),
      will: z.number().int(),
      spellPoints: z.number().int().optional(),
      spellsPerDay: z
        .array(
          z.object({
            spellLevel: z.number().int().nonnegative(),
            perDay: z.number().int().nonnegative(),
          })
        )
        .optional(),
      spellsKnown: z
        .array(
          z.object({
            spellLevel: z.number().int().nonnegative(),
            knownPerLevel: z.number().int().nonnegative(),
          })
        )
        .optional(),
      bonusFeats: z
        .array(
          z.object({
            featId: z.number().int(), // create or update
          })
        )
        .optional(),
    })
  ),
  classSkills: z
    .array(
      z.object({
        skillId: z.number().int(), // create or update
      })
    )
    .optional(),
});
