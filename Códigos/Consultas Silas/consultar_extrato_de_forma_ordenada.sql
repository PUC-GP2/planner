#consultar extrato de forma ordenada
set @id_cliente = 1; -- id cliente a ser consultado
select l.descricao , l.valor, l.data_lancamento,l.tipo_lancamento  from lancamento l
where l.id_cliente = @id_cliente
order by l.data_lancamento desc
;