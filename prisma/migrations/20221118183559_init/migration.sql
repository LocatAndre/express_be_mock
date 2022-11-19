/*
  Warnings:

  - Added the required column `name` to the `trait` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_trait" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);
INSERT INTO "new_trait" ("id") SELECT "id" FROM "trait";
DROP TABLE "trait";
ALTER TABLE "new_trait" RENAME TO "trait";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
