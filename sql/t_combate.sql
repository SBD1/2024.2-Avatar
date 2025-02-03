-- Quando um inimigo derrotado é derrotado o player ganha xp e moedas
CREATE OR REPLACE FUNCTION inimigo_derrotado()
RETURNS TRIGGER AS $$
DECLARE
  p_xp_ganho INT;
  p_num_moedas_ganho INT;
BEGIN
  IF (NEW.id_pc = NEW.id_vencedor) THEN
    SELECT xp_ganho, num_moedas_ganho INTO p_xp_ganho, p_num_moedas_ganho 
    FROM inimigo WHERE id = NEW.id_inimigo;

    UPDATE pc 
    SET xp = xp + p_xp_ganho, 
    moedas = moedas + p_num_moedas_ganho 
    WHERE id = NEW.id_pc;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER inimigo_derrotado_trigger
AFTER INSERT ON combate
FOR EACH ROW
EXECUTE PROCEDURE inimigo_derrotado();