WITH tb_gastos AS (
    SELECT 
        id_cliente, 
        SUM(valor) AS total_gasto
    FROM transacoes
    WHERE status = 'Aprovada'
    GROUP BY id_cliente
)
SELECT 
    t1.id_cliente, 
    t2.limite_total,
    t1.total_gasto, 
    (t1.total_gasto / t2.limite_total) * 100 AS porcentagem_uso
FROM tb_gastos AS t1
LEFT JOIN limites_credito AS t2
    ON t1.id_cliente = t2.id_cliente
ORDER BY porcentagem_uso DESC;
