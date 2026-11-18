-- ============================================================================
-- SISTEMA DE GERENCIAMENTO DE BIBLIOTECA
-- Script DDL: Criação do Banco de Dados e das Tabelas
-- Autores: Mateus Gonçalves da Cruz e Guilherme Nasareth de Sousa
-- ============================================================================

CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- 1. Tabela categoria
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(80) NOT NULL UNIQUE,
    descricao_categoria VARCHAR(255)
);

-- 2. Tabela autor
CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome_autor VARCHAR(120) NOT NULL,
    nacionalidade VARCHAR(60)
);

-- 3. Tabela leitor
CREATE TABLE leitor (
    id_leitor INT AUTO_INCREMENT PRIMARY KEY,
    nome_leitor VARCHAR(120) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(150),
    telefone VARCHAR(20)
);

-- 4. Tabela livro
CREATE TABLE livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    ano_publicacao INT,
    editora VARCHAR(100),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- 5. Tabela exemplar
CREATE TABLE exemplar (
    id_exemplar INT AUTO_INCREMENT PRIMARY KEY,
    codigo_patrimonio VARCHAR(30) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL,
    localizacao VARCHAR(50),
    id_livro INT NOT NULL,
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro)
);

-- 6. Tabela associativa livro_autor (Relacionamento N:N)
CREATE TABLE livro_autor (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

-- 7. Tabela emprestimo
CREATE TABLE emprestimo (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    data_retirada DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao_efetiva DATE,
    id_leitor INT NOT NULL,
    id_exemplar INT NOT NULL,
    FOREIGN KEY (id_leitor) REFERENCES leitor(id_leitor),
    FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)
);

-- 8. Tabela reserva
CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATE NOT NULL,
    status_reserva VARCHAR(20) NOT NULL,
    id_leitor INT NOT NULL,
    id_livro INT NOT NULL,
    FOREIGN KEY (id_leitor) REFERENCES leitor(id_leitor),
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro)
);
