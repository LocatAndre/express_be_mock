import type { Request, Response } from 'express';
import { Router } from 'express';
import type { Trait } from '@prisma/client';
import { PrismaClient } from '@prisma/client';

import bodyParser from 'body-parser';

const router: Router = Router();
const prisma: PrismaClient = new PrismaClient();

router.use(bodyParser.json());

router
  .route('/')
  .get(async (req: Request, res: Response) => {
    res.header({
      'Content-Range': 'bytes : 0-9/10',
      'Access-Control-Expose-Headers': 'Content-Range',
    });

    const filter = req.query.filter
      ? JSON.parse(req.query.filter as string)
      : null;

    let traits = [];
    if (filter?.traitId) {
      traits = await prisma.trait.findMany();
    } else {
      traits = await prisma.trait.findMany();
    }

    res.json(traits);
  })
  .post(async (req: Request, res: Response) => {
    console.log(req.body);

    const newTreat = await prisma.trait.create({
      data: {
        name: req.body.name,
        active: req.body.active,
        itemsId: [req.body.character, ...req.body.weapons, ...req.body.pose],
      },
    });

    res.json(newTreat);
  });

router
  .route('/:id')
  .get(async (req: Request, res: Response) => {
    const { id } = req.params;

    const trait: Trait | null = await prisma.trait.findUnique({
      where: {
        id: id,
      },
    });

    res.json(trait);
  })
  .put(async (req: Request, res: Response) => {
    const { id } = req.params;

    delete req.body.id;
    const updatedItem = await prisma.trait.update({
      where: {
        id: id,
      },
      data: req.body,
    });

    res.json(updatedItem);
  })
  .delete(async (req: Request, res: Response) => {
    const { id } = req.params;

    const deleteItem = prisma.trait.delete({
      where: {
        id: id,
      },
    });

    res.json(deleteItem);
  });

export default router;
