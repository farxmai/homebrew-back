import { Options } from "swagger-jsdoc";

export const swaggerOptions: Options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Homebrew API",
      version: "1.0.0",
      description: "Documentation for Homebrew API (Express + Prisma)",
    },
    servers: [{ url: "http://localhost:3000", description: "Local server" }],
  },

  apis: ["./src/routes/*.ts", "./src/controllers/*.ts"],
};
