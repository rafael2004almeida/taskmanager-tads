**Curso:** Tecnologia em Análise e Desenvolvimento de Sistemas (TADS)  
**Disciplina:** Optativa 2 - Projeto de Sistemas  
**Instituição:** Instituto Federal do Norte de Minas Gerais (IFNMG)  


## 1. VISÃO GERAL DO PROJETO
O **TaskManager** é uma plataforma completa para gerenciamento de tarefas pessoais e profissionais, desenvolvida para solucionar problemas de organização e acompanhamento de compromissos corporativos[cite: 1]. O sistema abrange desde o levantamento de requisitos até a implementação da API REST, banco de dados relacional e interface Web[cite: 1, 3, 4].

## 2. ARQUITETURA E PADRÕES DE PROJETO
* **Arquitetura em Camadas:** Separação clara entre Apresentação (Frontend), Controladores HTTP (API REST), Regras de Negócio (Services) e Persistência de Dados (DAOs/Repositories)[cite: 3, 4].
* **Padrões de Projeto (Design Patterns):**
  * **Factory Method:** Utilizado na criação de tarefas e notificações conforme a prioridade e o tipo[cite: 2].
  * **Strategy:** Aplicado nos algoritmos de ordenação e filtragem dinâmica de tarefas[cite: 2].

## 3. ESTRUTURAS DE DADOS E ALGORITMOS IMPLEMENTADOS
* **Algoritmo de Ordenação Personalizado (QuickSort Híbrido):** Ordenação de tarefas por prazo de conclusão e prioridade com complexidade temporal média $O(n \log n)$[cite: 3].
* **Fila de Prioridades (Max-Heap Binário):** Estrutura para organizar e resgatar tarefas com prioridades urgentes em tempo $O(1)$ para consulta e $O(\log n)$ para inserção/remoção[cite: 3].
* **Tabela Hash Customizada:** Indexação e busca rápida de tarefas por palavras-chave com encadeamento para tratamento de colisões[cite: 3].

## 4. MODELAGEM DE BANCO DE DADOS (3FN)
O banco de dados relacional (PostgreSQL/MySQL) foi projetado na Terceira Forma Normal (3FN), contendo[cite: 3]:
* **Entidades Principais:** `usuarios`, `categorias`, `tarefas`, `subtarefas`, `historico_alteracoes`[cite: 1, 2].
* **Integridade Referencial:** Restrições de chave estrangeira com ações em cascata (`ON DELETE CASCADE`)[cite: 3, 4].
* **View Analítica (`vw_dashboard_produtividade`):** Consolidação dos totais de tarefas pendentes, em andamento, concluídas, atrasadas e cálculo do percentual de produtividade[cite: 2, 3].

## 5. REQUISITOS ATENDIDOS
* **Módulo 1 (Usuários e Autenticação):** Cadastro, login, gestão de perfil, recuperação segura de senha e isolamento de acesso aos dados (RF01 a RF05)[cite: 1].
* **Módulo 2 (Gerenciamento de Tarefas):** CRUD completo, status, prioridades, categorias, subtarefas, datas de conclusão e histórico de auditoria (RF06 a RF13)[cite: 1, 2].
* **Módulo 3 (Organização e Consulta):** Busca por palavra-chave, filtros por período/categoria/prioridade, identificação visual de atrasos e visualização em Lista/Kanban (RF14 a RF19)[cite: 2].
* **Módulo 4 (Produtividade e Relatórios):** Dashboard com gráficos, cálculo de percentuais, tarefas atrasadas e exportação de relatórios (RF20 a RF25)[cite: 2].

## 6. SEGURANÇA E REQUISITOS NÃO-FUNCIONAIS
* **Criptografia:** Senhas armazenadas utilizando algoritmo de hashing seguro (Bcrypt)[cite: 3, 4].
* **Autorização:** Acesso restrito via tokens seguros, impedindo que um usuário acesse tarefas de terceiros (RNF05)[cite: 4].
* **Variáveis de Ambiente:** Credenciais e segredos isolados do código-fonte através de arquivos `.env` (RNF03)[cite: 4].
