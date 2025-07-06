import { Request, Response, NextFunction } from "express";
import prisma from "../prisma";
import { ReqBodyFeat } from "../types/reqBodies";

export const getFeats = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const feats = await prisma.feat.findMany({
      include: {
        stats: true,
        skillBonuses: {
          include: {
            skill: true,
          },
        },
        requirements: {
          include: {
            skills: {
              select: {
                skill: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
            feats: {
              select: {
                feat: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
          },
        },
      },
    });
    res.json(feats);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch feats", details: error });
    next(error);
  }
};

export const getFeatById = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const featId = parseInt(req.params.id, 10);
  if (isNaN(featId)) {
    return res.status(400).json({ error: "Invalid feat ID" });
  }
  try {
    const feat = await prisma.feat.findUnique({
      where: { id: featId },
      include: {
        stats: true,
        skillBonuses: {
          include: {
            skill: true,
          },
        },
        requirements: {
          include: {
            skills: {
              select: {
                skill: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
            feats: {
              select: {
                feat: {
                  select: {
                    id: true,
                    name: true,
                  },
                },
              },
            },
          },
        },
      },
    });
    if (!feat) {
      return res.status(404).json({ error: "Feat not found" });
    }
    res.json(feat);
  } catch (error) {
    console.error("Error fetching feat:", error);
    next(error);
  }
};

export const createFeat = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const featData = req.body as ReqBodyFeat;
    const feat = await prisma.feat.create({
      data: {
        name: featData.name,
        description: featData.description || "",
        descriptionShort: featData.descriptionShort || "",
        source: featData.source || "Players Handbook 1",
        type: featData.type,
        isPassive: featData.isPassive || false,
        isFighterBonusFeat: featData.isFighterBonusFeat || false,
        isStackable: featData.isStackable || false,
        ...(featData.stats && { stats: { create: featData.stats } }),
        ...(featData.skillBonuses && {
          skillBonuses: { create: featData.skillBonuses },
        }),
        ...(featData.requirements && {
          requirements: {
            create: featData.requirements.map((requirement) => ({
              str: requirement.str,
              dex: requirement.dex,
              con: requirement.con,
              int: requirement.int,
              wis: requirement.wis,
              cha: requirement.cha,
              minBaseAttack: requirement.minBaseAttack,
              minClassLevel: requirement.minClassLevel,
              classId: requirement.classId,
              other: requirement.other,
              casterOnly: requirement.casterOnly,
              divineOnly: requirement.divineOnly,
              skills: {
                create:
                  requirement.skills?.map((skill) => ({
                    skillId: skill.skillId,
                    minRank: skill.minRank || 0,
                  })) || [],
              },
              feats: {
                create:
                  requirement.feats?.map((featReq) => ({
                    feat: { connect: { id: featReq.featRequirementId } },
                  })) || [],
              },
            })),
          },
        }),
      },
    });
    res.json(feat);
  } catch (error) {
    console.error("Error creating feat:", error);
    next(error);
  }
};

export const updateFeat = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const featId = parseInt(req.params.id, 10);
  if (isNaN(featId)) {
    return res.status(400).json({ error: "Invalid feat ID" });
  }
  try {
    const featData = req.body as ReqBodyFeat;
    const feat = await prisma.feat.update({
      where: { id: featId },
      data: {
        name: featData.name,
        description: featData.description || "",
        descriptionShort: featData.descriptionShort || "",
        source: featData.source || "Players Handbook 1",
        type: featData.type,
        isPassive: featData.isPassive || false,
        isFighterBonusFeat: featData.isFighterBonusFeat || false,
        isStackable: featData.isStackable || false,
        ...(featData.stats && { stats: { update: featData.stats } }),
        ...(featData.skillBonuses && {
          skillBonuses: { deleteMany: {}, create: featData.skillBonuses },
        }),
        ...(featData.requirements && {
          requirements: {
            deleteMany: {},
            create: featData.requirements.map((requirement) => ({
              str: requirement.str,
              dex: requirement.dex,
              con: requirement.con,
              int: requirement.int,
              wis: requirement.wis,
              cha: requirement.cha,
              minBaseAttack: requirement.minBaseAttack,
              minClassLevel: requirement.minClassLevel,
              classId: requirement.classId,
              other: requirement.other,
              casterOnly: requirement.casterOnly,
              divineOnly: requirement.divineOnly,
              skills: {
                create:
                  requirement.skills?.map((skill) => ({
                    skillId: skill.skillId,
                    minRank: skill.minRank || 0,
                  })) || [],
              },
              feats: {
                create:
                  requirement.feats?.map((featReq) => ({
                    feat: { connect: { id: featReq.featRequirementId } },
                  })) || [],
              },
            })),
          },
        }),
      },
    });
    res.json(feat);
  } catch (error) {
    console.error("Error updating feat:", error);
    next(error);
  }
};

export const deleteFeat = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<any> => {
  const featId = parseInt(req.params.id, 10);
  if (isNaN(featId)) {
    return res.status(400).json({ error: "Invalid feat ID" });
  }
  try {
    await prisma.feat.delete({
      where: { id: featId },
    });
    res.status(204).send();
  } catch (error) {
    console.error("Error deleting feat:", error);
    next(error);
  }
};
