import { ZodSchema, ZodError } from "zod/v4";
import { Request, Response, NextFunction, RequestHandler } from "express";

export const validateBody =
  (schema: ZodSchema): RequestHandler =>
  (req: Request, res: Response, next: NextFunction) => {
    try {
      req.body = schema.parse(req.body);
      next();
    } catch (err) {
      if (err instanceof ZodError) {
        res.status(400).json({
          error: "Validation failed",
          details: err,
        });
        return;
      }
      next(err);
    }
  };
