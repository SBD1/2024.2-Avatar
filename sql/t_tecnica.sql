CREATE OR REPLACE FUNCTION insert_tecnica() RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'ataque' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'A');
    ELSIF TG_TABLE_NAME = 'defesa' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'D');
    ELSIF TG_TABLE_NAME = 'mobilidade' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'M');
    ELSIF TG_TABLE_NAME = 'cura' THEN
        INSERT INTO tecnica (nome, tipo) VALUES (NEW.nome, 'C');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_tecnica_ataque_trigger
AFTER INSERT ON ataque
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();

CREATE TRIGGER insert_tecnica_defesa_trigger
AFTER INSERT ON defesa
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();

CREATE TRIGGER insert_tecnica_mobilidade_trigger
AFTER INSERT ON mobilidade
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();

CREATE TRIGGER insert_tecnica_cura_trigger
AFTER INSERT ON cura
FOR EACH ROW
EXECUTE PROCEDURE insert_tecnica();


CREATE OR REPLACE FUNCTION delete_tecnica() RETURNS TRIGGER AS $$
BEGIN   
    DELETE FROM tecnica WHERE nome = OLD.nome;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_tecnica_ataque_trigger
AFTER DELETE ON ataque
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE TRIGGER delete_tecnica_defesa_trigger
AFTER DELETE ON defesa
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE TRIGGER delete_tecnica_mobilidade_trigger
AFTER DELETE ON mobilidade
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE TRIGGER delete_tecnica_cura_trigger
AFTER DELETE ON cura
FOR EACH ROW
EXECUTE PROCEDURE delete_tecnica();

CREATE OR REPLACE FUNCTION update_tecnica() RETURNS TRIGGER AS $$
BEGIN
    IF OLD.nome <> NEW.nome THEN
        UPDATE tecnica SET nome = NEW.nome WHERE nome = OLD.nome;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_tecnica_ataque_trigger
BEFORE UPDATE ON ataque
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();

CREATE TRIGGER update_tecnica_defesa_trigger
BEFORE UPDATE ON defesa
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();

CREATE TRIGGER update_tecnica_mobilidade_trigger
BEFORE UPDATE ON mobilidade
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();

CREATE TRIGGER update_tecnica_cura_trigger
BEFORE UPDATE ON cura
FOR EACH ROW
EXECUTE PROCEDURE update_tecnica();