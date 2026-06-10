WITH tb_ap AS(SELECT *
FROM transacoes
WHERE status = 'Aprovada'
)
SELECT id_cliente, MIN(data_transacao) AS primeira_compra, 
MAX(data_transacao) AS ultima_compra,
julianday(MAX(data_transacao)) - julianday(MIN(data_transacao)) AS dias_de_vida
FROM tb_ap
GROUP BY id_cliente
