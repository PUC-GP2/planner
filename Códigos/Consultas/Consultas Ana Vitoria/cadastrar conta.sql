USE `mydb`;
DROP PROCEDURE IF EXISTS `Cadastrar_Conta`;

USE `mydb`;
DELIMITER $$
CREATE PROCEDURE `Cadastrar_Conta` (

IN id INT, 

IN nome VARCHAR(45), 

IN banco CHAR(45),
								  
IN cliente_id VARCHAR(11), 

IN id_limite_gastos INT
)

BEGIN

DECLARE erro SMALLINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE;
   
START TRANSACTION;

	INSERT INTO mydb.Conta
    VALUES (id, nome, banco, cliente_id, id_limite_gastos);
    
    IF erro = FALSE THEN
		COMMIT;
		SELECT 'Conta cadastrada' AS FEEDBACK;
    ELSE
		SELECT 'Erro na inserção da conta' AS FEEDBACK;	
    
    END IF;
    
END $$
DELIMITER ;

-- CALL Cadastrar_Conta(5, 'Corrente', 'Itau', 1, 1) -- TESTE