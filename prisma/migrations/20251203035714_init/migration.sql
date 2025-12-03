-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('active', 'inactive', 'waiting_activation');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "email_validated_at" TIMESTAMP(3),
    "name" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "status" "UserStatus" NOT NULL DEFAULT 'waiting_activation',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuthProvider" (
    "id" SERIAL NOT NULL,
    "providerName" TEXT NOT NULL,
    "providerId" TEXT,
    "emailFromProvider" TEXT NOT NULL,
    "userID" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AuthProvider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Token" (
    "token" TEXT NOT NULL,
    "userID" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,
    "blacklisted" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Token_pkey" PRIMARY KEY ("token")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "AuthProvider_providerId_key" ON "AuthProvider"("providerId");

-- AddForeignKey
ALTER TABLE "AuthProvider" ADD CONSTRAINT "AuthProvider_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Token" ADD CONSTRAINT "Token_userID_fkey" FOREIGN KEY ("userID") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
