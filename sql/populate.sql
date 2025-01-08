INSERT INTO dobra(nome, mult_dano)
VALUES
    ('Água', 1.1),
    ('Terra', 1.1),
    ('Fogo', 1.1),
    ('Ar', 1.1),
    ('Energia', 1.5);

INSERT INTO subdobra(nome, mult_dano, dobra)
VALUES
    ('Cura', 1, 'Água'),
    ('Sangue', 1, 'Água'),
    ('Espíritos', 1, 'Água'),
    ('Lava', 1, 'Terra'), 
    ('Areia', 1, 'Terra'),
    ('Metal', 1, 'Terra'),
    ('Raio', 1, 'Fogo'),
    ('Combustão', 1, 'Fogo'),
    ('Redirecionamento', 1, 'Fogo'),
    ('Projeção espiritual', 1, 'Ar'),
    ('Regulação de temperatura', 1, 'Ar'),
    ('Vôo', 1, 'Ar');

INSERT INTO movimento(nome, dano, descricao, nivel_necessario_aprender, tipo, dobra, subdobra)
VALUES
    -- Movimentos de Água
    ('Chicote de Água', 10, 'Cria um chicote de água', 1, 'dobra', 'Água', NULL),
    ('Discos de Gelo', 10, 'Lança discos de gelo nos inimigos', 1, 'dobra', 'Água', NULL),
    ('Sopro de Gelo', 5, 'Congela objetos e inimigos com sopro de ar frio', 2, 'dobra', 'Água', NULL),
    ('Escudo de Gelo', 0, 'Cria um escudo defensivo de gelo', 3, 'dobra', 'Água', NULL),
    ('Garras de Gelo', 12, 'Cria garras cortantes de gelo', 2, 'dobra', 'Água', NULL),
    ('Espinhos de Gelo', 18, 'Dispara espinhos afiados de gelo', 3, 'dobra', 'Água', NULL),
    ('Espada de Gelo', 20, 'Forma uma espada com gelo', 4, 'dobra', 'Água', NULL),
    ('Tornado de Agua', 0, 'Cria um tornado para movimentação', 2, 'dobra', 'Água', NULL),
    ('Rampa de Gelo', 0, 'Cria rampas de gelo para movimentação ou defesa', 2, 'dobra', 'Água', NULL),
    ('Marionete', 40, 'Permite manipular os movimentos de organismos vivos', 5, 'dobra', 'Água', 'Sangue'),
    ('Curar', 10, 'Habilidade de curar ferimentos usando água', 2, 'dobra', 'Água', 'Cura'),
    ('Equilibrio Espiritual', 0, 'Induz a mudança entre as energias positiva e negativa em espiritos', 3, 'dobra', 'Água', 'Espíritos'),
    ('Corrida na Água', 0, 'Permite de correr sobre a Água em alta velocidade', 2, 'dobra', 'Água', NULL),
    -- Movimentos de Terra
    ('Lançamento de Pedra', 5, 'Levita pedaços de pedras e lança contra inimigos', 1, 'dobra', 'Terra', NULL),
    ('Bloco de Terra', 10, 'Lanca blocos de terra contra inimigos', 1, 'dobra', 'Terra', NULL),
    ('Coluna da Terra', 0, 'Cria colunas de rocha para se defender', 2, 'dobra', 'Terra', NULL),
    ('Compressão da Terra', 0, 'Comprime grandes pedaços de rocha em formas menores e mais densas', 3, 'dobra', 'Terra', NULL),
    ('Mão ou Corpo de Terra', 10, 'Cria réplicas parciais ou totais de corpos humanos e movê-los', 2, 'dobra', 'Terra', NULL),
    ('Naufrágio de Terra', 0, 'Dobra a terra para afundar inimigos ou criar abrigos', 3, 'dobra', 'Terra', NULL),
    ('Esmagamento da Terra', 0, 'Destroí-e rochas e pedregulhos com socos e pontapés', 3, 'dobra', 'Terra', NULL),
    ('Terremotos', 5, 'Cria terremotos no solo para desequilibrar oponentes e causar danos', 2, 'dobra', 'Terra', NULL),
    ('Mover o Solo', 0, 'Alterar o solo para afastar ou desorientar o alvo', 2, 'dobra', 'Terra', NULL),
    ('Areia Movediça', 0, 'Transformar superfícies em areia movediça para imobilizar ou suavizar quedas', 3, 'dobra', 'Terra', NULL),
    ('Algemas de Pedra', 0, 'Cria algemas de pedra para imobilizar inimigos', 2, 'dobra', 'Terra', NULL),
    ('Escudo de Rocha', 0, 'Cria escudos de rocha para defesa ou ataque', 2, 'dobra', 'Terra', NULL),
    ('Escorregador', 0, 'Cria deslizamentos de rochas para atacar ou redirecionar ataques', 3, 'dobra', 'Terra', NULL),
    ('Tornado de Areia', 0, 'Manipular areia para formar uma coluna giratória para o transporte', 3, 'dobra', 'Terra', 'Areia'),
    ('Armadura de Rocha', 0, 'Cria armaduras de rocha para defesa ou ataque', 2, 'dobra', 'Terra', NULL),
    ('Bomba de Terra', 20, 'Enviar uma pedra ao solo para causar danos e lançar inimigos', 3, 'dobra', 'Terra', NULL),
    ('Túnel da Terra', 0, 'Mover-se através da terra criando túneis', 3, 'dobra', 'Terra', NULL),
    ('Onda da Terra', 0, 'Criar ondas de terra para transporte ou como ataque poderoso', 3, 'dobra', 'Terra', NULL),
    ('Magnetização', 0, 'Magnetizar membros para escalar paredes rochosas', 3, 'dobra', 'Terra', NULL),
    ('Balas de Rocha Compactada', 50, 'Disparar fragmentos de rocha com grande velocidade e dano', 5, 'dobra', 'Terra', NULL),
    ('Redemoinho de Poeira', 0, 'Criar redemoinhos de poeira para flutuar ou atacar', 5, 'dobra', 'Terra', NULL),
    ('Armadura de Terra Aprimorada', 0, 'Criar um gigantesco corpo de rocha antropomórfica para combate', 5, 'dobra', 'Terra', NULL),
    ('Levitação da Terra Aprimorada', 0, 'Mover estátuas do tamanho de uma colina', 5, 'dobra', 'Terra', NULL),
    ('Escalada de Poeira', 0, 'Criar pilares finos de tamanho crescente para escalar paredes', 3, 'dobra', 'Terra', NULL),
    ('Detecção de Mentiras', 0, 'Permite perceber as mais leves alterações dos comportamentos das pessoas', 3, 'dobra', 'Terra', NULL),
    ('Onda de Lava', 40, 'Cria uma onda de lava para causar danos', 4, 'dobra', 'Terra', 'Lava'),
    ('Disco de Lava', 30, 'Cria um disco de lava para atacar', 4, 'dobra', 'Terra', 'Lava'),
    ('Sentido Sismico', 0, 'Permite enxergar o ambiente ao redor independente de sua visão', 4, 'dobra', 'Terra', NULL),
    ('Impulso de areia', 0, 'Cria um impulso de areia para atacar', 3, 'dobra', 'Terra', 'Areia'),
    ('Lançamento de Metal', 20, 'Levita pedaços de metal e lança contra inimigos', 4, 'dobra', 'Terra', NULL),
    ('Escudo de Metal', 0, 'Cria um escudo defensivo de metal', 4, 'dobra', 'Terra', 'Metal'),
    -- Movimentos de Fogo
    ('Chute Ardente', 10, 'Corta o alvo com um arco de fogo', 1, 'dobra', 'Fogo', NULL),
    ('Bloqueio de Fogo', 0, 'Desarmar e extinguir uma explosão de fogo de outro dobrador de fogo', 2, 'dobra', 'Fogo', NULL),
    ('Lâmina de Fogo', 20, 'Cria lâminas finas de fogo para cortar objetos sem destruir-los completamente', 2, 'dobra', 'Fogo', NULL),
    ('Bomba de Fogo', 20, 'Em um curto alcance é possível criar uma explosão', 3, 'dobra', 'Fogo', NULL),
    ('Circulo de Fogo', 5, 'Cria um círculo de fogo', 1, 'dobra', 'Fogo', NULL),
    ('Adaga de Fogo', 15, 'Cria uma chama muito concentrada para cortar com uma adaga', 2, 'dobra', 'Fogo', NULL),
    ('Chicote de Fogo', 10, 'Cria um chicote de fogo', 1, 'dobra', 'Fogo', NULL),
    ('Corrente de Fogo', 15, 'Dispara fluxo continuo de fogo com os punhos', 1, 'dobra', 'Fogo', NULL),
    ('Açoite de Fogo', 30, 'Cria um longo ataque de fogo e derruba sobre seus inimigos', 3, 'dobra', 'Fogo', NULL),
    ('Soco de Fogo', 15, 'Os socos produzem bolas de fogo em miniatura', 1, 'dobra', 'Fogo', NULL),
    ('Escudo de Fogo', 0, 'Cria um escudo protetor de fogo', 4, 'dobra', 'Fogo', NULL),
    ('Cometa de Fogo', 40, 'Presiona o fogo em uma bola e atira para o inimigo', 4, 'dobra', 'Fogo', NULL),
    ('Míssil de Fogo', 35, 'Cria um míssil de fogo que segue o alvo', 4, 'dobra', 'Fogo', NULL),
    ('Lançar Raio', 60, 'Atira um raio nos inimigos', 4, 'dobra', 'Fogo', 'Raio'),
    ('Explosão Mental', 50, 'Cria um feixe poderoso que explode após contato com uma superfície sólida', 4, 'dobra', 'Fogo', 'Combustão'),
    -- Movimentos de Ar
    ('Bola de Ar', 5, 'Cria uma bola comprimida de ar ', 1, 'dobra', 'Ar', NULL),
    ('Jato de Ar', 20, 'Cria um jato de ar capaz de empurrar ou explodir rochas', 1, 'dobra', 'Ar', NULL),
    ('Bomba de Ar', 10, 'Cria uma poderosa corrente de ar para fora em todas as direções ao redor do Dobrador', 2, 'dobra', 'Ar', NULL),
    ('Almofada de Ar', 0, 'Cria uma almofada de ar para aparar a queda', 2, 'dobra', 'Ar', NULL),
    ('Funil de Ar', 5, 'Cria um pequeno funil de ar para lancar pequenos projéteis', 1, 'dobra', 'Ar', NULL),
    ('Soco de Ar', 10, 'Comprime o ar que pode ser arremessado aos pés ou aos punhos', 1, 'dobra', 'Ar', NULL),
    ('Escudo de Ar', 0, 'Cria um escudo defensivo de ar', 3, 'dobra', 'Ar', NULL),
    ('Roda de Ar', 0, 'Cria uma roda de ar para movimentação rápida', 2, 'dobra', 'Ar', NULL),
    ('Sopro de Ar', 20, 'Gera um jato de ar com a boca', 2, 'dobra', 'Ar', NULL),
    ('Sucção', 0, 'Cria uma sucção para trazer os alvos em direção ao Dobrador', 1, 'dobra', 'Ar', NULL),
    ('Lâmina de Ar', 20, 'Cria lâminas finas de ar para cortar objetos sem destruir-los completamente', 3, 'dobra', 'Ar', NULL),
    ('Casulo de Ar', 0, 'Cria um casulo de ar para movimentação rápida', 3, 'dobra', 'Ar', NULL),
    ('Tornado de Ar', 0, 'Cria um tornado para movimentação', 3, 'dobra', 'Ar', NULL),
    ('Esteira de Ar', 20, 'Dispara uma rajada de ar altamente comprimido em forma do corpo do dobrador', 3, 'dobra', 'Ar', NULL),
    ('Asfixia', 60, 'Cria uma bola de ar em torno da cabeça para matar o alvo', 4, 'dobra', 'Ar', NULL),
    ('Esfera de Ar', 0, 'Cria uma esfera de ar para movimentação rápida', 5, 'dobra', 'Ar', NULL),
    ('Vendaval', 20, 'Desencadea ventos extremamente poderosos', 5, 'dobra', 'Ar', NULL),
    ('Furacão', 30, 'Cria uma furação', 5, 'dobra', 'Ar', NULL),
    ('Patinete Aéreo', 0, 'Cria um bola de ar que pode ser montada como se fosse um pião', 2, 'dobra', 'Ar', NULL),
    ('Vôo', 0, 'Permite o Dobrador voar', 5, 'dobra', 'Ar', 'Vôo'),
    ('Planar', 0, 'Permite o Dobrador voar com o auxilio de um planador', 2, 'dobra', 'Ar', NULL),
    ('Projeção espiritual', 0, 'Permite o Dobrador projetar seu espírito em outro local', 5, 'dobra', 'Ar', 'Projeção espiritual'),
    -- Movimentos Normais
    ('Ataque de Espada', 10, 'Golpeia o alvo com uma espada', 1, 'golpe', NULL, NULL),
    ('Lançamento de Bumerangue', 5, 'Lanca um bumerangue no inimigo', 1, 'golpe', NULL, NULL);

