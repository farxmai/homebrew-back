import { ReqBodyRequirement, ReqBodyStatsBase } from "../types/reqBodies";

export const buildStatsBase = (
  method: "create" | "update",
  stats?: ReqBodyStatsBase
) => {
  if (!stats) return {};
  const { skillBonuses, ...fields } = stats;
  return {
    ...fields,
    skillBonuses: {
      ...(method === "update" && { deleteMany: {} }), // Clear existing skill bonuses if updating
      create:
        skillBonuses?.map((skillBonus) => ({
          skillId: skillBonus.skillId,
          bonus: skillBonus.bonus,
        })) || [],
    },
  };
};

export const buildRequirement = (
  method: "create" | "update",
  requirements?: ReqBodyRequirement
) => {
  if (!requirements) return {};
  return {
    ...requirements,
    skills: {
      ...(method === "update" && { deleteMany: {} }), // Clear existing skills if updating
      create:
        requirements.skills?.map((skill) => ({
          skillId: skill.skillId,
          minRank: skill.minRank || 0,
        })) || [],
    },
    feats: {
      ...(method === "update" && { deleteMany: {} }), // Clear existing feats if updating
      create:
        requirements.feats?.map((featReq) => ({
          feat: { connect: { id: featReq.featRequirementId } },
        })) || [],
    },
  };
};
