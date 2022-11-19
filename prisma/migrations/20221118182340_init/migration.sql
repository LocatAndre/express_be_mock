-- CreateTable
CREATE TABLE "trait" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "unityName" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "tier" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "timeLimit" DATETIME,
    "price" REAL NOT NULL DEFAULT 0.00,
    "limit" INTEGER NOT NULL DEFAULT 100,
    "name" TEXT,
    "thumbnail" TEXT,
    "src" TEXT,
    "bundleId" INTEGER,
    "traitId" INTEGER,
    CONSTRAINT "Item_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Item_traitId_fkey" FOREIGN KEY ("traitId") REFERENCES "trait" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("active", "bundleId", "id", "limit", "name", "price", "src", "thumbnail", "tier", "timeLimit", "type", "unityName") SELECT "active", "bundleId", "id", "limit", "name", "price", "src", "thumbnail", "tier", "timeLimit", "type", "unityName" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
CREATE UNIQUE INDEX "Item_id_unityName_key" ON "Item"("id", "unityName");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
