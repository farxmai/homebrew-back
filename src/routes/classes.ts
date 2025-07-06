import { Router } from "express";

import {
  createClass,
  deleteClass,
  getClassById,
  getClasses,
  updateClass,
} from "../controllers/classController";
import { validateBody } from "../middleware/validate";
import { classSchema } from "../schemas/classSchemas";
import { checkId } from "../middleware/checkId";

const router = Router({ mergeParams: true });

router.get("/", getClasses);
router.get("/:id", checkId, getClassById);
router.post("/", validateBody(classSchema), createClass);
router.put("/:id", checkId, validateBody(classSchema), updateClass);
router.delete("/:id", checkId, deleteClass);

export default router;
