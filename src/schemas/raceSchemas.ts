import { z } from "zod/v4";
import { statBaseSchema } from "./statBaseSchemas";

export const raceSchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  descriptionShort: z.string().min(1).default(""),
  source: z.string().min(1).default("Players Handbook 1"),
  speed: z.number().int().default(0),
  size: z.number().min(1).default(0),
  skillPointsFistLevel: z.number().int().optional(),
  skillPointsAfterFirstLevel: z.number().int().optional(),
  stats: statBaseSchema.optional(),
  languages: z
    .array(
      z.object({
        languageId: z.number().int(),
        isAutomatic: z.boolean().optional().default(false), // if true, the character knows this language without needing to spend skill points
      })
    )
    .optional(),
  raceFeats: z
    .array(
      z.object({
        featId: z.number().int(), // create or update
      })
    )
    .optional(),
});
