-- ============================================================================
-- SISTEMA DE GERENCIAMENTO DE BIBLIOTECA
-- Script Avançado: Trigger e Stored Procedure (Q19 e Q20)
-- ============================================================================

USE biblioteca;

-- ----------------------------------------------------------------------------
-- Q19: Trigger para bloquear empréstimo simultâneo do mesmo exemplar
-- ----------------------------------------------------------------------------
DELIMITER $$

CREATE TRIGGER impedir_emprestimo_duplicado
BEFORE INSERT ON emprestimo
FOR EACH ROW
BEGIN
    -- Verifica se já existe um empréstimo ativo do mesmo exemplar
    IF EXISTS (
        SELECT 1
        FROM emprestimo
        WHERE id_exemplar = NEW.id_exemplar
          AND data_devolucao_efetiva IS NULL
    ) THEN
        -- Erro controlado: cancela o novo empréstimo
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Exemplar ja esta emprestado';
    END IF;
END $$

DELIMITER ;

-- Exemplo de teste controlado (deve retornar Error Code 1644: Exemplar ja esta emprestado):
-- INSERT INTO emprestimo (data_retirada, data_prevista_devolucao, data_devolucao_efetiva, id_leitor, id_exemplar)
-- VALUES ('2026-11-10', '2026-11-24', NULL, 1, 2);

-- ----------------------------------------------------------------------------
-- Q20: Stored Procedure para listar empréstimos ativos
-- ----------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE listar_emprestimos_ativos()
BEGIN
    SELECT leitor.nome_leitor,
           exemplar.codigo_patrimonio,
           emprestimo.data_prevista_devolucao
    FROM emprestimo
    INNER JOIN leitor ON emprestimo.id_leitor = leitor.id_leitor
    INNER JOIN exemplar ON emprestimo.id_exemplar = exemplar.id_exemplar
    WHERE emprestimo.data_devolucao_efetiva IS NULL;
END $$

DELIMITER ;

-- Execução da Stored Procedure:
CALL listar_emprestimos_ativos();
