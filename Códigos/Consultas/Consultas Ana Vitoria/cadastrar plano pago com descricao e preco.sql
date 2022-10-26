USE `mydb`;
DROP PROCEDURE IF EXISTS `Cadastrar_Plano`;

USE `mydb`;
DELIMITER $$
CREATE PROCEDURE `Cadastrar_Plano` (

IN id INT, 

IN descricao VARCHAR(55), 

IN preco DOUBLE(10,2)
)

BEGIN

DECLARE erro SMALLINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE;

START TRANSACTION;
    
	INSERT INTO mydb.Plano
    VALUES (id, descricao, preco);
    
    IF erro = FALSE THEN
		COMMIT;
		SELECT 'Plano cadastrado' AS FEEDBACK;
    ELSE
		SELECT 'Erro na inserção do plano' AS FEEDBACK;	
    
    END IF;
    
END $$
DELIMITER ;

-- CALL Cadastrar_Plano(3,'Gold', '150'); -- TEST