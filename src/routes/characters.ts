import { Router } from "express";
import { getCharacters } from "../controllers/charactersController";

const router = Router();

// Get all characters
router.get("/", getCharacters);

export default router;
