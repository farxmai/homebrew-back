import { Request, Response, NextFunction } from "express";
import prisma from "../prisma";
import { ReqBodySkill } from "../types/reqBodies";

export const getSkills = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const skills = await prisma.skillBase.findMany({
      orderBy: { name: "asc" },
      select: {
        id: true,
        translations: {
          select: {
            id: true,
            locale: true,
            name: true,
            descriptionShort: true,
          },
        },
      },
    });
    res.json(skills);
  } catch (error) {
    console.error("Error fetching skills:", error);
    next(error);
  }
};

export const getSkillById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const skillId = parseInt(req.params.id, 10);
  if (isNaN(skillId)) {
    return res.status(400).json({ error: "Invalid skill ID" });
  }
  try {
    const skill = await prisma.skillBase.findUnique({
      where: { id: skillId },
      include: { translations: true },
    });
    if (!skill) {
      return res.status(404).json({ error: "Skill not found" });
    }
  } catch (error) {
    console.error("Error fetching skill:", error);
    next(error);
  }
};

export const createSkill = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const skillData = req.body as ReqBodySkill;
    const skill = await prisma.skillBase.create({
      data: {
        name: skillData.name,
        ability: skillData.ability,
        source: skillData.source || "Players Handbook 1",
        description: skillData.description || "",
        descriptionShort: skillData.descriptionShort || "",
        trainedOnly: skillData.trainedOnly || false,
        armorCheckPenalty: skillData.armorCheckPenalty || 0,
        translations: {
          create: skillData.translations.map((translation) => ({
            locale: translation.locale,
            name: translation.name,
            description: translation.description || "",
            descriptionShort: translation.descriptionShort || "",
          })),
        },
      },
    });
    res.json(skill);
  } catch (error) {
    console.error("Error creating skill:", error);
    next(error);
  }
};

export const updateSkill = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const skillId = parseInt(req.params.id, 10);
  if (isNaN(skillId)) {
    return res.status(400).json({ error: "Invalid skill ID" });
  }
  try {
    const skillData = req.body as ReqBodySkill;
    const updatedSkill = await prisma.skillBase.update({
      where: { id: skillId },
      include: { translations: true },
      data: {
        name: skillData.name,
        ability: skillData.ability,
        source: skillData.source || "Players Handbook 1",
        description: skillData.description || "",
        descriptionShort: skillData.descriptionShort || "",
        trainedOnly: skillData.trainedOnly || false,
        armorCheckPenalty: skillData.armorCheckPenalty || 0,
        translations: {
          upsert: skillData.translations.map((translation) => ({
            where: {
              id: translation.id || 0, // Use a default value that won't match for new records
            },
            update: {
              locale: translation.locale,
              name: translation.name,
              description: translation.description || "",
              descriptionShort: translation.descriptionShort || "",
            },
            create: {
              locale: translation.locale,
              name: translation.name,
              description: translation.description || "",
              descriptionShort: translation.descriptionShort || "",
            },
          })),
        },
      },
    });
    res.json(updatedSkill);
  } catch (error) {
    console.error("Error updating skill:", error);
    next(error);
  }
};

export const deleteSkill = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const skillId = parseInt(req.params.id, 10);
  if (isNaN(skillId)) {
    return res.status(400).json({ error: "Invalid skill ID" });
  }
  try {
    await prisma.skillBase.delete({
      where: { id: skillId },
    });
    res.status(204).send();
  } catch (error) {
    console.error("Error deleting skill:", error);
    next(error);
  }
};
