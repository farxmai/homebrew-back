import { Router } from "express";

import {
  createSkill,
  deleteSkill,
  getSkillById,
  getSkills,
  updateSkill,
} from "../controllers/skillsController";
import { checkId } from "../middleware/checkId";
import { validateBody } from "../middleware/validate";
import { skillSchema } from "../schemas/skillSchemas";

const router = Router({ mergeParams: true });

router.get("/", getSkills);
router.get("/:id", checkId, getSkillById);
router.post("/", validateBody(skillSchema), createSkill);
router.put("/:id", checkId, validateBody(skillSchema), updateSkill);
router.delete("/:id", checkId, deleteSkill);

export default router;
