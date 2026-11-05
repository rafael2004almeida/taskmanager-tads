CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cor_hex VARCHAR(7) DEFAULT '#808080',
    CONSTRAINT fk_categoria_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE tarefas (
    id_tarefa SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    estado VARCHAR(20) DEFAULT 'pendente' 
        CHECK (estado IN ('pendente', 'em andamento', 'concluida', 'cancelada')),
    prioridade VARCHAR(20) DEFAULT 'media' 
        CHECK (prioridade IN ('baixa', 'media', 'alta', 'urgente')),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    prazo_conclusao TIMESTAMP,
    data_conclusao TIMESTAMP,
    CONSTRAINT fk_tarefa_usuario FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_tarefa_categoria FOREIGN KEY (id_categoria) 
        REFERENCES categorias(id_categoria) ON DELETE SET NULL
);

CREATE TABLE subtarefas (
    id_subtarefa SERIAL PRIMARY KEY,
    id_tarefa INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    concluida BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_subtarefa_tarefa FOREIGN KEY (id_tarefa) 
        REFERENCES tarefas(id_tarefa) ON DELETE CASCADE
);

CREATE TABLE historico_alteracoes (
    id_historico SERIAL PRIMARY KEY,
    id_tarefa INT NOT NULL,
    estado_anterior VARCHAR(20),
    estado_novo VARCHAR(20),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_historico_tarefa FOREIGN KEY (id_tarefa) 
        REFERENCES tarefas(id_tarefa) ON DELETE CASCADE
);

CREATE INDEX idx_tarefas_usuario ON tarefas(id_usuario);
CREATE INDEX idx_tarefas_estado ON tarefas(estado);
CREATE INDEX idx_tarefas_prioridade ON tarefas(prioridade);
CREATE INDEX idx_tarefas_prazo ON tarefas(prazo_conclusao);

CREATE OR REPLACE VIEW vw_dashboard_produtividade AS
SELECT 
    id_usuario,
    COUNT(*) AS total_tarefas,
    COUNT(CASE WHEN estado = 'concluida' THEN 1 END) AS concluidas,
    COUNT(CASE WHEN estado = 'em andamento' THEN 1 END) AS em_andamento,
    COUNT(CASE WHEN estado = 'pendente' THEN 1 END) AS pendentes,
    COUNT(CASE WHEN estado = 'cancelada' THEN 1 END) AS canceladas,
    COUNT(CASE WHEN prazo_conclusao < CURRENT_TIMESTAMP AND estado != 'concluida' THEN 1 END) AS atrasadas,
    ROUND(
        (COUNT(CASE WHEN estado = 'concluida' THEN 1 END)::DECIMAL / NULLIF(COUNT(*), 0)) * 100, 2
    ) AS percentual_concluido
FROM tarefas
GROUP BY id_usuario;

INSERT INTO usuarios (nome, email, senha_hash) VALUES
('Aluno TADS', 'aluno@ifnmg.edu.br', '$2b$10$e8T/kPz6fUq9bC1G9y3uEO8vXm7/bS2zG3hN1');

INSERT INTO categorias (id_usuario, nome, cor_hex) VALUES
(1, 'Estudos', '#3498db'),
(1, 'Trabalho', '#e74c3c');

INSERT INTO tarefas (id_usuario, id_categoria, titulo, descricao, estado, prioridade, prazo_conclusao) VALUES
(1, 1, 'Entregar Projeto Optativa 2', 'Finalizar documentacao e banco de dados do TaskManager', 'em andamento', 'urgente', '2026-11-30 23:59:00'),
(1, 2, 'Reunião de Alinhamento', 'Reunião com a equipe de desenvolvimento', 'concluida', 'alta', '2026-11-01 10:00:00');
