import { Router, Request, Response, NextFunction } from "express";
import prisma from "../prisma";

const router = Router();

// Get all characters
export const getCharacters = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const characters = await prisma.character.findMany({
      include: {
        hp: true,
        abilities: true,
        saves: true,
        // skills: {
        //   include: {
        //     skill: true,
        //   },
        // },
        // characterClasses: {
        //   include: {
        //     characterClass: {
        //       include: {
        //         classLevelBonuses: true,
        //         classSkills: true,
        //       },
        //     },
        //   },
        // },
        // characterRaces: {
        //   include: {
        //     characterRace: {
        //       include: {
        //         stats: true,
        //       },
        //     },
        //   },
        // },
      },
    });
    res.json(characters);
  } catch (error) {
    console.error("Error fetching characters:", error);
    next(error);
  }
};

export default router;
