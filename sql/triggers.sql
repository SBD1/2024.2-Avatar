-- Impede que o id de um personagem seja alterado manualmente
CREATE OR REPLACE FUNCTION control_personagem_id()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.id IS NOT NULL) THEN
    RAISE EXCEPTION 'O id do personagem não pode ser alterado manualmente';
    RETURN NULL;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER alter_pc
BEFORE UPDATE ON pc
FOR EACH ROW
EXECUTE PROCEDURE control_personagem_id();

CREATE TRIGGER alter_amigo
BEFORE UPDATE ON amigo
FOR EACH ROW
EXECUTE PROCEDURE control_personagem_id();

CREATE TRIGGER alter_inimigo
BEFORE UPDATE ON inimigo
FOR EACH ROW
EXECUTE PROCEDURE control_personagem_id();

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
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_pc
BEFORE INSERT ON pc
FOR EACH ROW
EXECUTE PROCEDURE create_pc();

CREATE OR REPLACE FUNCTION create_amigo()
RETURNS TRIGGER AS $$
BEGIN
  IF (NEW.id IS NOT NULL) THEN
    RAISE EXCEPTION 'O id do amigo não pode ser definido manualmente';
    RETURN NULL;
  END IF;

  INSERT INTO personagem(tipo) 
  VALUES ('A')
  RETURNING id INTO NEW.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_amigo
BEFORE INSERT ON amigo
FOR EACH ROW
EXECUTE PROCEDURE create_amigo();

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
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_inimigo
BEFORE INSERT ON inimigo
FOR EACH ROW
EXECUTE PROCEDURE create_inimigo();
