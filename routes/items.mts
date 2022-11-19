import { NextFunction, Request, Response, Router } from "express";
import { Item, PrismaClient } from "@prisma/client";

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

  let items = [];
  if (filter?.bundleId) {
    items = await prisma.item.findMany({
      where: {
        bundleId: Number(filter.bundleId),
      },
    });
  } else {
    items = await prisma.item.findMany();
  }

  res.json(
    items.map((item) => {
      item.name = JSON.parse(item.name as string);
      item.thumbnail = JSON.parse(item.thumbnail as string);
      return item;
    })
  );
});

router
  .route("/:id")
  .get(async (req: Request, res: Response) => {
    const { id } = req.params;

    let item: Item | null = await prisma.item.findUnique({
      where: {
        id: Number(id),
      },
    });

    if (item) {
      item.name = JSON.parse(item.name as string);
      item.thumbnail = JSON.parse(item.thumbnail as string);
    }

    res.json(item);
  })
  .put(async (req: Request, res: Response) => {
    const { id } = req.params;

    let body = req.body;

    body.name = JSON.stringify(body.name);
    body.thumbnail = JSON.stringify(body.thumbnail);
    const updatedItem = await prisma.item.update({
      where: {
        id: Number(id),
      },
      data: body,
    });

    res.json(updatedItem).status(200);
  })
  .delete(async (req: Request, res: Response) => {
    const { id } = req.params;

    const deleteItem = prisma.item.delete({
      where: {
        id: Number(id),
      },
    });

    res.json(deleteItem).status(200);
  });

export default router;
