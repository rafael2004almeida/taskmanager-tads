# ESPECIFICAÇÃO TÉCNICA E DOCUMENTAÇÃO DO PROJETO TASKMANAGER
**Nome:** Rafael Almeida Barbosa
**Curso:** Tecnologia em Análise e Desenvolvimento de Sistemas (TADS)  
**Disciplina:** Optativa 2 - Projeto de Sistemas  
**Instituição:** Instituto Federal do Norte de Minas Gerais (IFNMG)  

## 1. VISÃO GERAL DO PROJETO
O **TaskManager** é uma plataforma completa para gerenciamento de tarefas pessoais e profissionais, desenvolvida para solucionar problemas de organização e acompanhamento de compromissos corporativos. O sistema abrange desde o levantamento de requisitos até a implementação da API REST, banco de dados relacional e interface Web.

## 2. ARQUITETURA E PADRÕES DE PROJETO
* **Arquitetura em Camadas:** Separação clara entre Apresentação (Frontend), Controladores HTTP (API REST), Regras de Negócio (Services) e Persistência de Dados (DAOs/Repositories).
* **Padrões de Projeto (Design Patterns):**
  * **Factory Method:** Utilizado na criação de tarefas e notificações conforme a prioridade e o tipo.
  * **Strategy:** Aplicado nos algoritmos de ordenação e filtragem dinâmica de tarefas.

## 3. ESTRUTURAS DE DADOS E ALGORITMOS IMPLEMENTADOS
* **Algoritmo de Ordenação Personalizado (QuickSort Híbrido):** Ordenação de tarefas por prazo de conclusão e prioridade com complexidade temporal média $O(n \log n)$.
* **Fila de Prioridades (Max-Heap Binário):** Estrutura para organizar e resgatar tarefas com prioridades urgentes em tempo $O(1)$ para consulta e $O(\log n)$ para inserção/remoção.
* **Tabela Hash Customizada:** Indexação e busca rápida de tarefas por palavras-chave com encadeamento para tratamento de colisões.

## 4. MODELAGEM DE BANCO DE DADOS (3FN)
O banco de dados relacional (PostgreSQL/MySQL) foi projetado na Terceira Forma Normal (3FN), contendo:
* **Entidades Principais:** `usuarios`, `categorias`, `tarefas`, `subtarefas`, `historico_alteracoes`.
* **Integridade Referencial:** Restrições de chave estrangeira com ações em cascata (`ON DELETE CASCADE`).
* **View Analítica (`vw_dashboard_produtividade`):** Consolidação dos totais de tarefas pendentes, em andamento, concluídas, atrasadas e cálculo do percentual de produtividade.

## 5. REQUISITOS ATENDIDOS
* **Módulo 1 (Usuários e Autenticação):** Cadastro, login, gestão de perfil, recuperação segura de senha e isolamento de acesso aos dados (RF01 a RF05).
* **Módulo 2 (Gerenciamento de Tarefas):** CRUD completo, status, prioridades, categorias, subtarefas, datas de conclusão e histórico de auditoria (RF06 a RF13).
* **Módulo 3 (Organização e Consulta):** Busca por palavra-chave, filtros por período/categoria/prioridade, identificação visual de atrasos e visualização em Lista/Kanban (RF14 a RF19).
* **Módulo 4 (Produtividade e Relatórios):** Dashboard com gráficos, cálculo de percentuais, tarefas atrasadas e exportação de relatórios (RF20 a RF25).

## 6. SEGURANÇA E REQUISITOS NÃO-FUNCIONAIS
* **Criptografia:** Senhas armazenadas utilizando algoritmo de hashing seguro (Bcrypt).
* **Autorização:** Acesso restrito via tokens seguros, impedindo que um usuário acesse tarefas de terceiros (RNF05).
* **Variáveis de Ambiente:** Credenciais e segredos isolados do código-fonte através de arquivos `.env` (RNF03).
