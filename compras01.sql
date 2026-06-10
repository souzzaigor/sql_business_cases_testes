WITH trans_aprov AS (SELECT *
FROM transacoes
WHERE status = 'Aprovada'
),
trans_rank AS (SELECT id_cliente, id_transacao, data_transacao, valor,
ROW_NUMBER() OVER (PARTITION BY id_cliente ORDER BY data_transacao DESC) as Rank
FROM trans_aprov)
SELECT *
FROM trans_rank

WHERE Rank = 1;








