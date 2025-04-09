// prisma model template
model {{fileName}} {
    uuid      String   @id @default(uuid())
    createdAt DateTime @default(now())
    updatedAt DateTime @updatedAt
}