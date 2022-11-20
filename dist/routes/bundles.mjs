var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
const router = Router();
const prisma = new PrismaClient();
router.get('/', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    res.header({
        'Content-Range': 'bytes : 0-9/10',
        'Access-Control-Expose-Headers': 'Content-Range',
    });
    const filter = req.query.filter
        ? JSON.parse(req.query.filter)
        : null;
    let bundles = {};
    console.log(filter);
    if (filter === null || filter === void 0 ? void 0 : filter.id) {
        bundles = yield prisma.bundle.findMany({
            where: {
                id: {
                    in: filter.id,
                },
            },
        });
    }
    else {
        bundles = yield prisma.bundle.findMany();
    }
    res.json(bundles);
}));
router.get('/:id', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const bundle = yield prisma.bundle.findFirst({
        where: {
            id: {
                equals: id,
            },
        },
    });
    res.json(bundle);
}));
export default router;
//# sourceMappingURL=bundles.mjs.map