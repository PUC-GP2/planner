/* CADASTRO CLIENTE */


/* INSERT */
-- Quando um novo cliente é cadastrado, um contrato no plano free é automaticamente gerado pra ele.
INSERT INTO contrato (inicio_vigencia, plano_id) 
VALUES (now(),1); -- Plano_id 1 é o plano grátis
SET @vUltimoContrato = last_insert_id(); -- O id do contrato criado é usado para o novo cliente
INSERT INTO cliente (nome, email, senha, id_contrato)
VALUES ('NOME','EMAIL','SENHA', @vUltimoContrato); -- Exemplo. Na aplicação haveria o espaço para o input.

/* UPDATE */
UPDATE cliente
SET email = 'NOVOEMAIL' -- Exemplo. Na aplicação haveria o espaço para o input.
WHERE id = 2 ; -- Exemplo. Na aplicação o id do cliente em sessão seria recuperado.
UPDATE cliente
SET senha = 'NOVASENHA' -- Exemplo. Na aplicação haveria o espaço para o input.
WHERE id = 2 ; -- Exemplo. Na aplicação o id do cliente em sessão seria recuperado.
UPDATE cliente
SET nome = 'NOVONOME' -- Exemplo. Na aplicação haveria o espaço para o input.
WHERE id = 2 ; -- Exemplo. Na aplicação o id do cliente em sessão seria recuperado.

/* DELETE */
UPDATE contrato
set fim_vigencia = now()
where id = (select id_contrato from cliente where id = 2); -- Onde o ID do contrato for igual o contrato_id para o cliente de id = 2, neste exemplo
DELETE FROM cliente
WHERE id = 2 ; -- Exemplo. Na aplicação o id do cliente em sessão seria recuperado.






