-- CreateTable
CREATE TABLE "Bundle" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Bundle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Item" (
    "id" TEXT NOT NULL,
    "unityName" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "tier" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "timeLimit" TIMESTAMP(3),
    "price" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "limit" INTEGER NOT NULL DEFAULT 100,
    "name" JSONB,
    "thumbnail" JSONB,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "bundleId" TEXT,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trait" (
    "id" TEXT NOT NULL,
    "name" JSONB NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "createAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Trait_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ItemToTrait" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Bundle_name_key" ON "Bundle"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Item_id_unityName_key" ON "Item"("id", "unityName");

-- CreateIndex
CREATE UNIQUE INDEX "_ItemToTrait_AB_unique" ON "_ItemToTrait"("A", "B");

-- CreateIndex
CREATE INDEX "_ItemToTrait_B_index" ON "_ItemToTrait"("B");

-- AddForeignKey
ALTER TABLE "Item" ADD CONSTRAINT "Item_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItemToTrait" ADD CONSTRAINT "_ItemToTrait_A_fkey" FOREIGN KEY ("A") REFERENCES "Item"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItemToTrait" ADD CONSTRAINT "_ItemToTrait_B_fkey" FOREIGN KEY ("B") REFERENCES "Trait"("id") ON DELETE CASCADE ON UPDATE CASCADE;