INSERT INTO item(id, tipo)
VALUES
    -- Pergaminhos (S -> Scroll)
    (1, 'S'),
    (2, 'S'),
    (3, 'S'),
    (4, 'S'),
    (5, 'S'),
    (6, 'S'),
    (7, 'S'),
    (8, 'S'),
    (9, 'S'),
    (10, 'S'),
    (11, 'S'),
    (12, 'S'),
    (13, 'S'),
    (14, 'S'),
    (15, 'S'),
    (16, 'S'),
    (17, 'S'),
    (18, 'S'),
    (19, 'S'),
    (20, 'S'),
    -- Poções (P -> Potion)
    (21, 'P'),
    (22, 'P'),
    (23, 'P'),
    (24, 'P'),
    (25, 'P'),
    -- Arma (W -> Weapon)
    (26, 'W'),
    (27, 'W'),
    (28, 'W'),
    (29, 'W'),
    (30, 'W'),
    (31, 'W'),
    (32, 'W'),
    (33, 'W'),
    (34, 'W'),
    (35, 'W'),
    -- Armadura (A -> Armor)
    (36, 'A'),
    (37, 'A'),
    (38, 'A'),
    (39, 'A'),
    (40, 'A'),
    (41, 'A'),
    (42, 'A'),
    (43, 'A'),
    (44, 'A'),
    (45, 'A'),
    (46, 'A'),
    (47, 'A'),
    (48, 'A'),
    (49, 'A'),
    (50, 'A'),
    (51, 'A'),
    (52, 'A'),
    (53, 'A'),
    (54, 'A'),
    (55, 'A');

INSERT INTO pergaminho(id, nome, peso, preco, raridade, movimento)
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
      (14, 'Pergaminho de Relâmpago', 1.0, 220, 'lendario', 'Lançar Raio'),
      (15, 'Pergaminho de Combustão', 1.0, 130, 'epico', 'Explosão Mental'),
      -- Pergaminhos de Ar
      (16, 'Pergaminho de Ar Condensado', 1.0, 30, 'comum', 'Jato de Ar'),
      (17, 'Pergaminho de Ventos Protetivos', 1.0, 70, 'raro', 'Escudo de Ar'),
      (18, 'Pergaminho de Asfixia', 1.0, 220, 'lendario', 'Asfixia'),
      (19, 'Pergaminho de Ar Espiritual', 1.0, 130, 'epico', 'Projeção espiritual'),
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
