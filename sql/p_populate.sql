CREATE OR REPLACE PROCEDURE populate_database()
LANGUAGE plpgsql
AS $$
BEGIN

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

  -- Personagem Jogável (PC)

      -- FALTA: Adicionar itens
      INSERT INTO pc (nome, vida_max, vida_atual, xp, elemento, nivel, moedas, peso_max_inventario,
        id_area_atual, item_capacete, item_peitoral, item_acessorio, item_botas, item_arma) VALUES
      ('Aragorn', 200, 150, 500, 'fogo', 10, 100, 100.0, 1, NULL, NULL, NULL, NULL, NULL);


  -- Amigos (NPC)
      -- Mestre
      CALL criar_novo_amigo('Iroh', 250, 240, 600, 'fogo', 15, 
      'Bem-vindo, jovem aprendiz.', 'Que o fogo do seu espírito o guie.',
      1, -- id_area
      ARRAY[
        'O destino nos chama, jovem guerreiro.',
        'A sabedoria é o caminho para a vitória.',
        'A força do fogo é a força do espírito.'],
      TRUE, 5 -- eh_mestre, nivel_necessario_discipulo
      );

      CALL criar_novo_amigo('Toph', 180, 170, 550, 'terra', 12,
      'Sempre com os pés no chão, amigo.', 'Nos vemos por aí, pedra dura.',
      3,
       ARRAY[
        'Ser cega tem suas vantagens. Por exemplo, eu nunca tenho que olhar para caras como o Sokka se fazendo de engraçadinho.',
        'Cegueira? Ah, não é nada. A verdade é que eu sou tão boa que até o chão me diz o que fazer!',
        'Eu sou a melhor dobradora de terra que você vai conhecer.'],
      TRUE, 10
      );

      -- Mercador e Curandeira
      CALL criar_novo_amigo('Katara', 150, 100, 400, 'agua', 10,
      'Estou aqui para ajudar você.', 'Volte sempre, confie na sua força.',
      2,
      ARRAY[
        'Cuidado, os perigos estão por toda parte.',
        'A água é a fonte da vida, cuide dela.',
        'A cura é o caminho para a paz.'],
      FALSE, NULL,
      TRUE, 5, 1.5, -- eh_mercador, nivel_necessario_compra, mult_preco
      TRUE, 10      -- eh_curandeiro, preco_por_ponto_cura
      );


    -- NPC padrao
    CALL criar_novo_amigo('Zuko', 200, 200, 700, 'fogo', 14,
    'Estou aqui para lutar ao seu lado.', 'Até breve, que sua chama nunca se apague.',
    1,
    ARRAY[
      'Eu passei minha vida tentando provar meu valor. No fim, percebi que só eu poderia decidir quem realmente sou.',
      'A honra é algo que se conquista, não algo que se exige.',
      'Eu não sou muito bom com palavras... ou sentimentos... ou conversas... Quer saber? Esquece.',
      'Com a força do fogo, venceremos!']
    );


    -- INIMIGOS
    CALL criar_novo_inimigo('Orc', 150, 150, 100, 'terra', 5,
    'Prepare-se para enfrentar minha força!', 'Você pode ter vencido, mas isso não vai acabar aqui...',
    100, 10,
    1,
    ARRAY[
      'Você não é páreo para mim!',
      'Eu sou o mais forte!',
      'Você não tem chance!']
    );

    CALL criar_novo_inimigo('Golem', 250, 250, 200, 'fogo', 8,
    'Eu sou a rocha que você não pode quebrar.', 'Você pode ter me derrotado, mas não vai sobreviver ao que está por vir.',
    200, 20,
    2,
    ARRAY[
      'GRRRR (sons de labaredas)'
    ]
    );

    CALL criar_novo_inimigo('Dragão', 500, 500, 500, 'ar', 12,
    'Vocês não têm ideia do que estão enfrentando.', 'Vocês podem ter me vencido, mas a batalha ainda não acabou.',
    500, 50,
    3,
    ARRAY[
      'Ousa me desafiar, mortal?!',
      'Coloque-se em teu lugar, seu tolo!'
    ]
    );

  INSERT INTO ataque(nome, dano_causado, descricao, nivel_necessario_aprender, elemento) VALUES
      ('Chicote de Água', 10, 'Cria um chicote de água', 1, 'agua'),
      ('Sopro de Gelo', 5, 'Congela objetos e inimigos com sopro de ar frio', 2, 'agua'),
      ('Discos de Gelo', 10, 'Lança discos de gelo nos inimigos', 1, 'agua'),
      ('Garras de Gelo', 12, 'Cria garras cortantes de gelo', 2, 'agua'),
      ('Espinhos de Gelo', 18, 'Dispara espinhos afiados de gelo', 3, 'agua'),
      ('Espada de Gelo', 20, 'Forma uma espada com gelo', 4, 'agua'),
      ('Marionete', 40, 'Permite manipular os movimentos de organismos vivos', 5, 'agua'),

      ('Lançamento de Pedra', 5, 'Levita pedaços de pedras e lança contra inimigos', 1, 'terra'),
      ('Bloco de Terra', 10, 'Lanca blocos de terra contra inimigos', 1, 'terra'),
      ('Esmagamento da Terra', 5, 'Soco capaz de destruir rochas e pedregulhos', 3, 'terra'),
      ('Terremotos', 5, 'Cria terremotos no solo para desequilibrar oponentes e causar danos', 2, 'terra'),
      ('Bomba de Terra', 20, 'Enviar uma pedra ao solo para causar danos e lançar inimigos', 3, 'terra'),
      ('Balas de Rocha Compactada', 50, 'Disparar fragmentos de rocha com grande velocidade e dano', 5, 'terra'),
      ('Onda de Lava', 40, 'Cria uma onda de lava para causar danos', 4, 'terra'),
      ('Disco de Lava', 30, 'Cria um disco de lava para atacar', 4, 'terra'),
      ('Lançamento de Metal', 20, 'Levita pedaços de metal e lança contra inimigos', 4, 'terra'),

      ('Chute Ardente', 10, 'Corta o alvo com um arco de fogo', 1, 'fogo'),
      ('Lâmina de Fogo', 20, 'Cria lâminas finas de fogo para cortar objetos sem destruir-los completamente', 2, 'fogo'),
      ('Bomba de Fogo', 20, 'Em um curto alcance é possível criar uma explosão', 3, 'fogo'),
      ('Adaga de Fogo', 15, 'Cria uma chama muito concentrada para cortar com uma adaga', 2, 'fogo'),
      ('Chicote de Fogo', 10, 'Cria um chicote de fogo', 1, 'fogo'),
      ('Corrente de Fogo', 15, 'Dispara fluxo continuo de fogo com os punhos', 1, 'fogo'),
      ('Açoite de Fogo', 30, 'Cria um longo ataque de fogo e derruba sobre seus inimigos', 3, 'fogo'),
      ('Soco de Fogo', 15, 'Os socos produzem bolas de fogo em miniatura', 1, 'fogo'),
      ('Cometa de Fogo', 40, 'Presiona o fogo em uma bola e atira para o inimigo', 4, 'fogo'),
      ('Míssil de Fogo', 35, 'Cria um míssil de fogo que segue o alvo', 4, 'fogo'),
      ('Raio', 60, 'Atira um raio nos inimigos', 4, 'fogo'),
      ('Explosão Mental', 50, 'Cria um feixe poderoso que explode após contato com uma superfície sólida', 4, 'fogo'),

      ('Jato de Ar', 20, 'Cria um jato de ar capaz de empurrar ou explodir rochas', 1, 'ar'),
      ('Bomba de Ar', 10, 'Cria uma poderosa corrente de ar para fora em todas as direções ao redor do Dobrador', 2, 'ar'),
      ('Soco de Ar', 10, 'Comprime o ar que pode ser arremessado aos pés ou aos punhos', 1, 'ar'),
      ('Sopro de Ar', 20, 'Gera um jato de ar com a boca', 2, 'ar'),
      ('Lâmina de Ar', 20, 'Cria lâminas finas de ar para cortar objetos sem destruir-los completamente', 3, 'ar'),
      ('Esteira de Ar', 20, 'Dispara uma rajada de ar altamente comprimido em forma do corpo do dobrador', 3, 'ar'),
      ('Asfixia', 60, 'Cria uma bola de ar em torno da cabeça para matar o alvo', 4, 'ar'),
      ('Vendaval', 20, 'Desencadea ventos extremamente poderosos', 5, 'ar'),
      ('Furacão', 30, 'Cria uma furação', 5, 'ar'),

      ('Ataque de Espada', 10, 'Golpeia o alvo com uma espada', 1, 'nenhum'),
      ('Lançamento de Bumerangue', 5, 'Lanca um bumerangue no inimigo', 1, 'nenhum');

  INSERT INTO defesa(nome, dano_bloqueado, descricao, nivel_necessario_aprender, elemento) VALUES
      ('Escudo de Gelo', 10, 'Cria um escudo defensivo de gelo', 2, 'agua'),
      ('Equilibrio Espiritual', 25, 'Entra em harmonia com a água e seu espírito, formando uma barreira fluida que envolve seu corpo. Essa defesa mística absorve impactos e dissipa ataques.', 5, 'agua'),

      ('Escudo de Rocha', 10, 'Cria um escudo defensivo com rochas', 2, 'terra'),
      ('Coluna da Terra', 10, 'Cria colunas de rocha para se defender', 2, 'terra'),
      ('Armadura de Rocha', 15, 'Se envolve em uma armadura feita de rocha', 2, 'terra'),
      ('Armadura de Terra Aprimorada', 40, 'Criar um gigantesco corpo de rocha antropomórfica para combate', 5, 'terra'),
      ('Escudo de Metal', 30, 'Cria um escudo defensivo de metal', 4, 'terra'),

      ('Escudo de Fogo', 10, 'Cria um escudo protetor de fogo', 2, 'fogo'),
      ('Bloqueio de Fogo', 5, 'Desarmar e extinguir uma explosão de fogo de outro dobrador de fogo', 2, 'fogo'),

      ('Escudo de Ar', 10, 'Cria um escudo defensivo de ar', 2, 'ar');

  INSERT INTO mobilidade(nome, chance_esquiva, descricao, nivel_necessario_aprender, elemento) VALUES
      ('Tornado de Agua', 20, 'Cria um tornado para movimentação', 2, 'agua'),
      ('Rampa de Gelo', 5, 'Cria rampas de gelo para movimentação ou defesa', 2, 'agua'),
      ('Corrida na Água', 30, 'Permite de correr sobre a Água em alta velocidade', 2, 'agua'),

      ('Tornado de Areia', 20, 'Manipular areia para formar uma coluna giratória para o transporte', 3, 'terra'),
      ('Redemoinho de Poeira', 40, 'Criar redemoinhos de poeira para flutuar ou atacar', 5, 'terra'),
      ('Túnel da Terra', 5, 'Mover-se através da terra criando túneis', 3, 'terra'),
      ('Onda da Terra', 30, 'Criar ondas de terra onde o dobrador pode surfar', 3, 'terra'),
      ('Magnetização', 5, 'Magnetizar membros para escalar paredes rochosas', 3, 'terra'),
      ('Escalada de Poeira', 20, 'Criar pilares finos de tamanho crescente para escalar paredes', 3, 'terra'),
      ('Impulso de areia', 10, 'Cria um impulso de areia para atacar', 3, 'terra'),

      ('Pés Propulsores', 30, 'Cria pequenos jatos de fogo nos pés do dobrador permitindo que ele voe', 4, 'fogo'),

      ('Tornado de Ar', 20, 'Cria um tornado para movimentação', 3, 'ar'),
      ('Roda de Ar', 10, 'Cria uma roda de ar para movimentação rápida', 2, 'ar'),
      ('Esfera de Ar', 20, 'Cria uma esfera de ar para movimentação rápida', 5, 'ar'),
      ('Patinete Aéreo', 30, 'Cria um bola de ar que pode ser montada como se fosse um pião', 2, 'ar'),
      ('Vôo', 50, 'Permite o Dobrador voar', 5, 'ar');

  INSERT INTO cura(nome, pontos_cura, descricao, nivel_necessario_aprender, elemento) VALUES
      ('Cura Simples', 10, 'Habilidade de curar pequenos ferimentos usando água', 2, 'agua'),
      ('Cura Aprimorada', 50, 'Habilidade de curar grandes ferimentos usando água', 2, 'agua');


  INSERT INTO pergaminho(id, nome, peso, preco, raridade, tecnica)
  VALUES
      -- Pergaminhos de Água
        (1, 'Pergaminho do Gelo Cortante', 1.0, 30, 'comum', 'Discos de Gelo'),
        (2, 'Pergaminho do Gelo Perfurante', 1.0, 130, 'epico', 'Espinhos de Gelo'),
        (3, 'Pergaminho da Água Espiritual', 1.0, 130, 'epico', 'Equilibrio Espiritual'),
        (4, 'Pergaminho de Sangue', 1.0, 220, 'lendario', 'Marionete'),
        (5, 'Pergaminho da Tensão Superficial', 1.0, 70, 'raro', 'Corrida na Água'),
        -- Pergaminhos de Terra
        (6, 'Pergaminho de Impacto de Terra', 1.0, 30, 'comum', 'Bloco de Terra'),
        (7, 'Pergaminho de Defesa Rochosa', 1.0, 70, 'raro', 'Escudo de Rocha'),
        (8, 'Pergaminho de Artilharia Rochosa', 1.0, 220, 'lendario', 'Balas de Rocha Compactada'),
        (9, 'Pergaminho de Lava', 1.0, 130, 'epico', 'Disco de Lava'),
        (10, 'Pergaminho de Defesa Metálica', 1.0, 130, 'epico', 'Escudo de Metal'),
        -- Pergaminhos de Fogo
        (11, 'Pergaminho de Fogo Marcial', 1.0, 30, 'comum', 'Soco de Fogo'),
        (12, 'Pergaminho de Fogo Cortante', 1.0, 70, 'raro', 'Adaga de Fogo'),
        (13, 'Pergaminho de Astrologia Ofensiva', 1.0, 130, 'epico', 'Cometa de Fogo'),
        (14, 'Pergaminho de Relâmpago', 1.0, 220, 'lendario', 'Raio'),
        (15, 'Pergaminho de Combustão', 1.0, 130, 'epico', 'Explosão Mental'),
        -- Pergaminhos de Ar
        (16, 'Pergaminho de Ar Condensado', 1.0, 30, 'comum', 'Jato de Ar'),
        (17, 'Pergaminho de Ventos Protetivos', 1.0, 70, 'raro', 'Escudo de Ar'),
        (18, 'Pergaminho de Asfixia', 1.0, 220, 'lendario', 'Asfixia'),
        (19, 'Pergaminho dos Pés Leves', 1.0, 130, 'epico', 'Pés Propulsores'),
        (20, 'Pergaminho de Ventos Selvagens', 1.0, 130, 'epico', 'Furacão');

  INSERT INTO pocao(id, nome, peso, preco, pontos_cura)
  VALUES
      (21, 'Poção Inferior', 1.0, 5, 10),
      (22, 'Poção Básica', 1.0, 10, 25),
      (23, 'Poção Intermediária', 1.0, 20, 60),
      (24, 'Poção Avançada', 1.0, 50, 180),
      (25, 'Poção Superior', 1.0, 100, 400);

  INSERT INTO arma(id, nome, peso, preco, dano)
  VALUES
      (26, 'Lança de Pedra', 5.0, 15, 10),
      (27, 'Adaga de Latão', 3.5, 30, 15),
      (28, 'Machado de Alumínio', 6.5, 60, 25),
      (29, 'Espada de Cobre', 5.5, 80, 40),
      (30, 'Cajado de Bronze', 7.5, 110, 60),
      (31, 'Rapieira de Prata', 6.0, 150, 75),
      (32, 'Espada de Ouro', 7.0, 230, 100),
      (33, 'Gládio de Platina', 8.0, 320, 135),
      (34, 'Lança de Titânio', 10.0, 450, 180),
      (35, 'Cajado dos Elementos', 11.5, 700, 250);

  INSERT INTO armadura(id, nome, peso, preco, pontos_protecao, parte_corpo)
  VALUES
      -- capacete
      (36, 'Capacete de Couro', 2.5, 20, 4, 'capacete'),
      (37, 'Balde de Latão', 4.0, 50, 6, 'capacete'),
      (38, 'Capacete de Prata', 5.5, 100, 9, 'capacete'),
      (39, 'Visor de Platina', 6.0, 190, 13, 'capacete'),
      (40, 'Coroa dos Elementos', 1.5, 400, 18, 'capacete'),
      -- peitoral
      (41, 'Peitoral de Couro', 7.0, 25, 6, 'peitoral'),
      (42, 'Ombreiras de Latão', 9.5, 65, 9, 'peitoral'),
      (43, 'Cota de Malha Prateada', 8.0, 120, 13, 'peitoral'),
      (44, 'Peitoral de Platina', 12.0, 225, 18, 'peitoral'),
      (45, 'Manto dos Elementos', 3.5, 500, 24, 'peitoral'),
      -- acessorio
      (46, 'Braceletes de Couro', 1.0, 15, 2, 'acessorio'),
      (47, 'Anel de Latão', 0.5, 35, 5, 'acessorio'),
      (48, 'Brincos de Prata', 0.5, 75, 8, 'acessorio'),
      (49, 'Anel de Platina', 0.5, 160, 11, 'acessorio'),
      (50, 'Braceletes dos Elementos', 1.0, 350, 15, 'acessorio'),
      -- botas
      (51, 'Perneiras de Couro', 3.5, 20, 4, 'botas'),
      (52, 'Sabaton de Latão', 4.0, 50, 6, 'botas'),
      (53, 'Botas de Prata', 5.5, 100, 9, 'botas'),
      (54, 'Perneiras de Platina', 8.0, 190, 13, 'botas'),
      (55, 'Botas dos Elementos', 2.0, 400, 18, 'botas');

      -- Proteção das Armaduras por Nível (os 4 slots juntos):
          -- Couro -> 16
          -- Latão -> 26
          -- Prata -> 39
          -- Platina -> 55
          -- Elementos -> 75


  INSERT INTO instancia_item (id_item, id_pc, id_inimigo, id_mercador) VALUES
    -- Personagem com item
    (1, 1, NULL, NULL), -- Pergaminho do Gelo Cortante para o personagem com id 1
    (2, 1, NULL, NULL), -- Pergaminho do Gelo Perfurante para o personagem com id 1
    (3, NULL, 7, NULL), -- Pergaminho da Água Espiritual para inimigo com id 8
    (4, NULL, 8, NULL), -- Pergaminho de Sangue para inimigo com id 9
    (5, NULL, NULL, 4), -- Poção Inferior para mercador com id 3
    (6, 1, NULL, NULL), -- Pergaminho de Impacto de Terra para o personagem com id 1
    (7, NULL, 7, NULL), -- Pergaminho de Defesa Rochosa para inimigo com id 7
    (22, 1, NULL, NULL), -- Poção Básica para o personagem com id 1
    (24, 1, NULL, NULL), -- Poção Avançada para o personagem com id 1
    (29, 1, NULL, NULL), -- Espada de Cobre para o personagem com id 1
    (37, 1, NULL, NULL), -- Balde de Latão para o personagem com id 1
    (41, 1, NULL, NULL), -- Peitoral de Couro para o personagem com id 1
    (1, NULL, NULL, NULL),  -- Pergaminho do Gelo Cortante na área 1
    (2, NULL, NULL, NULL),  -- Pergaminho do Gelo Perfurante na área 2
    (3, NULL, NULL, NULL),  -- Pergaminho da Água Espiritual na área 1
    (4, NULL, NULL, NULL),  -- Pergaminho de Sangue na área 3
    (21, NULL, NULL, NULL),  -- Poção Inferior na área 2
    (6, NULL, NULL, NULL),  -- Pergaminho de Impacto de Terra na área 3
    (7, NULL, NULL, NULL),  -- Pergaminho de Defesa Rochosa na área 1
    (9, NULL, NULL, 4);  -- Pergaminho da Lava para mercador com id 3

  INSERT INTO contem_item (id_instancia_item, id_area) VALUES
      (13, 1),  -- Pergaminho do Gelo Cortante na área 1
      (14, 2),  -- Pergaminho do Gelo Perfurante na área 2
      (15, 1),  -- Pergaminho da Água Espiritual na área 1
      (16, 3),  -- Pergaminho de Sangue na área 3
      (17, 2),  -- Poção Inferior na área 2
      (18, 3),  -- Pergaminho de Impacto de Terra na área 3
      (19, 1);  -- Pergaminho de Defesa Rochosa na área 1


  INSERT INTO sabe_tecnica (id_personagem, nome_tecnica) VALUES
      -- Personagem 1
      (1, 'Chicote de Água'),
      (1, 'Sopro de Gelo'),
      (1, 'Discos de Gelo'),
      (1, 'Garras de Gelo'),
      (1, 'Escudo de Gelo'),
      
      -- Personagem 2
      (5, 'Lançamento de Pedra'),
      (5, 'Bloco de Terra'),
      (5, 'Esmagamento da Terra'),
      (5, 'Escudo de Rocha'),
      (5, 'Coluna da Terra'),
      
      -- Personagem 3
      (3, 'Chute Ardente'),
      (3, 'Lâmina de Fogo'),
      (3, 'Bomba de Fogo'),
      (3, 'Escudo de Fogo'),
      (3, 'Bloqueio de Fogo'),
      
      -- Personagem 4
      (4, 'Jato de Ar'),
      (4, 'Bomba de Ar'),
      (4, 'Soco de Ar'),
      (4, 'Escudo de Ar'),
      (4, 'Tornado de Ar');

END;
$$;
