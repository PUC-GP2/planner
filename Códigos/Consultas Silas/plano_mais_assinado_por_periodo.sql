#consultar qual o plano mais assinado por periodo
set @inicio_periodo = '2022-01-01'; -- formato data AAAA-MM-DD
set @fim_periodo = '2022-01-31';

select p.descricao , @inicio_periodo as 'inicio periodo', @fim_periodo as 'fim periodo', count(c.plano_id)as 'Soma Assinaturas'
from contrato c
inner join plano p on c.plano_id = p.id  
where inicio_vigencia 
between cast(@inicio_periodo as date) and cast(@fim_periodo as date)
group by p.id 
order by 'Soma Assinaturas' desc
;
