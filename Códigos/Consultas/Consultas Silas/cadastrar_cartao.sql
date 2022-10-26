#cadastro de cartao
USE `mydb`;
DROP procedure IF EXISTS `insere_cartao`;
DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE insere_cartao( 
in  
id_conta_pagamento int, 
descricao varchar(45) , 
limite double(10,2), 
data_vencimento date, 
data_fechamento date) 
begin 
declare erro tinyint default false; 
declare continue HANDLER for sqlexception set erro = true; 
start transaction; 
	INSERT INTO via_pagamento (descricao) values (descricao);  
	SET @ultimo_id_pagamento = last_insert_id(); 
    INSERT INTO cartao (descricao, limite, data_vencimento, data_fechamento, conta_pagamento_id, via_pagamento_id) 
    values( descricao, limite, data_vencimento, data_fechamento, id_conta_pagamento, @ultimo_id_pagamento) 
    ; 
	if erro = false then 
		commit; 
		select 'Cartão Cadastrado!' as Fim; 
	else 
		rollback; 
		select 'Erro na inserção de cartão!' as Fim; 
	end if; 
end $$
DELIMITER ;