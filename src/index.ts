import express, { Request, Response, NextFunction } from "express";
import dotenv from "dotenv";

// Import routers (to be implemented in src/routes)
import charactersRouter from "./routes/characters";
import skillsRouter from "./routes/skills";
import classesRouter from "./routes/classes";
// import featsRouter from './routes/feats';
// import itemsRouter from './routes/items';
// import languagesRouter from './routes/languages';

// Load environment variables from .env
dotenv.config();

const app = express();
// Middleware
app.use(express.json());

// Root endpoint
type HealthCheck = { status: string };
app.get("/", (_req: Request, res: Response<HealthCheck>) => {
  res.json({ status: "OK" });
});

// API routes
app.use("/characters", charactersRouter);
app.use("/skills", skillsRouter);
app.use("/classes", classesRouter);
// app.use('/feats', featsRouter);
// app.use('/items', itemsRouter);
// app.use('/languages', languagesRouter);

// Global error handler
app.use((err: any, _req: Request, res: Response, next: NextFunction) => {
  console.error(err);
  res.status(500).json({ error: "Internal Server Error" });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
