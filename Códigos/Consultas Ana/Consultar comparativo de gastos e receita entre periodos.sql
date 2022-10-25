select tipo_lancamento as 'Tipo de Lançamento',
sum(CASE WHEN extract(year_month from data_lancamento) = '202206' then valor else 0 end) as '06/2022',
sum(CASE WHEN extract(year_month from data_lancamento) = '202207' then valor else 0 end) as '07/2022'
from Lancamento
group by tipo_lancamento