-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "unityName" TEXT NOT NULL DEFAULT '',
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
    CONSTRAINT "Item_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("active", "bundleId", "id", "limit", "name", "price", "src", "thumbnail", "tier", "timeLimit", "type") SELECT "active", "bundleId", "id", "limit", "name", "price", "src", "thumbnail", "tier", "timeLimit", "type" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
