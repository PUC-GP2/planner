#CRIAÇÃO DE USUÁRIOS 
create user if not exists 'administrador'@'localhost' identified by 'admin'; 
create user if not exists 'cliente'@'localhost' identified by '1234'; 
 
#CONCESSÃO DE ACESSO DOS USUÁRIOS NAS TABELAS 

GRANT SELECT, INSERT, UPDATE, DELETE  ON * . * TO administrador@localhost with grant option;  

GRANT SELECT, INSERT, UPDATE, DELETE  
ON mydb.limite_gastos  
TO cliente@localhost;  

GRANT SELECT  
ON mydb.plano  
TO cliente@localhost;  

GRANT SELECT  
ON mydb.contrato  
TO cliente@localhost;  

GRANT SELECT, INSERT, UPDATE  
ON mydb.cliente  
TO cliente@localhost;  

GRANT SELECT, INSERT, UPDATE, DELETE  
ON mydb.conta 
TO cliente@localhost;  

GRANT SELECT, INSERT, UPDATE, DELETE  
ON mydb.cartao  
TO cliente@localhost;  

GRANT SELECT, INSERT, UPDATE, DELETE  
ON mydb.via_pagamento  
TO cliente@localhost;  

GRANT SELECT, INSERT, UPDATE, DELETE  
ON mydb.categoria  
TO cliente@localhost;  

GRANT SELECT, INSERT, UPDATE, DELETE
ON mydb.lancamento
TO cliente@localhost;
 
 
#INSEÇÃO REGISTROS 

# TABELA PLANO 
INSERT INTO mydb.plano 
(descricao,preco) 
VALUES 
('Free',0.00), 
('Premium',100.00); 

# TABELA CONTRATO 
 INSERT INTO mydb.contrato  
(inicio_vigencia,fim_vigencia,plano_id)  
VALUES  
('2022-01-01','2022-07-01',1),  
('2022-01-01','2023-01-01',2) 
;

# PROCEDURE PARA POPULAR CLIENTE

USE `mydb`;
DROP procedure IF EXISTS `insere_cliente`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE insere_cliente( 

in nome varchar(255) , 

email varchar(50), 

senha varchar(50), 

plano_id int 

) 

BEGIN
declare erro tinyint default false;
Declare continue HANDLER for sqlexception set erro = true; 

start transaction; 

    INSERT INTO contrato (inicio_vigencia, plano_id) values (now(),plano_id); -- Plano_id 1 é o plano grátis 

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

# CALL PROCEDURE INSERÇÃO CLIENTE
call insere_cliente('Joao Silva','joaozinho@email.com','1234xdb',1); 


#TABELA LIMITE_GASTOS 
INSERT INTO mydb.limite_gastos  
(valor,id_cliente)  
VALUES  
('1500.25',1),  
('2500.01',1); 
 
#TABELA CONTA 
INSERT INTO mydb.conta   
(nome,banco,cliente_id,id_limite_gastos)  
VALUES  
('Corrente','Itaú',1,1);  
INSERT INTO mydb.conta   
(nome,banco,cliente_id)  
VALUES  
('Poupança','Brasil',1); 

# TABELA VIA_PAGAMENTO 
INSERT INTO mydb.Via_Pagamento  
(descricao)  
VALUES  
('Dinheiro'),
('Pix'); 

# PROCEDURE POPULAR TABELA CARTAO
USE `mydb`;
DROP procedure IF EXISTS `insere_cartao`;

DELIMITER $$
USE `mydb`$$
CREATE PROCEDURE insere_cartao( 

in  

id_cliente int, 

id_conta_pagamento int, 

descricao varchar(45) , 

limite double(10,2), 

data_vencimento date, 

data_fechamento date) 

begin 

declare erro tinyint default false; 

declare continue HANDLER for sqlexception set erro = true; 

start transaction; 

	INSERT INTO via_pagamento  (descricao) values (descricao);  

	SET @ultimo_id_pagamento = last_insert_id(); 

    INSERT INTO cartao (descricao,limite,data_vencimento,data_fechamento,conta_pagamento_id,via_pagamento_id,id_cliente) 

    values( descricao, limite, data_vencimento, data_fechamento, id_conta_pagamento, @ultimo_id_pagamento, id_cliente) 

    ; 

	if erro = false then 

		commit; 

		select 'Cartão Cadastrado!' as Fim; 

	else 

		rollback; 

		select 'Erro na inserção de cartão!' as Fim; 

	end if; 
end 
;$$

DELIMITER ;

# CALL procedure para inserção cartão -- PRECISA REVISAR
-- call insere_cartao (1,1,'Cartão Master Nu','5000.00','2022-12-10','2022-12-05');

# TABELA CATEGORIA  
INSERT INTO mydb.categoria  
(descricao)  
VALUES  
('Aluguel'),  
('Alimentação'),
('Educação') 
;
INSERT INTO mydb.categoria  
(descricao,limite_gastos_id)  
values 
('Salário',2);  

# TABELA LANÇAMENTO 
INSERT into mydb.lancamento  
(descricao,valor, data_lancamento, tipo_lancamento, conta_id, id_via_pagamento, categoria_id,id_cliente)  
VALUES  
('Aluguel Junho','-600.00','2022-02-17','Despesa',1,1,1,1),  
('Ifood','-20.00','2022-03-02','Despesa',1,2,2,1),  
('Salario','1500.00','2022-05-25','Receita',1,2,4,1),
('Faculdade','-150.00','2022-05-25','Despesa',1,2,3,1),
('Salario','1500.00','2022-06-25','Receita',1,2,4,1),
('Salario','1500.00','2022-07-25','Receita',1,2,4,1),
('Bonus','200.00','2022-07-25','Receita',1,2,4,1)
;