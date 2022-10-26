USE `mydb`;
DROP PROCEDURE IF EXISTS `Cadastrar_Categoria`;

USE `mydb`;
DELIMITER $$
CREATE PROCEDURE `Cadastrar_Categoria` (

IN id INT, 

IN descricao VARCHAR(55), 

IN id_limite_gastos INT
)

BEGIN

DECLARE erro SMALLINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro = TRUE;

START TRANSACTION;
    
	INSERT INTO mydb.Categoria
	VALUES (id, descricao, id_limite_gastos);
		
	IF erro = FALSE THEN
		COMMIT;
		SELECT 'Categoria cadastrada' AS FEEDBACK;
	ELSE
		SELECT 'Erro na inserção da categoria' AS FEEDBACK;	
	END IF;
			
END $$
DELIMITER ;

-- CALL Cadastrar_Categoria(5,'Agua', 1) -- TESTE
