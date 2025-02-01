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