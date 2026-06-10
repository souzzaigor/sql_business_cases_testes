WITH tb_trat AS (
    SELECT *
    FROM transacoes
    WHERE categoria_compra NOT IN ('Não Informado', 'Outros')
      AND canal_venda NOT IN ('Não Informado', 'Outros')
)
SELECT 
    canal_venda, 
    categoria_compra, 
    COUNT(id_transacao) AS total_tentativas,
    SUM(valor) AS volume_financeiro_total,
    1.0 * SUM(CASE WHEN status = 'Negada' THEN 1 ELSE 0 END) / COUNT(id_transacao) AS taxa_recusa
FROM tb_trat
GROUP BY canal_venda, categoria_compra
ORDER BY taxa_recusa DESC;