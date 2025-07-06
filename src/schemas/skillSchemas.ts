import { z } from "zod";

export const skillSchema = z.object({
  name: z.string().min(1),
  description: z.string().min(1),
  ability: z.string().min(1),
  trainedOnly: z.boolean().default(false),
  armorCheckPenalty: z.number().int().default(0),
});
