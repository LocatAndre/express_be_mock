/*
  Warnings:

  - The primary key for the `Item` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `bundleId` on the `Item` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `id` on the `Item` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Bundle` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Bundle` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "type" TEXT NOT NULL,
    "tier" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "timeLimit" DATETIME,
    "price" REAL NOT NULL DEFAULT 0.00,
    "limit" INTEGER NOT NULL DEFAULT 100,
    "bundleId" INTEGER,
    CONSTRAINT "Item_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("active", "bundleId", "id", "limit", "price", "tier", "timeLimit", "type") SELECT "active", "bundleId", "id", "limit", "price", "tier", "timeLimit", "type" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
CREATE TABLE "new_Bundle" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "createAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME
);
INSERT INTO "new_Bundle" ("active", "createAt", "id", "name", "path", "updatedAt") SELECT "active", "createAt", "id", "name", "path", "updatedAt" FROM "Bundle";
DROP TABLE "Bundle";
ALTER TABLE "new_Bundle" RENAME TO "Bundle";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
