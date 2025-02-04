CREATE OR REPLACE FUNCTION insert_item() RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'arma' THEN
        INSERT INTO item (nome, tipo) VALUES (NEW.nome, 'W');
    ELSIF TG_TABLE_NAME = 'armadura' THEN
        INSERT INTO item (nome, tipo) VALUES (NEW.nome, 'A');
    ELSIF TG_TABLE_NAME = 'pocao' THEN
        INSERT INTO item (nome, tipo) VALUES (NEW.nome, 'P');
    ELSIF TG_TABLE_NAME = 'pergaminho' THEN
        INSERT INTO item (nome, tipo) VALUES (NEW.nome, 'S');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_arma_trigger
BEFORE INSERT ON arma
FOR EACH ROW
EXECUTE PROCEDURE insert_item();

CREATE TRIGGER insert_armadura_trigger
BEFORE INSERT ON armadura
FOR EACH ROW
EXECUTE PROCEDURE insert_item();

CREATE TRIGGER insert_pocao_trigger
BEFORE INSERT ON pocao
FOR EACH ROW
EXECUTE PROCEDURE insert_item();

CREATE TRIGGER insert_pergaminho_trigger
BEFORE INSERT ON pergaminho
FOR EACH ROW
EXECUTE PROCEDURE insert_item();

CREATE OR REPLACE FUNCTION delete_item() RETURNS TRIGGER AS $$
BEGIN   
    DELETE FROM item WHERE id = OLD.id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_arma_trigger
AFTER DELETE ON arma
FOR EACH ROW
EXECUTE PROCEDURE delete_item();

CREATE TRIGGER delete_armadura_trigger
AFTER DELETE ON armadura
FOR EACH ROW
EXECUTE PROCEDURE delete_item();

CREATE TRIGGER delete_pocao_trigger
AFTER DELETE ON pocao
FOR EACH ROW
EXECUTE PROCEDURE delete_item();

CREATE TRIGGER delete_pergaminho_trigger
AFTER DELETE ON pergaminho
FOR EACH ROW
EXECUTE PROCEDURE delete_item();

CREATE OR REPLACE FUNCTION update_item() RETURNS TRIGGER AS $$
BEGIN
    IF OLD.id <> NEW.id THEN
        RAISE EXCEPTION 'Não é permitido alterar o ID do item.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_arma_trigger
BEFORE UPDATE ON arma
FOR EACH ROW
EXECUTE PROCEDURE update_item();

CREATE TRIGGER update_armadura_trigger
BEFORE UPDATE ON armadura
FOR EACH ROW
EXECUTE PROCEDURE update_item();

CREATE TRIGGER update_pocao_trigger
BEFORE UPDATE ON pocao
FOR EACH ROW
EXECUTE PROCEDURE update_item();

CREATE TRIGGER update_pergaminho_trigger
BEFORE UPDATE ON pergaminho
FOR EACH ROW
EXECUTE PROCEDURE update_item();