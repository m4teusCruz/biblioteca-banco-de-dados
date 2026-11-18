-- ============================================================================
-- SISTEMA DE GERENCIAMENTO DE BIBLIOTECA
-- Script DQL: Consultas Básicas e Intermediárias (Q1 a Q18)
-- ============================================================================

USE biblioteca;

-- ----------------------------------------------------------------------------
-- CONSULTAS BÁSICAS (Q1 - Q4)
-- ----------------------------------------------------------------------------

-- Q1: Listar todos os livros
SELECT *
FROM livro;

-- Q2: Mostrar nome e nacionalidade dos autores
SELECT nome_autor, nacionalidade
FROM autor;

-- Q3: Mostrar nome e e-mail dos leitores
SELECT nome_leitor, email
FROM leitor;

-- Q4: Mostrar dados dos exemplares
SELECT codigo_patrimonio, status, localizacao
FROM exemplar;

-- ----------------------------------------------------------------------------
-- CONSULTAS INTERMEDIÁRIAS (Q5 - Q18)
-- ----------------------------------------------------------------------------

-- Q5: Livros publicados depois de 2010
SELECT titulo, ano_publicacao
FROM livro
WHERE ano_publicacao > 2010
ORDER BY titulo ASC;

-- Q6: Leitores cujo nome começa por A
SELECT *
FROM leitor
WHERE nome_leitor LIKE 'A%';

-- Q7: Livros e suas categorias
SELECT livro.titulo, categoria.nome_categoria
FROM livro
INNER JOIN categoria ON livro.id_categoria = categoria.id_categoria;

-- Q8: Quantidade de exemplares por livro
SELECT livro.titulo,
       COUNT(exemplar.id_exemplar) AS quantidade_exemplares
FROM livro
INNER JOIN exemplar ON livro.id_livro = exemplar.id_livro
GROUP BY livro.id_livro, livro.titulo;

-- Q9: Estados de conservação sem repetição
SELECT DISTINCT status
FROM exemplar;

-- Q10: Leitor e título de cada empréstimo
SELECT leitor.nome_leitor, livro.titulo
FROM emprestimo
INNER JOIN leitor ON emprestimo.id_leitor = leitor.id_leitor
INNER JOIN exemplar ON emprestimo.id_exemplar = exemplar.id_exemplar
INNER JOIN livro ON exemplar.id_livro = livro.id_livro;

-- Q11: Empréstimos ainda não devolvidos
SELECT *
FROM emprestimo
WHERE data_devolucao_efetiva IS NULL;

-- Q12: Simulação de atraso em 20/11/2026
SELECT *
FROM emprestimo
WHERE data_prevista_devolucao < '2026-11-20'
  AND data_devolucao_efetiva IS NULL;

-- Q13: Livros de categorias selecionadas
SELECT livro.titulo, categoria.nome_categoria
FROM livro
INNER JOIN categoria ON livro.id_categoria = categoria.id_categoria
WHERE categoria.nome_categoria IN ('Fantasia', 'História', 'Filosofia');

-- Q14: Livros entre 1950 e 2010 e idade em 2026
SELECT titulo,
       ano_publicacao,
       (2026 - ano_publicacao) AS idade_livro
FROM livro
WHERE ano_publicacao BETWEEN 1950 AND 2010
ORDER BY ano_publicacao;

-- Q15: Categorias com dois ou mais livros
SELECT categoria.nome_categoria,
       COUNT(livro.id_livro) AS total_livros
FROM categoria
INNER JOIN livro ON categoria.id_categoria = livro.id_categoria
GROUP BY categoria.id_categoria, categoria.nome_categoria
HAVING COUNT(livro.id_livro) >= 2;

-- Q16: Ano mínimo, máximo e média de publicação
SELECT MIN(ano_publicacao) AS ano_mais_antigo,
       MAX(ano_publicacao) AS ano_mais_recente,
       AVG(ano_publicacao) AS media_anos
FROM livro;

-- Q17: Autores com dois ou mais livros
SELECT nome_autor
FROM autor
WHERE id_autor IN (
    SELECT id_autor
    FROM livro_autor
    GROUP BY id_autor
    HAVING COUNT(*) >= 2
);

-- Q18: União de nomes de autores e leitores
SELECT nome_autor AS nome, 'Autor' AS tipo
FROM autor
UNION
SELECT nome_leitor AS nome, 'Leitor' AS tipo
FROM leitor;
