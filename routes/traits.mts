import { NextFunction, Request, Response, Router } from "express";
import { Item, PrismaClient, Trait } from "@prisma/client";

import bodyParser from "body-parser";

const router: Router = Router();
const prisma: PrismaClient = new PrismaClient();

router.use(bodyParser.json());

router.get("/", async (req: Request, res: Response) => {
  res.header({
    "Content-Range": "bytes : 0-9/10",
    "Access-Control-Expose-Headers": "Content-Range",
  });

  const filter = req.query.filter ? JSON.parse(req.query.filter as string) : null;

  let traits = [];
  if (filter?.traitId) {
    traits = await prisma.trait.findMany();
  } else {
    traits = await prisma.trait.findMany();
  }

  res.json(traits);
});

router
  .route("/:id")
  .get(async (req: Request, res: Response) => {
    const { id } = req.params;

    let trait: Trait | null = await prisma.trait.findUnique({
      where: {
        id: Number(id),
      },
    });

    res.json(trait);
  })
  .put(async (req: Request, res: Response) => {
    const { id } = req.params;

    const updatedItem = await prisma.trait.update({
      where: {
        id: Number(id),
      },
      data: req.body,
    });

    res.json(updatedItem);
  })
  .delete(async (req: Request, res: Response) => {
    const { id } = req.params;

    const deleteItem = prisma.trait.delete({
      where: {
        id: Number(id),
      },
    });

    res.json(deleteItem);
  });

export default router;
