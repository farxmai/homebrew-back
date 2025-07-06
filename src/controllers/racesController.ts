import { Request, Response, NextFunction } from "express";
import prisma from "../prisma";
import { ReqBodyRace } from "../types/reqBodies";

export const getRaces = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const races = await prisma.characterRace.findMany();
    res.json(races);
  } catch (error) {
    console.error("Error fetching races:", error);
    next(error);
  }
};

export const getRaceById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const raceId = Number(req.params.id);
  try {
    const characterRace = await prisma.characterRace.findUnique({
      where: { id: raceId },
      include: {
        stats: true,
        skillBonuses: {
          include: {
            skill: {
              select: {
                id: true,
                name: true,
              },
            },
          },
        },
        languages: {
          include: {
            language: {
              select: {
                id: true,
                name: true,
              },
            },
          },
        },
        feats: {
          include: {
            feat: {
              select: {
                id: true,
                name: true,
                descriptionShort: true,
              },
            },
          },
        },
      },
    });
    if (!characterRace) {
      return res.status(404).json({ error: "Race not found" });
    }
  } catch (error) {
    res.status(400).json({ error: "Failed to fetch race", details: error });
    next(error);
  }
};

export const createRace = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const raceData = req.body as ReqBodyRace;
  try {
    const newRace = await prisma.characterRace.create({
      data: {
        name: raceData.name,
        description: raceData.description || "",
        descriptionShort: raceData.descriptionShort || "",
        source: raceData.source || "Players Handbook 1",
        speed: raceData.speed || 0,
        size: raceData.size || 0,
        ...(raceData.stats && { stats: { create: raceData.stats } }),
        ...(raceData.skillPointsFist && {
          skillPointsFist: raceData.skillPointsFist,
        }),
        ...(raceData.skillPointsAfterFirst && {
          skillPointsAfterFirst: raceData.skillPointsAfterFirst,
        }),
        skillBonuses: {
          create: raceData.skillBonuses || [],
        },
        languages: {
          create:
            raceData.languages?.map((lang) => ({
              isAutomatic: lang.isAutomatic || false,
              language: {
                connect: { id: lang.languageId }, // Connect to existing Language record
              },
            })) || [],
        },
        feats: {
          create: raceData.raceFeats || [],
        },
      },
    });
    res.status(201).json(newRace);
  } catch (error) {
    res.status(400).json({ error: "Failed to create race", details: error });
    next(error);
  }
};

export const updateRace = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const raceId = Number(req.params.id);
  const raceData = req.body as ReqBodyRace;
  try {
    const newRace = await prisma.characterRace.update({
      where: { id: raceId },
      data: {
        name: raceData.name,
        description: raceData.description || "",
        descriptionShort: raceData.descriptionShort || "",
        source: raceData.source || "Players Handbook 1",
        speed: raceData.speed || 0,
        size: raceData.size || 0,
        ...(raceData.stats && { stats: { update: raceData.stats } }),
        ...(raceData.skillPointsFist && {
          skillPointsFist: raceData.skillPointsFist,
        }),
        ...(raceData.skillPointsAfterFirst && {
          skillPointsAfterFirst: raceData.skillPointsAfterFirst,
        }),
        skillBonuses: {
          deleteMany: {}, // Clear existing
          create: raceData.skillBonuses || [],
        },
        languages: {
          deleteMany: {}, // Clear existing
          create:
            raceData.languages?.map((lang) => ({
              isAutomatic: lang.isAutomatic || false,
              language: {
                connect: { id: lang.languageId }, // Connect to existing Language record
              },
            })) || [],
        },
        feats: {
          deleteMany: {}, // Clear existing
          create: raceData.raceFeats || [],
        },
      },
    });
    res.status(201).json(newRace);
  } catch (error) {
    res.status(400).json({ error: "Failed to create race", details: error });
    next(error);
  }
};

export const deleteRace = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const raceId = parseInt(req.params.id, 10);
  if (isNaN(raceId)) {
    return res.status(400).json({ error: "Invalid race ID" });
  }
  try {
    await prisma.characterRace.delete({
      where: { id: raceId },
    });
    res.status(204).send();
  } catch (error) {
    console.error("Error deleting race:", error);
    next(error);
  }
};
