/* Consultar lançamentos por categoria */

SELECT  date(l.data_lancamento) as 'Data', l.descricao as 'Lançamento', sum(l.valor) as 'Valor'
FROM lancamento l
	INNER JOIN categoria c ON l.categoria_id = c.id
WHERE c.descricao = 'Salário' -- Exemplo. Na aplicação haveria input para escolher a categoria
GROUP BY l.data_lancamento, l.descricao
ORDER BY l.data_lancamento
;