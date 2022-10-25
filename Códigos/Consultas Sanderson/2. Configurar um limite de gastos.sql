-- Configurar um limite de gastos 

USE `mydb`;
DROP procedure IF EXISTS `configurar_gastos`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE `configurar_gastos` (

IN valor DOUBLE(10,2),

IN id_cliente INT
)

BEGIN

DECLARE erro SMALLINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE; 

START TRANSACTION;

	INSERT INTO limite_gastos (valor,id_cliente)
	VALUES (valor,id_cliente)
    ON DUPLICATE KEY UPDATE valor=valor;

    IF erro = FALSE THEN
    
		COMMIT; 
		SELECT 'Limite Configurado!' AS FEEDBACK;

	ELSE
    
		ROLLBACK;
		SELECT 'Erro na configuração do limite!' AS FEEDBACK;
    
    END IF;

END$$

DELIMITER ;

-- CALL configurar_gastos (2000.20,1); -- TESTE