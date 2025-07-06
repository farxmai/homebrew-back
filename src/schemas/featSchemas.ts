import { z } from "zod/v4";
import { statBaseSchema } from "./statBaseSchemas";

export const featSchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  type: z.string().min(1),
  stats: statBaseSchema.optional(),
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
