WITH RECURSIVE fabrica_clientes(id, data_abertura, score) AS (
    SELECT 100, date('2022-01-01', '+' || abs(random() % 730) || ' days'), abs(random() % 1001)
    UNION ALL
    SELECT id + 1, date('2022-01-01', '+' || abs(random() % 730) || ' days'), abs(random() % 1001)
    FROM fabrica_clientes
    WHERE id < 600 
)
INSERT INTO clientes (id_cliente, data_abertura_conta, score_credito)
SELECT id, data_abertura, score FROM fabrica_clientes;


WITH RECURSIVE fabrica_transacoes(id_t, id_c, dt, val, stat, cat, canal) AS (
    SELECT 
        1000, 
        (abs(random() % 600) + 1), 
        date('2023-06-01', '+' || abs(random() % 360) || ' days'), 
        abs(random() % 50000) / 100.0, 
        CASE abs(random() % 5) WHEN 0 THEN 'Negada' ELSE 'Aprovada' END, 
        CASE abs(random() % 4) WHEN 0 THEN 'Supermercado' WHEN 1 THEN 'Farmácia' WHEN 2 THEN 'Eletrônicos' ELSE 'Vestuário' END,
        CASE abs(random() % 3) WHEN 0 THEN 'App' WHEN 1 THEN 'Site' ELSE 'Loja Física' END
        
    UNION ALL
    
    SELECT 
        id_t + 1,
        (abs(random() % 600) + 1),
        date('2023-06-01', '+' || abs(random() % 360) || ' days'),
        abs(random() % 50000) / 100.0,
        CASE abs(random() % 5) WHEN 0 THEN 'Negada' ELSE 'Aprovada' END,
        CASE abs(random() % 4) WHEN 0 THEN 'Supermercado' WHEN 1 THEN 'Farmácia' WHEN 2 THEN 'Eletrônicos' ELSE 'Vestuário' END,
        CASE abs(random() % 3) WHEN 0 THEN 'App' WHEN 1 THEN 'Site' ELSE 'Loja Física' END
    FROM fabrica_transacoes
    WHERE id_t < 3000 
)
INSERT INTO transacoes (id_transacao, id_cliente, data_transacao, valor, status, categoria_compra, canal_venda)
SELECT id_t, id_c, dt, val, stat, cat, canal FROM fabrica_transacoes;