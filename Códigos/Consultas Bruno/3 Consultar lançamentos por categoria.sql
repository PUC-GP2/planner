/* Consultar lançamentos por categoria */

USE `mydb`;
DROP procedure IF EXISTS `query_lancamentos_categoria`;
DELIMITER $$
use `mydb`$$
create procedure query_lancamentos_categoria(
in
Categoria varchar(55)
)
BEGIN
declare erro tinyint default false;
Declare continue HANDLER for sqlexception set erro = true;
Start Transaction;

SELECT  date(l.data_lancamento) as 'Data', l.descricao as 'Lançamento', sum(l.valor) as 'Valor'
FROM lancamento l
	INNER JOIN categoria c ON l.categoria_id = c.id
WHERE c.descricao = Categoria
GROUP BY l.data_lancamento, l.descricao
ORDER BY l.data_lancamento;

end $$
DELIMITER ;

-- EXEMPLO
call query_lancamentos_categoria('Salário');