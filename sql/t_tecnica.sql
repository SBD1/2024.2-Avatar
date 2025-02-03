CREATE OR REPLACE FUNCTION insert_tecnica() RETURNS TRIGGER as $$
BEGIN
    IF TG_TABLE_NAME = 'ataque' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'A');
    ELSE IF TG_TABLE_NAME = 'defesa' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'D');
    ELSE IF TG_TABLE_NAME = 'mobilidade' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'M');
    ELSE IF TG_TABLE_NAME = 'cura' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'C');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_tecnica
AFTER INSERT ON ataque
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();

CREATE TRIGGER insert_tecnica
AFTER INSERT ON defesa
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();

CREATE TRIGGER insert_tecnica
AFTER INSERT ON mobilidade
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();

CREATE TRIGGER insert_tecnica
AFTER INSERT ON cura
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();


CREATE OR REPLACE FUNCTION delete_tecnica() RETURNS TRIGGER as $$
BEGIN   
    DELETE FROM tecnica WHERE nome = OLD.nome;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_tecnica
AFTER DELETE ON ataque
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE TRIGGER delete_tecnica
AFTER DELETE ON defesa
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE TRIGGER delete_tecnica
AFTER DELETE ON mobilidade
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE TRIGGER delete_tecnica
AFTER DELETE ON cura
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();


CREATE OR REPLACE FUNCTION update_tecnica() RETURNS TRIGGER as $$
BEGIN
    UPDATE tecnica SET nome = NEW.nome;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_tecnica
AFTER UPDATE ON ataque
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();

CREATE TRIGGER update_tecnica
AFTER UPDATE ON defesa
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();

CREATE TRIGGER update_tecnica
AFTER UPDATE ON mobilidade
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica(); 

CREATE TRIGGER update_tecnica
AFTER UPDATE ON cura
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();