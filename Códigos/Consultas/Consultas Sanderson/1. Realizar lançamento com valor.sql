-- Realizar lançamento com valor classificando-a em tipo (gasto/receita/tranferencia), categoria, conta, via de pagamento e data

USE `mydb`;
DROP procedure IF EXISTS `realizar_lancamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `realizar_lancamento` ( 

IN descrição VARCHAR(255) , 

IN valor DOUBLE(10,2), 

IN conta_id INT,

IN categoria_id INT,

IN id_cliente INT,

IN id_via_de_pagamento INT
) 

BEGIN 

DECLARE erro SMALLINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE; 

START TRANSACTION;

IF valor < 0 then 
    
		INSERT INTO lancamento (descricao,valor,data_lancamento,tipo_lancamento,conta_id,categoria_id,id_cliente,id_via_pagamento) 
		VALUES (descricao,valor,NOW(),'Despesa',conta_id,categoria_id,id_cliente,id_via_de_pagamento);

ELSE

		INSERT INTO lancamento (descricao,valor,data_lancamento,tipo_lancamento,conta_id,categoria_id,id_cliente,id_via_pagamento)
		VALUES (descricao,valor,NOW(),'Receita',conta_id,categoria_id,id_cliente,id_via_de_pagamento);

END IF; 
    
IF erro = false then
    
		commit; 
		SELECT 'Lançamento realizado com sucesso!' AS FEEDBACK;

ELSE
    
		ROLLBACK;
		SELECT 'Erro na lançamento!' AS FEEDBACK;
    
    END IF;

END$$

DELIMITER ;

-- CALL realizar_lancamento ('callLancamento','2000.33',1,2,1,2); -- TEST
