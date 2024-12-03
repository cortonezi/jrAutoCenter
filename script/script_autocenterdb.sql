-- Seleciona o banco de dados (crie um se não existir)clientes
CREATE DATABASE IF NOT EXISTS AutoCenterDB;
USE autocenterdb;

-- Cria a tabela de clientes
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único para cada cliente
    nome VARCHAR(255) NOT NULL, -- Nome completo do cliente
    cpf VARCHAR(14) NOT NULL UNIQUE, -- CPF do cliente (com máscara opcional)
    telefone VARCHAR(20) NOT NULL, -- Telefone do cliente
    email VARCHAR(255) NOT NULL, -- E-mail do cliente
    endereco TEXT NOT NULL, -- Endereço completo do cliente
    observacao TEXT, -- Observação (opcional)
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data e hora do cadastro
);

-- Adiciona índices para melhorar o desempenho em consultas
CREATE INDEX idx_cpf ON Clientes (cpf);
CREATE INDEX idx_email ON Clientes (email);

-- =========================================================================================== 

-- Criação da tabela produtos
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único do produto
    nome_produto VARCHAR(255) NOT NULL,        -- Nome do produto
    codigo_produto VARCHAR(50) UNIQUE NOT NULL, -- Código único do produto (SKU)
    categoria VARCHAR(100) NOT NULL,           -- Categoria do produto
    marca VARCHAR(100) NOT NULL,               -- Marca do produto
    descricao TEXT NOT NULL,                   -- Descrição detalhada do produto
    compatibilidade TEXT,                      -- Compatibilidade com modelos de veículos (opcional)
    estoque INT NOT NULL,                      -- Quantidade em estoque
    estoque_minimo INT NOT NULL,               -- Estoque mínimo
    preco_custo DECIMAL(10, 2) NOT NULL,       -- Preço de custo do produto
    preco_venda DECIMAL(10, 2) NOT NULL,       -- Preço de venda do produto
    codigo_barras VARCHAR(100) UNIQUE,         -- Código de barras (opcional)
    fornecedor VARCHAR(255),                   -- Nome do fornecedor
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data e hora de cadastro
);


INSERT INTO produtos (nome_produto, codigo_produto, categoria, marca, descricao, compatibilidade, estoque, estoque_minimo, preco_custo, preco_venda, codigo_barras, fornecedor)
VALUES 
('Óleo 5W-30', 'SKU001', 'Óleos e Lubrificantes', 'Shell', 'Óleo sintético premium para motores.', 'Compatível com motores 1.0 a 2.0', 50, 10, 45.50, 65.00, '7891234567890', 'Fornecedor XYZ');
