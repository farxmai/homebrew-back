import { Router, Request, Response, NextFunction } from "express";
import prisma from "../prisma";
import { ReqBodyClass } from "../types/reqBodies";

const router = Router();

// Get all characters
export const getClasses = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const characterClasses = await prisma.characterClass.findMany({
      include: {
        classLevelBonuses: {
          include: {
            spellsKnown: true,
            spellsPerDay: true,
          },
        },
        classSkills: {
          include: {
            skill: true,
          },
        },
      },
    });
    res.json(characterClasses);
  } catch (error) {
    res.status(400).json({ error: "Failed to fetch classes", details: error });
    next(error);
  }
};

// Get a character class by ID
export const getClassById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const classId = parseInt(req.params.id, 10);
  if (isNaN(classId)) {
    return res.status(400).json({ error: "Invalid class ID" });
  }
  try {
    const characterClass = await prisma.characterClass.findUnique({
      where: { id: classId },
      include: {
        classLevelBonuses: {
          include: {
            spellsKnown: {
              select: {
                spellLevel: true,
                knownPerLevel: true,
              },
            },
            spellsPerDay: {
              select: {
                spellLevel: true,
                perDay: true,
              },
            },
          },
        },
        classSkills: {
          include: {
            skill: {
              select: {
                id: true,
                name: true,
              },
            },
          },
        },
      },
    });
    if (!characterClass) {
      return res.status(404).json({ error: "Class not found" });
    }
    res.json(characterClass);
  } catch (error) {
    res.status(400).json({ error: "Failed to fetch class", details: error });
    next(error);
  }
};

// Create a new character class
export const createClass = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  try {
    const classData = req.body as ReqBodyClass;
    const characterClass = await prisma.characterClass.create({
      data: {
        name: classData.name,
        description: classData.description || "",
        descriptionShort: classData.descriptionShort || "",
        source: classData.source || "Players Handbook 1",
        hitDice: classData.hitDice || 6,
        skillPointsFist: classData.skillPointsFist || 0,
        skillPointsAfterFirst: classData.skillPointsAfterFirst || 0,
        baseAttribute: classData.baseAttribute || "str",
        classLevelBonuses: classData.classLevelBonuses
          ? {
              create: classData.classLevelBonuses.map((clb: any) => ({
                level: clb.level,
                baseAttack: clb.baseAttack,
                fortitude: clb.fortitude,
                reflex: clb.reflex,
                will: clb.will,
                spellPoints: clb.spellPoints,

                spellsPerDay: clb.spellsPerDay
                  ? { create: clb.spellsPerDay }
                  : undefined,
                spellsKnown: clb.spellsKnown
                  ? { create: clb.spellsKnown }
                  : undefined,
              })),
            }
          : undefined,
        ...(classData.classSkills?.length
          ? {
              classSkills: {
                create: classData.classSkills?.map(({ skillId }) => ({
                  skillId,
                })),
              },
            }
          : {}),
      },
    });
    res.status(201).json(characterClass);
  } catch (error) {
    res.status(400).json({ error: "Failed to create class", details: error });
    console.error("Error creating class:", error);
    next(error);
  }
};

export const updateClass = async (
  req: Request<{ id: string }>,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const classId = Number(req.params.id);
  if (isNaN(classId)) {
    return res.status(400).json({ error: "Invalid class ID" });
  }

  try {
    const classData = req.body as ReqBodyClass;

    const updated = await prisma.characterClass.update({
      where: { id: classId },
      data: {
        // top-level fields
        ...(classData.name !== undefined && { name: classData.name }),
        ...(classData.description !== undefined && {
          description: classData.description,
        }),
        ...(classData.hitDice !== undefined && { hitDice: classData.hitDice }),
        ...(classData.skillPointsFist !== undefined && {
          skillPointsFist: classData.skillPointsFist,
        }),
        ...(classData.skillPointsAfterFirst !== undefined && {
          skillPointsAfterFirst: classData.skillPointsAfterFirst,
        }),
        ...(classData.baseAttribute !== undefined && {
          baseAttribute: classData.baseAttribute,
        }),

        // replace all classLevelBonuses
        classLevelBonuses: classData.classLevelBonuses
          ? {
              deleteMany: {}, // remove existing rows
              create: classData.classLevelBonuses.map((clb) => ({
                level: clb.level,
                baseAttack: clb.baseAttack,
                fortitude: clb.fortitude,
                reflex: clb.reflex,
                will: clb.will,
                spellPoints: clb.spellPoints,
                spellsPerDay: clb.spellsPerDay
                  ? { deleteMany: {}, create: clb.spellsPerDay }
                  : undefined,
                spellsKnown: clb.spellsKnown
                  ? { deleteMany: {}, create: clb.spellsKnown }
                  : undefined,
              })),
            }
          : undefined,

        // replace all classSkills
        classSkills: classData.classSkills
          ? {
              deleteMany: {}, // remove existing skill links
              create: classData.classSkills.map(({ skillId }) => ({
                skillId,
              })),
            }
          : undefined,
      },
      include: {
        classLevelBonuses: {
          include: {
            spellsPerDay: true,
            spellsKnown: true,
          },
        },
        classSkills: {
          include: {
            skill: true,
          },
        },
      },
    });

    res.json(updated);
  } catch (error) {
    res.status(400).json({ error: "Failed to update class", details: error });
    next(error);
  }
};

// Delete a character class
export const deleteClass = async (
  req: Request<{ id: string }>,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const classId = Number(req.params.id);
  if (isNaN(classId)) {
    return res.status(400).json({ error: "Invalid class ID" });
  }

  try {
    const deletedClass = await prisma.characterClass.delete({
      where: { id: classId },
    });
    res.json(deletedClass);
  } catch (error) {
    res.status(400).json({ error: "Failed to delete class", details: error });
    next(error);
  }
};

export default router;
