CREATE OR REPLACE PROCEDURE criar_novo_amigo(
    p_nome VARCHAR,
    p_vida_max INT,
    p_vida_atual INT,
    p_xp INT,
    p_elemento ENUM_ELEMENTO,
    p_fala_entrada VARCHAR,
    p_fala_saida VARCHAR,
    p_id_area INT,
    p_dialogos TEXT[] DEFAULT NULL,
    p_eh_mestre BOOLEAN DEFAULT FALSE,
    p_nivel_necessario_discipulo INT DEFAULT NULL,
    p_eh_mercador BOOLEAN DEFAULT FALSE,
    p_nivel_necessario_compra INT DEFAULT NULL,
    p_mult_preco NUMERIC DEFAULT NULL,
    p_eh_curandeiro BOOLEAN DEFAULT FALSE,
    p_preco_por_ponto_cura NUMERIC DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    amigo_id INT;
    dialogo TEXT;
BEGIN
    -- Inserir o amigo e obter o id gerado
    INSERT INTO amigo (nome, vida_max, vida_atual, xp, elemento,
                       fala_entrada, fala_saida,
                       eh_mestre, nivel_necessario_discipulo,
                       eh_mercador, nivel_necessario_compra, mult_preco,
                       eh_curandeiro, preco_por_ponto_cura, 
                       id_area)
    VALUES (p_nome, p_vida_max, p_vida_atual, p_xp, p_elemento, 
            p_fala_entrada, p_fala_saida, 
            p_eh_mestre, p_nivel_necessario_discipulo, 
            p_eh_mercador, p_nivel_necessario_compra, p_mult_preco,
            p_eh_curandeiro, p_preco_por_ponto_cura, 
            p_id_area)
    RETURNING id INTO amigo_id;

    -- Verificar se o array de diálogos não é NULL e iterar sobre ele para inserir cada fala
    IF p_dialogos IS NOT NULL THEN
        FOREACH dialogo IN ARRAY p_dialogos
        LOOP
            INSERT INTO fala_historia (dialogo, id_amigo) VALUES (dialogo, amigo_id);
        END LOOP;
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE criar_novo_inimigo(
  p_nome VARCHAR,
  p_vida_max INT,
  p_vida_atual INT,
  p_xp INT,
  p_elemento ENUM_ELEMENTO,
  p_fala_entrada VARCHAR,
  p_fala_saida VARCHAR,
  p_xp_ganho INT,
  p_num_moedas_ganho INT,
  p_id_area INT,
  p_dialogos TEXT[] DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
  inimigo_id INT;
  dialogo TEXT;
BEGIN
  -- Inserir o inimigo e obter o id gerado
  INSERT INTO inimigo (nome, vida_max, vida_atual, xp, elemento, 
                       fala_entrada, fala_saida, 
                       xp_ganho, num_moedas_ganho, 
                       id_area)
  VALUES (p_nome, p_vida_max, p_vida_atual, p_xp, p_elemento,
      p_fala_entrada, p_fala_saida, 
      p_xp_ganho, p_num_moedas_ganho,
      p_id_area)
  RETURNING id INTO inimigo_id;

  -- Verificar se o array de diálogos não é NULL e iterar sobre ele para inserir cada fala
  IF p_dialogos IS NOT NULL THEN
    FOREACH dialogo IN ARRAY p_dialogos
    LOOP
      INSERT INTO fala_combate (dialogo, id_inimigo) VALUES (dialogo, inimigo_id);
    END LOOP;
  END IF;
END;
$$;
