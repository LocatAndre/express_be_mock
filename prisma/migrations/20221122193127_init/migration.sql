/*
  Warnings:

  - The primary key for the `Bundle` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Bundle` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Item` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Item` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `bundleId` column on the `Item` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `Trait` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Trait` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `A` on the `_ItemToTrait` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `B` on the `_ItemToTrait` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- DropForeignKey
ALTER TABLE "Item" DROP CONSTRAINT "Item_bundleId_fkey";

-- DropForeignKey
ALTER TABLE "_ItemToTrait" DROP CONSTRAINT "_ItemToTrait_A_fkey";

-- DropForeignKey
ALTER TABLE "_ItemToTrait" DROP CONSTRAINT "_ItemToTrait_B_fkey";

-- AlterTable
ALTER TABLE "Bundle" DROP CONSTRAINT "Bundle_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Bundle_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Item" DROP CONSTRAINT "Item_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "bundleId",
ADD COLUMN     "bundleId" INTEGER,
ADD CONSTRAINT "Item_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Trait" DROP CONSTRAINT "Trait_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "Trait_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "_ItemToTrait" DROP COLUMN "A",
ADD COLUMN     "A" INTEGER NOT NULL,
DROP COLUMN "B",
ADD COLUMN     "B" INTEGER NOT NULL;

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
