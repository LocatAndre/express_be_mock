-- CreateTable
CREATE TABLE "Bundle" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "createAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME
);

-- CreateTable
CREATE TABLE "Item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "type" TEXT NOT NULL,
    "tier" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT false,
    "timeLimit" DATETIME,
    "price" REAL NOT NULL DEFAULT 0.00,
    "limit" INTEGER NOT NULL DEFAULT 100,
    "bundleId" TEXT,
    CONSTRAINT "Item_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "Bundle" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
