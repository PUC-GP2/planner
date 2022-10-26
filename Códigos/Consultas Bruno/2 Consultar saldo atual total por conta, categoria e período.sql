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


/*
-- Idealmente haveria uma procedure com loop em cima dos meses, mas nao consegui termina-la a tempo

drop procedure if exists tabela_saldo;

delimiter $$
create procedure tabela_saldo(
in
idconta int, 
periodoini date, 
periodofin date)
begin

  start transaction;
  
	CREATE TEMPORARY TABLE BaseTable
	SELECT ca.descricao AS 'Categoria',
		sum(CASE WHEN extract( year_month from l.data_lancamento) = extract( year_month from periodoini) THEN l.valor ELSE NULL END) AS 'dataformatada'
	FROM lancamento l INNER JOIN categoria ca ON l.categoria_id = ca.id
	WHERE l.conta_id = idconta
	GROUP BY ca.descricao;

  set vmonth = periodoini;
  
  while v_month != periodofin do
    SELECT ca.descricao AS 'Categoria',
		sum(CASE WHEN extract( year_month from l.data_lancamento) = 'v_month' THEN l.valor ELSE NULL END) AS '06/2022'
	FROM lancamento l
		INNER JOIN categoria ca ON l.categoria_id = ca.id
	WHERE l.conta_id = 1 -- exemplo. No app haveria espaço para input
	GROUP BY ca.descricao;
 
    SELECT * FROM BaseTable b FULL JOIN AddColumnTable a ON b.Categoria = a.Categoria as BaseTable;
    
	set vmonth = DATE_ADD(l.data_lancamento,INTERVAL 1 MONTH);
    end while;
  commit;
end $$
delimiter ;
*/