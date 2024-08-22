/*
  Warnings:

  - You are about to drop the column `data` on the `requisicoes` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `requisicoes` DROP COLUMN `data`,
    ADD COLUMN `dataCriacao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- CreateTable
CREATE TABLE `requisicoes_analise` (
    `id` CHAR(36) NOT NULL,
    `aprovacao` BIT(1) NOT NULL,
    `observacao` VARCHAR(500) NOT NULL,
    `escopo` VARCHAR(500) NOT NULL,
    `idRequest` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `requisicoes_analise_idRequest_key`(`idRequest`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `requisicoes_projeto` (
    `id` CHAR(36) NOT NULL,
    `descricao` VARCHAR(5000) NOT NULL,
    `anexo` BLOB NULL,
    `idAnalysis` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `requisicoes_projeto_idAnalysis_key`(`idAnalysis`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `requisicoes_implementacao` (
    `id` CHAR(36) NOT NULL,
    `descricao` VARCHAR(5000) NOT NULL,
    `anexo` BLOB NULL,
    `idProject` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `requisicoes_implementacao_idProject_key`(`idProject`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `requisicoes_teste_sistema` (
    `id` CHAR(36) NOT NULL,
    `aprovado` BIT(1) NOT NULL,
    `descricao` VARCHAR(500) NOT NULL,
    `data` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `idImplement` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `requisicoes_teste_sistema_idImplement_key`(`idImplement`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `requisicoes_teste_aceite` (
    `id` CHAR(36) NOT NULL,
    `aprovado` BIT(1) NOT NULL,
    `descricao` VARCHAR(500) NOT NULL,
    `data` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `idTestSis` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `requisicoes_teste_aceite_idTestSis_key`(`idTestSis`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `requisicoes_entrega` (
    `id` CHAR(36) NOT NULL,
    `descricao` VARCHAR(5000) NOT NULL,
    `anexo` BLOB NULL,
    `idTesteAcc` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `requisicoes_entrega_idTesteAcc_key`(`idTesteAcc`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `requisicoes_analise` ADD CONSTRAINT `requisicoes_analise_idRequest_fkey` FOREIGN KEY (`idRequest`) REFERENCES `requisicoes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `requisicoes_projeto` ADD CONSTRAINT `requisicoes_projeto_idAnalysis_fkey` FOREIGN KEY (`idAnalysis`) REFERENCES `requisicoes_analise`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `requisicoes_implementacao` ADD CONSTRAINT `requisicoes_implementacao_idProject_fkey` FOREIGN KEY (`idProject`) REFERENCES `requisicoes_projeto`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `requisicoes_teste_sistema` ADD CONSTRAINT `requisicoes_teste_sistema_idImplement_fkey` FOREIGN KEY (`idImplement`) REFERENCES `requisicoes_implementacao`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `requisicoes_teste_aceite` ADD CONSTRAINT `requisicoes_teste_aceite_idTestSis_fkey` FOREIGN KEY (`idTestSis`) REFERENCES `requisicoes_teste_sistema`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `requisicoes_entrega` ADD CONSTRAINT `requisicoes_entrega_idTesteAcc_fkey` FOREIGN KEY (`idTesteAcc`) REFERENCES `requisicoes_teste_aceite`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
