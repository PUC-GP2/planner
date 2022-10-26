-- Cadastrar as opções padrão de categorização de lançamentos 

USE `mydb`;
DROP procedure IF EXISTS `cadastro_opcao_lançamento`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `cadastro_opcao_lançamento` (

IN descricao VARCHAR(55),

IN limite_gastos_id INT
)

BEGIN

DECLARE erro SMALLINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE; 

START TRANSACTION;

	INSERT INTO categoria (descricao,limite_gastos_id)
	VALUES (descricao,limite_gastos_id)
    ON DUPLICATE KEY UPDATE descricao=descricao;
    
    IF erro = FALSE THEN
    
    COMMIT; 
	SELECT 'Opção cadastrada!' AS FEEDBACK;

	ELSE
    
    ROLLBACK;
	SELECT 'Erro na inserção da opção!' AS FEEDBACK;
    
    END IF;

END$$

DELIMITER ;

-- CALL cadastro_opcao_lançamento ('gasolina',3); -- TEST