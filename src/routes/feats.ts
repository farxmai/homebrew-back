import { Router } from "express";

import {
  createFeat,
  deleteFeat,
  getFeatById,
  getFeats,
  updateFeat,
} from "../controllers/featsController";
import { checkId } from "../middleware/checkId";
import { validateBody } from "../middleware/validate";
import { featSchema } from "../schemas/featSchemas";

const router = Router({ mergeParams: true });

router.get("/", getFeats);
router.get("/:id", checkId, getFeatById);
router.post("/", createFeat, validateBody(featSchema));
router.put("/:id", checkId, validateBody(featSchema), updateFeat);
router.delete("/:id", checkId, deleteFeat);

export default router;
