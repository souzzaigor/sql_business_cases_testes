-- 1. Criando a estrutura da tabela
CREATE TABLE limites_credito (
    id_cliente INTEGER,
    limite_total REAL,
    data_atualizacao TEXT
);

-- 2. Gerando limites aleatórios para TODOS os clientes da sua base
INSERT INTO limites_credito (id_cliente, limite_total, data_atualizacao)
SELECT 
    id_cliente, 
    -- Gera limites variados (ex: 2000, 5500, 15000)
    (ABS(RANDOM() % 30) + 4) * 500.00 AS limite_total, 
    date('2024-01-01', '+' || abs(random() % 150) || ' days')
FROM clientes;