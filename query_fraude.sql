WITH ts_aprov AS (SELECT *
FROM transacoes
WHERE status = "Aprovada"
)
SELECT id_transacao, t1.id_cliente,valor,
AVG(valor) OVER (PARTITION BY t1.id_cliente) AS media_do_cliente,
CASE WHEN valor > (AVG(valor) OVER (PARTITION BY t1.id_cliente)) * 2 THEN 'Suspeito'
ELSE 'Normal' END AS alerta_fraude
FROM clientes AS t1
LEFT JOIN ts_aprov AS t2
ON t1.id_cliente = t2.id_cliente
