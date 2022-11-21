import express from 'express';
import cors from 'cors';
import bundlesRoutes from './routes/bundles.mjs';
import imtemsRoutes from './routes/items.mjs';
import traitsRoutes from './routes/traits.mjs';
const port = process.env.PORT;
const app = express();
app.use(cors());
app.get('/', (req, res) => {
    res.json('Eccommi');
});
app.use('/bundles', bundlesRoutes);
app.use('/items', imtemsRoutes);
app.use('/traits', traitsRoutes);
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
//# sourceMappingURL=index.mjs.map