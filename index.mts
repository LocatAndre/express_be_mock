/* eslint-disable import/no-unresolved */
import type { Express, Request, Response } from 'express';
import express from 'express';
import cors from 'cors';

import bundlesRoutes from './routes/bundles.mjs';
import imtemsRoutes from './routes/items.mjs';
import traitsRoutes from './routes/traits.mjs';

const port = process.env.PORT;

const app: Express = express();
app.use(cors());

app.get('/', (req: Request, res: Response) => {
  res.json('Eccommi');
});

app.use('/bundles', bundlesRoutes);
app.use('/items', imtemsRoutes);
app.use('/traits', traitsRoutes);

app.listen(3000, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
