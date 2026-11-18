# 📚 Sistema de Gerenciamento de Biblioteca — Banco de Dados Relacional

Projeto completo de modelagem e implementação de um banco de dados relacional em **MySQL** para o controle de acervo literário e acadêmico, rastreamento individual de cópias físicas, gestão de leitores, reservas e histórico de empréstimos.

Desenvolvido como projeto final da disciplina de **Modelagem de Dados** no **UDF - Centro Universitário**.

---

## 🎯 Objetivo do Projeto

Centralizar e estruturar os dados de uma biblioteca evitando redundâncias e garantindo a integridade referencial. A arquitetura separa o conceito de **obra (`livro`)** de suas **cópias físicas (`exemplar`)**, permitindo rastrear o estado de conservação e a disponibilidade real de cada item por meio do histórico de movimentações.

---

## 🛠️ Tecnologias e Ferramentas

* **SGBD:** MySQL 8.0
* **Modelagem Conceitual:** BrModelo 2.0
* **Modelagem Lógica e Administração:** MySQL Workbench
* **Linguagem:** SQL (DDL, DML, DQL) e recursos procedurais (Triggers e Stored Procedures)

---

## 🏗️ Arquitetura e Modelagem

### 1. Regras de Negócio Principais
* **R1 & R2:** Um livro pode ter múltiplos exemplares físicos (1:N) e ser escrito por um ou mais autores (N:N, resolvido via tabela associativa `livro_autor`).
* **R3:** Todo livro pertence obrigatoriamente a uma categoria temática (`categoria`).
* **R4, R5 & R6:** Um leitor pode realizar múltiplos empréstimos ao longo do tempo, mas um exemplar físico só pode estar vinculado a **um empréstimo ativo por vez**.
* **R7:** Reservas são vinculadas à obra (`livro`) desejada pelo leitor, independentemente de uma cópia física específica.

### 2. Modelo Conceitual (MER) e Modelo Lógico (DER)
O banco de dados é composto por **8 tabelas relacionais**: `categoria`, `autor`, `leitor`, `livro`, `livro_autor`, `exemplar`, `emprestimo` e `reserva`.

> 💡 *Dica: Adicione aqui os prints das Figuras 1 e 2 do seu relatório após subir as imagens na pasta `/docs` ou `/assets` do repositório:*
> ```markdown
> ![Modelo Conceitual - MER](assets/mer_biblioteca.png)
> ![Diagrama Entidade-Relacionamento - DER](assets/der_biblioteca.png)
> ```

---

## 💡 Destaques Técnicos Implementados

* **Bloqueio Automático de Empréstimo Duplicado (`TRIGGER`):**
  Criação da trigger `impedir_emprestimo_duplicado` (`BEFORE INSERT ON emprestimo`), que verifica se o exemplar já possui registro com `data_devolucao_efetiva IS NULL` e dispara um erro controlado via `SIGNAL SQLSTATE '45000'`.
* **Consulta Otimizada de Pendências (`STORED PROCEDURE`):**
  Implementação do procedimento armazenado `listar_emprestimos_ativos()` para retornar rapidamente o leitor, o código de patrimônio do exemplar e o prazo de devolução de todos os itens em aberto.
* **Refatoração de Tipagem Histórica:**
  Substituição do tipo `YEAR` por `INT` na coluna `ano_publicacao` da tabela `livro`, permitindo o cadastro de obras clássicas anteriores a 1901 (como *Dom Casmurro*, de 1899, e *Além do Bem e do Mal*, de 1886).
* **Bateria de 20 Atividades SQL:**
  Consultas cobrindo filtros (`WHERE`, `LIKE`, `BETWEEN`, `IN`, `IS NULL`), junções múltiplas (`INNER JOIN`), agregações (`COUNT`, `MIN`, `MAX`, `AVG`, `GROUP BY`, `HAVING`), subconsultas e união de conjuntos (`UNION`).

---

## 📂 Estrutura Sugerida para o Repositório

```text
├── assets/                  # Diagramas (MER e DER) e prints de execução
├── sql/
│   ├── 01_schema.sql        # Criação do banco e tabelas (DDL)
│   ├── 02_inserts.sql       # Povoamento inicial para testes (DML)
│   ├── 03_queries.sql       # Consultas básicas e intermediárias (Q1 a Q18)
│   └── 04_routines.sql      # Trigger (Q19) e Stored Procedure (Q20)
├── docs/
│   └── Relatorio_Biblioteca_Final.pdf
└── README.md
```

---

## 🚀 Como Executar

1. Clone este repositório:
   ```bash
   git clone https://github.com/m4teusCruz/seu-repositorio.git
   ```
2. Abra o **MySQL Workbench** (ou cliente MySQL de sua preferência).
3. Execute os scripts na ordem numérica (`01_schema.sql` até `04_routines.sql`) para criar a base `biblioteca`, popular os registros de demonstração e testar a Trigger e a Stored Procedure:
   ```sql
   CALL listar_emprestimos_ativos();
   ```

---

## 👥 Autores

* **Mateus Gonçalves da Cruz** — [GitHub](https://github.com/m4teusCruz)
* **Guilherme Nasareth de Sousa**

*Orientação: Profa. MsC. Josyane Lannes Florenzano de Souza (UDF - Centro Universitário).*
