import type { Request, Response } from 'express';
import { Router } from 'express';
import type { Bundle } from '@prisma/client';
import { PrismaClient } from '@prisma/client';

import bodyParser from 'body-parser';

const router: Router = Router();
const prisma: PrismaClient = new PrismaClient();
router.use(bodyParser.json());

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

  console.log(bundles);

  res.json(bundles);
});

router.get('/:id', async (req: Request, res: Response) => {
  const { id }: any = req.params;

  const bundle: Bundle | null = await prisma.bundle.findFirst({
    where: {
      id: Number(id),
    },
    include: {
      Item: true,
    },
  });

  res.json(bundle);
});

router.post('/new', async (req: Request, res: Response) => {
  const newBundle = await prisma.bundle.create({ data: req.body });
  res.json(newBundle);
});

export default router;
