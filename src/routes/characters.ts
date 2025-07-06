import { Router } from "express";
import { getCharacters } from "../controllers/charactersController";

const router = Router();

router.get("/", getCharacters);

export default router;
