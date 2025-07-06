import { Router } from "express";

import {
  createRace,
  deleteRace,
  getRaceById,
  getRaces,
  updateRace,
} from "../controllers/racesController";
import { checkId } from "../middleware/checkId";
import { validateBody } from "../middleware/validate";
import { raceSchema } from "../schemas/raceSchemas";

const router = Router({ mergeParams: true });

router.get("/", getRaces);
router.get("/:id", checkId, getRaceById);
router.post("/", validateBody(raceSchema), createRace);
router.put("/:id", checkId, validateBody(raceSchema), updateRace);
router.delete("/:id", checkId, deleteRace);

export default router;
