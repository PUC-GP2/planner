/* CADASTRO CLIENTE */
-- -----------------------------------------
# PROCEDURE PARA CADASTRAR NOVO CLIENTE

USE `mydb`;
DROP procedure IF EXISTS `cadastro_cliente`;
DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE cadastro_cliente( 
in nome varchar(255) , 
email varchar(50), 
senha varchar(50) 
) 
BEGIN
declare erro tinyint default false;
Declare continue HANDLER for sqlexception set erro = true; 
start transaction; 
    INSERT INTO contrato (inicio_vigencia, plano_id) values (now(),1); -- Plano_id 1 é o plano grátis 
	SET @vUltimoContrato = last_insert_id(); 
	INSERT INTO cliente (nome, email, senha, id_contrato) 
	VALUES 	(nome,email,senha, @vUltimoContrato); 
	if erro = false then 
		commit; 
		select 'Cliente Inserido!' as Fim; 
	else 
		rollback; 
		select 'Erro na inserção!' as Fim; 
	end if; 
end$$
DELIMITER ;
-- EXEMPLO
call cadastro_cliente('Bruno','@gmail','45623');

-- -----------------------------------------------
/* PROCEDURE PARA UPDATE CLIENTE */

USE `mydb`;
DROP procedure IF EXISTS `update_cliente`;
DELIMITER $$
use `mydb`$$
create procedure update_cliente(
in
idcliente int,
NovoNome varchar(255),
NovoEmail varchar(55),
NovaSenha char(60)
)
BEGIN
declare erro tinyint default false;
Declare continue HANDLER for sqlexception set erro = true;
Start Transaction;
	IF NovoNome IS NOT NULL THEN 
		UPDATE cliente
		SET nome = NovoNome 
		WHERE id = idcliente ;
        select 'Nome atualizado!';
	END IF;
	IF NovoEmail IS NOT NULL THEN 
		UPDATE cliente
		SET email = NovoEmail 
		WHERE id = idcliente ;
        select 'Email atualizado!';
	END IF;
	IF NovaSenha IS NOT NULL THEN 
		UPDATE cliente
		SET senha = NovaSenha 
		WHERE id = idcliente ;
        select 'Senha atualizada!';
	END IF;
	IF erro = false then 
		commit; 
	else 
		rollback; 
		select 'Erro na atualizacao!' as Fim; 
	end if; 
end $$
DELIMITER ;
-- EXEMPLO: 
call update_cliente(2,NULL, NULL, '123456789');

-- -------------------------------------------------------
/* PROCEDURE PARA DELETAR CLIENTE */

USE `mydb`;
DROP procedure IF EXISTS `delete_cliente`;
DELIMITER $$
use `mydb`$$
create procedure delete_cliente(
in
idCliente int
)
BEGIN
declare erro tinyint default false;
Declare continue HANDLER for sqlexception set erro = true;
Start Transaction;

	UPDATE contrato
	set fim_vigencia = now()
	where id = (select id_contrato from cliente where id = idCliente); -- Onde o ID do contrato for igual o contrato_id para o cliente a ser deletado
	DELETE FROM cliente
	WHERE id = idCliente ;

	IF erro = false then
		commit;
		select 'Cliente deletado, e vigência do contrato finalizada!' as Fim; 
	else 
		rollback; 
		select 'Erro na atualizacao!' as Fim; 
	end if; 
end $$
DELIMITER ;
-- EXEMPLO
call delete_cliente(2);




