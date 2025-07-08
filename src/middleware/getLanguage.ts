import { Request, Response, NextFunction } from "express";

export const getLanguage = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const language = req.headers["accept-language"]?.split(",")[0] || "en";
    (req as any).language = language; // Assuming you have a locale property on the request object
    next();
  } catch (err) {
    res.status(500).json({ error: "Invalid or missing ID", details: err });
    next(err);
  }
};
