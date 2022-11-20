import type { Request, Response } from 'express';
import { Router } from 'express';
import type { Bundle } from '@prisma/client';
import { PrismaClient } from '@prisma/client';

const router: Router = Router();
const prisma: PrismaClient = new PrismaClient();

router.get('/', async (req: Request, res: Response) => {
  res.header({
    'Content-Range': 'bytes : 0-9/10',
    'Access-Control-Expose-Headers': 'Content-Range',
  });

  const filter = req.query.filter
    ? JSON.parse(req.query.filter as string)
    : null;
  let bundles = {};

  console.log(filter);

  if (filter?.id) {
    bundles = await prisma.bundle.findMany({
      where: {
        id: {
          in: filter.id,
        },
      },
    });
  } else {
    bundles = await prisma.bundle.findMany();
  }

  res.json(bundles);
});

router.get('/:id', async (req: Request, res: Response) => {
  const { id }: any = req.params;

  const bundle: Bundle | null = await prisma.bundle.findFirst({
    where: {
      id: {
        equals: id,
      },
    },
  });

  res.json(bundle);
});

export default router;
