/* Consultar saldo atual total por conta, categoria e período */


-- Aqui estou colocando como exemplo apenas dois meses.

SELECT ca.descricao AS 'Categoria',
	sum(CASE WHEN extract( year_month from l.data_lancamento) = '202206' THEN l.valor ELSE NULL END) AS '06/2022',
	sum(CASE WHEN extract( year_month from l.data_lancamento) = '202207' THEN l.valor ELSE NULL END) AS '07/2022'
FROM lancamento l
	INNER JOIN categoria ca ON l.categoria_id = ca.id
WHERE l.conta_id = 1 -- exemplo. No app haveria espaço para input
GROUP BY ca.descricao
;