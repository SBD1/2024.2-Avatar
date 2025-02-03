-- Quando um inimigo derrotado é derrotado o player ganha xp e moedas
CREATE OR REPLACE FUNCTION inimigo_derrotado(id_pc INT, id_inimigo INT)
RETURNS VOID AS $$
BEGIN
    UPDATE pc SET xp = xp + xp_ganho, moedas = moedas + num_moedas_ganho WHERE id = id_pc;
    DELETE FROM inimigo WHERE id = id_inimigo;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER inimigo_derrotado_trigger
AFTER INSERT ON combate
FOR EACH ROW
EXECUTE PROCEDURE inimigo_derrotado(:NEW.id_pc, :NEW.id_inimigo);