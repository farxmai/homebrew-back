import express, { Request, Response, NextFunction } from "express";
import dotenv from "dotenv";
import swaggerUi from "swagger-ui-express";
import swaggerJsdoc from "swagger-jsdoc";
import { swaggerOptions } from "./swagger";

// Import routers (to be implemented in src/routes)
import charactersRouter from "./routes/characters";
import skillsRouter from "./routes/skills";
import classesRouter from "./routes/classes";
import featsRouter from "./routes/feats";
import racesRouter from "./routes/races";

// Load environment variables from .env
dotenv.config();

const swaggerSpec = swaggerJsdoc(swaggerOptions);

const app = express();
// Middleware
app.use(express.json());

// Root endpoint
type HealthCheck = { status: string };
app.get("/", (_req: Request, res: Response<HealthCheck>) => {
  res.json({ status: "OK" });
});

// API routes
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.use("/characters", charactersRouter);
app.use("/skills", skillsRouter);
app.use("/classes", classesRouter);
app.use("/feats", featsRouter);
app.use("/races", racesRouter);

// Global error handler
app.use((err: any, _req: Request, res: Response, next: NextFunction) => {
  console.error(err);
  res.status(500).json({ error: "Internal Server Error" });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`[🚀] Server running on http://localhost:${PORT}`);
  console.log(`[🚀] API Doc http://localhost:${PORT}/api-docs`);
});
