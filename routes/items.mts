import { NextFunction, Request, Response, Router } from 'express'
import { Item, PrismaClient } from '@prisma/client'

import bodyParser from 'body-parser'

const router: Router = Router()
const prisma: PrismaClient = new PrismaClient()

router.use(bodyParser.json())

router.get('/', async (req: Request, res: Response) => {
  res.header({
    'Content-Range': 'bytes : 0-9/10',
    'Access-Control-Expose-Headers': 'Content-Range',
  })

  const filter = req.query.filter
    ? JSON.parse(req.query.filter as string)
    : null

  let items = []
  if (filter?.bundleId) {
    items = await prisma.item.findMany({
      where: {
        bundleId: filter.bundleId,
      },
    })
  } else {
    items = await prisma.item.findMany()
  }

  res.json(items)
})

router
  .route('/:id')
  .get(async (req: Request, res: Response) => {
    const { id } = req.params

    const item: Item | null = await prisma.item.findUnique({
      where: {
        id: id,
      },
    })

    res.json(item)
  })
  .put(async (req: Request, res: Response) => {
    const { id } = req.params

    const updatedItem = await prisma.item.update({
      where: {
        id: id,
      },
      data: req.body,
    })

    res.json(updatedItem).status(200)
  })
  .delete(async (req: Request, res: Response) => {
    const { id } = req.params

    const deleteItem = prisma.item.delete({
      where: {
        id: id,
      },
    })

    res.json(deleteItem).status(200)
  })

export default router
