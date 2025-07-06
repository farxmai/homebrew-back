import { Request, Response, NextFunction } from "express";

export const checkId = (req: Request, res: Response, next: NextFunction) => {
  try {
    const id = parseInt(req.params.id, 10);
    if (isNaN(id)) {
      res.status(400).json({ error: "Invalid ID" });
    }
    next();
  } catch (err) {
    res.status(500).json({ error: "Invalid or missing ID", details: err });
    next(err);
  }
};
