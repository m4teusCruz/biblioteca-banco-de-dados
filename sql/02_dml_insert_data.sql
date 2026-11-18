-- ============================================================================
-- SISTEMA DE GERENCIAMENTO DE BIBLIOTECA
-- Script DML: Inserção de Dados de Demonstração
-- ============================================================================

USE biblioteca;

-- Inserção: categoria
INSERT INTO categoria (nome_categoria, descricao_categoria) VALUES
('Ficção Científica', 'Obras sobre tecnologia e futuros especulativos'),
('Fantasia', 'Histórias com elementos mágicos e sobrenaturais'),
('História', 'Livros sobre acontecimentos históricos'),
('Filosofia', 'Obras sobre ética, lógica e pensamento humano'),
('Biologia', 'Livros sobre seres vivos e ecossistemas'),
('Programação e Tecnologia', 'Livros sobre computação e programação'),
('Romance', 'Obras literárias do gênero romance');

-- Inserção: autor
INSERT INTO autor (nome_autor, nacionalidade) VALUES
('Isaac Asimov', 'Russo-Americano'),
('J. R. R. Tolkien', 'Britânico'),
('Robert C. Martin', 'Americano'),
('Yuval Noah Harari', 'Israelense'),
('Friedrich Nietzsche', 'Alemão'),
('Machado de Assis', 'Brasileiro');

-- Inserção: leitor (dados fictícios para teste)
INSERT INTO leitor (nome_leitor, cpf, email, telefone) VALUES
('Ana Beatriz Souza', '00000000001', 'ana.souza@example.com', '(61) 98811-2233'),
('Carlos Eduardo Lima', '00000000002', 'carlos.lima@example.com', '(61) 99922-4455'),
('Mariana Ribeiro Alves', '00000000003', 'mariana.alves@example.com', '(61) 98133-5566'),
('Lucas Gabriel Mendes', '00000000004', 'lucas.mendes@example.com', '(61) 99244-7788'),
('Beatriz Silva Santos', '00000000005', 'beatriz.santos@example.com', '(61) 98755-9900');

-- Inserção: livro
INSERT INTO livro (titulo, ano_publicacao, editora, id_categoria) VALUES
('Fundação', 1951, 'Gnome Press', 1),
('O Senhor dos Anéis: A Sociedade do Anel', 1954, 'George Allen & Unwin', 2),
('Código Limpo: Habilidades Práticas do Agile Software', 2008, 'Alta Books', 6),
('Sapiens: Uma Breve História da Humanidade', 2011, 'Harper', 3),
('Além do Bem e do Mal', 1886, 'C. G. Naumann', 4),
('Dom Casmurro', 1899, 'Garnier', 7),
('Eu, Robô', 1950, 'Gnome Press', 1),
('Arquitetura Limpa', 2017, 'Alta Books', 6);

-- Inserção: livro_autor
INSERT INTO livro_autor (id_livro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 1),
(8, 3);

-- Inserção: exemplar
INSERT INTO exemplar (codigo_patrimonio, status, localizacao, id_livro) VALUES
('EX001', 'bom', 'Estante A1', 1),
('EX002', 'bom', 'Estante A6', 1),
('EX003', 'danificado', 'Estante A5', 2),
('EX004', 'manutencao', 'Estante A4', 2),
('EX005', 'bom', 'Estante A5', 3),
('EX006', 'bom', 'Estante A3', 4),
('EX007', 'danificado', 'Estante A2', 5),
('EX008', 'bom', 'Estante A7', 6),
('EX009', 'manutencao', 'Estante A9', 6),
('EX010', 'danificado', 'Estante A8', 7),
('EX011', 'bom', 'Estante A2', 8),
('EX012', 'bom', 'Estante A7', 4);

-- Inserção: emprestimo
INSERT INTO emprestimo (data_retirada, data_prevista_devolucao, data_devolucao_efetiva, id_leitor, id_exemplar) VALUES
('2026-10-10', '2026-10-24', '2026-10-22', 1, 1),
('2026-10-15', '2026-10-29', '2026-10-28', 2, 3),
('2026-10-20', '2026-11-03', '2026-11-02', 3, 5),
('2026-11-01', '2026-11-15', NULL, 4, 2),
('2026-11-02', '2026-11-16', NULL, 5, 6),
('2026-11-05', '2026-11-19', NULL, 1, 8);

-- Inserção: reserva
INSERT INTO reserva (data_reserva, status_reserva, id_leitor, id_livro) VALUES
('2026-11-06', 'ativa', 2, 5),
('2026-11-04', 'atendida', 3, 8),
('2026-11-01', 'cancelada', 4, 2);
