var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { Router } from "express";
import { PrismaClient } from "@prisma/client";
import bodyParser from "body-parser";
const router = Router();
const prisma = new PrismaClient();
router.use(bodyParser.json());
router.get("/", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    res.header({
        "Content-Range": "bytes : 0-9/10",
        "Access-Control-Expose-Headers": "Content-Range",
    });
    const filter = req.query.filter ? JSON.parse(req.query.filter) : null;
    let traits = [];
    if (filter === null || filter === void 0 ? void 0 : filter.traitId) {
        traits = yield prisma.trait.findMany();
    }
    else {
        traits = yield prisma.trait.findMany();
    }
    res.json(traits);
}));
router
    .route("/:id")
    .get((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    let trait = yield prisma.trait.findUnique({
        where: {
            id: Number(id),
        },
    });
    res.json(trait);
}))
    .put((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const updatedItem = yield prisma.trait.update({
        where: {
            id: Number(id),
        },
        data: req.body,
    });
    res.json(updatedItem);
}))
    .delete((req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const deleteItem = prisma.trait.delete({
        where: {
            id: Number(id),
        },
    });
    res.json(deleteItem);
}));
export default router;
//# sourceMappingURL=traits.mjs.map