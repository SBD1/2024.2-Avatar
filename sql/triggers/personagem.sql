-- Impede que o id de um personagem seja alterado manualmente
CREATE OR REPLACE FUNCTION alterate_personagem_id()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.id <> OLD.id) THEN
    RAISE EXCEPTION 'O id do personagem não pode ser alterado manualmente';
    RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION delete_personagem()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM personagem WHERE id = OLD.id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER; -- Para permitir a manipulação da table personagem pelo trigger


-- PC
CREATE OR REPLACE FUNCTION create_pc()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.id IS NOT NULL) THEN
    RAISE EXCEPTION 'O id do personagem não pode ser definido manualmente';
    RETURN NULL;
  END IF;

  INSERT INTO personagem(tipo) 
  VALUES ('P')
  RETURNING id INTO NEW.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER insert_pc
BEFORE INSERT ON pc
FOR EACH ROW
EXECUTE PROCEDURE create_pc();

CREATE TRIGGER update_pc
BEFORE UPDATE ON pc
FOR EACH ROW
EXECUTE PROCEDURE alterate_personagem_id();

CREATE TRIGGER delete_pc
AFTER DELETE ON pc
FOR EACH ROW
EXECUTE PROCEDURE delete_personagem();


-- INIMIGO
CREATE OR REPLACE FUNCTION create_inimigo()
RETURNS TRIGGER AS $$
BEGIN

  IF (NEW.id IS NOT NULL) THEN
    RAISE EXCEPTION 'O id do inimigo não pode ser definido manualmente';
    RETURN NULL;
  END IF;
  
  INSERT INTO personagem(tipo) 
  VALUES ('I')
  RETURNING id INTO NEW.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER insert_inimigo
BEFORE INSERT ON inimigo
FOR EACH ROW
EXECUTE PROCEDURE create_inimigo();


CREATE TRIGGER update_inimigo
BEFORE UPDATE ON inimigo
FOR EACH ROW
EXECUTE PROCEDURE alterate_personagem_id();

CREATE TRIGGER delete_inimigo
AFTER DELETE ON inimigo
FOR EACH ROW
EXECUTE PROCEDURE delete_personagem();


-- AMIGO
-- Valida os atributos da especialização de amigo (mestre, mercador, curandeiro)
CREATE OR REPLACE FUNCTION validate_amigo(NEW amigo)
RETURNS VOID AS $$
BEGIN

  IF (NEW.eh_mestre AND NEW.nivel_necessario_discipulo IS NULL) THEN
    RAISE EXCEPTION 'O mestre deve ter um nível necessário para discípulo';
  END IF;

  IF (NOT NEW.eh_mestre AND NEW.nivel_necessario_discipulo IS NOT NULL) THEN
    RAISE EXCEPTION 'Amigo nao eh mestre, logo nao pode ter nivel necessario para discipulo';
  END IF;

  IF (NEW.eh_mercador AND (NEW.nivel_necessario_compra IS NULL OR NEW.mult_preco IS NULL)) THEN
    RAISE EXCEPTION 'O mercador deve ter um nível necessário para compra e multiplicador de preço';
  END IF;

  IF (NOT NEW.eh_mercador AND (NEW.nivel_necessario_compra IS NOT NULL OR NEW.mult_preco IS NOT NULL)) THEN
    RAISE EXCEPTION 'Amigo nao eh mercador, logo nao pode ter nivel necessario para compra e multiplicador de preço';
  END IF;

  IF (NEW.eh_curandeiro AND (NEW.preco_por_ponto_cura IS NULL)) THEN
    RAISE EXCEPTION 'O curandeiro deve ter um preço por ponto de cura';
  END IF;

  IF (NOT NEW.eh_curandeiro AND NEW.preco_por_ponto_cura IS NOT NULL) THEN
    RAISE EXCEPTION 'Amigo nao eh curandeiro, logo nao pode ter um preço por ponto de cura';
  END IF;

END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION create_amigo()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.id IS NOT NULL) THEN
    RAISE EXCEPTION 'O id do amigo não pode ser inserido manualmente';
  END IF;

  PERFORM validate_amigo(NEW);

  INSERT INTO personagem(tipo) 
  VALUES ('A')
  RETURNING id INTO NEW.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION alterate_amigo()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.id <> OLD.id) THEN
    RAISE EXCEPTION 'O id do amigo não pode ser alterado manualmente';
  END IF;
  PERFORM validate_amigo(NEW);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER insert_amigo
BEFORE INSERT ON amigo
FOR EACH ROW
EXECUTE PROCEDURE create_amigo();

CREATE TRIGGER update_amigo
BEFORE UPDATE ON amigo
FOR EACH ROW
EXECUTE PROCEDURE alterate_amigo();

CREATE TRIGGER delete_amigo
AFTER DELETE ON amigo
FOR EACH ROW
EXECUTE PROCEDURE delete_personagem();

INSERT INTO nacao(nome, descricao)
VALUES 

    ('Tribos da Água', ''),
    ('Reino da Terra', ''),
    ('Nação do Fogo', ''),
    ('Nômades do Ar', '');

INSERT INTO cidade(nome, descricao, nivel_necessario_entrar, nacao)
VALUES
    ('Tribo da Água do Sul', '', 1, 'Tribos da Água'),
    ('Templo do Ar do Sul', '', 1, 'Nômades do Ar'),
    ('Ilha Kyoshi', '', 1, 'Reino da Terra'),
    ('Omashu', '', 1, 'Reino da Terra'),
    ('Região de Floresta', '', 1, 'Reino da Terra'),
    ('Região Costeira', '', 1, 'Reino da Terra'),
    ('Templo do Ar do Norte', '', 1, 'Nômades do Ar'),
    ('Tribo da Água do Norte', '', 1, 'Tribos da Água'),
    ('Ba Sing Se', '', 23, 'Reino da Terra'),
    ('Capital da Nação do Fogo', '', 23, 'Nação do Fogo');
    
