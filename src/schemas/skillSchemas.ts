import { z } from "zod/v4";

export const skillSchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  descriptionShort: z.string().min(1).default(""),
  source: z.string().min(1).default("Players Handbook 1"),
  ability: z.string().min(1),
  trainedOnly: z.boolean().default(false),
  armorCheckPenalty: z.number().int().default(0),
});