INSERT INTO area(id, nome, descricao, area_norte, area_sul, area_leste, area_oeste, cidade)
VALUES
    --  Região do Polo Sul
    (1, 'Centro da Cidade Portuária', '', 8, NULL, 2, 4, 'Tribo da Água do Sul'),
    (2, 'O Destroçado', '', NULL, NULL, NULL, 1, 'Tribo da Água do Sul'),
    (3, 'Ponto de Partida', 'Estamos nas nuvens, para onde vamos?', 14, 1, 9, NULL, 'Tribo da Água do Sul'),
    (4, 'Região Comercial', '', 5, 6, 1, 7, 'Tribo da Água do Sul'),
    (5, 'Mercador do Polo Sul', '', NULL, 4, NULL, NULL, 'Tribo da Água do Sul'),
    (6, 'Mestre do Polo Sul', '', 4, NULL, NULL, NULL, 'Tribo da Água do Sul'),
    (7, 'Curandeiro do Polo Sul', '', NULL, NULL, 4, NULL, 'Tribo da Água do Sul'),
    (8, 'Saída da Cidade Portuária', '', 3, 1, NULL, NULL, 'Tribo da Água do Sul'),
    (9, 'Entrada do Templo do Polo Sul', '', NULL, NULL, 10, 3, 'Tribo da Água do Sul'),
    (10, 'Centro do Templo do Ar do Sul', '', NULL, 12, 9, 11, 'Templo do Ar do Sul'),
    (11, 'Saída do Templo do Ar do Sul', '', NULL, NULL, 10, 3, 'Templo do Ar do Sul'),
    (12, 'Ruínas do Templo', '', 10, NULL, NULL, NULL, 'Templo do Ar do Sul'),

    --  Arredores e lugares do Reino da Terra
    (14, 'Entrada da Vila de Kyoshi', '', 15, 3, NULL, NULL, 'Ilha Kyoshi'),
    (15, 'Centro da Vila de Kyoshi', '', 21, 14, 16, 20, 'Ilha Kyoshi'),
    (16, 'Distrito Comercial', '', 17, 18, 19, 15, 'Ilha Kyoshi'),
    (17, 'Curandeira de Kyoshi', '', NULL, 16, NULL, NULL, 'Ilha Kyoshi'),
    (18, 'Mercadora de Kyoshi', '', 16, NULL, NULL, NULL, 'Ilha Kyoshi'),
    (19, 'Mestra de Kyoshi', '', NULL, NULL, NULL, 16, 'Ilha Kyoshi'),
    (20, 'Região Residencial', '', NULL, NULL, 20, NULL, 'Ilha Kyoshi'),
    (21, 'Centro de Omashu', '', 27, 15, 23, 22, 'Omashu'),
    (22, 'Palácio Real de Omashu', '', NULL, NULL, 21, NULL, 'Omashu'),
    (23, 'Zona de Comércio', '', 24, 25, 26, 21, 'Omashu'),
    (24, 'Mestre de Omashu', '', NULL, 23, NULL, NULL, 'Omashu'),
    (25, 'Curandeiro de Omashu', '', 23, NULL, NULL, NULL, 'Omashu'),
    (26, 'Mercador de Omashu', '', NULL, NULL, NULL, 23, 'Omashu'),
    (27, 'Centro da Floresta', '', 30, 21, 28, 29, 'Região de Floresta'),
    (28, 'Ponto de Acampamento', '', NULL, NULL, NULL, 27, 'Região de Floresta'),
    (29, 'Vilarejo da Floresta', '', NULL, NULL, 27, NULL, 'Região de Floresta'),
    (30, 'Praia da Preparação', '', 31, 30, NULL, NULL, 'Região Costeira'),
    (31, 'Barco Pirata', '', 32, 30, NULL, NULL, 'Região Costeira'),

    --  Região do Polo Norte
    (32, 'Centro do Templo do Ar do Norte', '', 34, 31, 33, NULL, 'Templo do Ar do Norte'),
    (33, 'Campo de Refugiados', '', NULL, NULL, NULL, 32, 'Templo do Ar do Norte'),
    (34, '1º Centro de Agna Qel''a', '', 35, 32, 36, 40, 'Tribo da Água do Norte'),
    (35, 'Palácio Real de Agna Qel''a', '', NULL, 35, NULL, NULL, 'Tribo da Água do Norte'),
    (36, 'Área de Comércio', '', 39, 38, 37, 34, 'Tribo da Água do Norte'),
    (37, 'Mercador de Agna Qel''a', '', NULL, NULL, NULL, 36, 'Tribo da Água do Norte'),
    (38, 'Curandeira de Agna Qel''a', '', 36, NULL, NULL, NULL, 'Tribo da Água do Norte'),
    (39, 'Mestre de Agna Qel''a', '', NULL, 36, NULL, NULL, 'Tribo da Água do Norte'),
    (40, '2º Centro de Agna Qel''a', '', 44, 41, 34, 42, 'Tribo da Água do Norte'),
    (41, 'Cabanas de Cura', '', 40, NULL, NULL, NULL, 'Tribo da Água do Norte'),
    (42, 'Tundras do Polo Norte', '', NULL, NULL, 40, 43, 'Tribo da Água do Norte'),
    (43, 'Selva Espiritual', '', NULL, NULL, 42, NULL, 'Tribo da Água do Norte'),
    (44, 'Cavernas de Gelo', '', 45, 40, NULL, NULL, 'Tribo da Água do Norte'),
    (45, 'Oásis Espiritual', '', NULL, 44, NULL, NULL, 'Tribo da Água do Norte');