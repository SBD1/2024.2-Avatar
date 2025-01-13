USE Avatar;

INSERT INTO nacao(nome, descricao) VALUES
('Norte', 'Uma nação situada ao norte, conhecida por seu clima frio e montanhas imponentes.'),
('Sul', 'Uma nação tropical com vastas florestas e fauna diversificada.'),
('Leste', 'Uma nação rica em cultura e história, famosa por seus grandes templos.'),
('Oeste', 'Uma nação industrializada com grandes cidades e avanços tecnológicos.');

INSERT INTO cidade(nome, descricao, nivel_necessario_entrar, nacao) VALUES
('Aurora', 'Cidade localizada nas montanhas geladas da Nação do Norte.', 5, 'Norte'),
('Florestalis', 'Cidade tropical cercada por florestas densas na Nação do Sul.', 3, 'Sul'),
('Templicus', 'Cidade histórica repleta de templos antigos na Nação do Leste.', 7, 'Leste'),
('Techville', 'Cidade moderna e tecnológica na Nação do Oeste.', 2, 'Oeste');

INSERT INTO area(nome, descricao, area_norte, area_sul, area_leste, area_oeste, cidade) VALUES
('Pico Congelado', 'Uma área montanhosa coberta de neve eterna.', NULL, 2, NULL, NULL, 'Aurora'),
('Vale Gélido', 'Um vale entre montanhas, frequentemente nevado.', 1, NULL, NULL, NULL, 'Aurora'),
('Selva Profunda', 'Uma densa floresta tropical com fauna selvagem.', NULL, NULL, 5, NULL, 'Florestalis'),
('Cachoeira Cristalina', 'Uma área com uma cachoeira magnífica e um lago cristalino.', NULL, NULL, NULL, 3, 'Florestalis'),
('Templo Antigo', 'Um templo sagrado com segredos antigos.', NULL, NULL, 7, NULL, 'Templicus'),
('Ruínas Misteriosas', 'Ruínas que guardam enigmas e artefatos antigos.', 5, NULL, NULL, NULL, 'Templicus'),
('Laboratório Secreto', 'Um laboratório de pesquisa escondido.', NULL, NULL, NULL, 9, 'Techville'),
('Praça Central', 'O coração da cidade tecnológica.', 7, NULL, NULL, NULL, 'Techville');

INSERT INTO item(id, tipo) VALUES
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

INSERT INTO pergaminho(id, nome, peso, preco, raridade, tecnica) VALUES
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

INSERT INTO pocao(id, nome, peso, preco, pontos_cura) VALUES
    (21, 'Poção Inferior', 1.0, 5, 10),
    (22, 'Poção Básica', 1.0, 10, 25),
    (23, 'Poção Intermediária', 1.0, 20, 60),
    (24, 'Poção Avançada', 1.0, 50, 180),
    (25, 'Poção Superior', 1.0, 100, 400);

INSERT INTO arma(id, nome, peso, preco, dano) VALUES
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

INSERT INTO armadura(id, nome, peso, preco, pontos_protecao, parte_corpo) VALUES
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
    (3, NULL, 2, NULL), -- Pergaminho da Água Espiritual para inimigo com id 2
    (4, NULL, 3, NULL), -- Pergaminho de Sangue para inimigo com id 3
    (5, NULL, NULL, 1), -- Poção Inferior para mercador com id 1
    (6, 2, NULL, NULL), -- Pergaminho de Impacto de Terra para o personagem com id 2
    (7, NULL, 1, NULL); -- Pergaminho de Defesa Rochosa para inimigo com id 1

INSERT INTO contem_item (id_instancia_item, id_area) VALUES
    (1, 1),  -- Pergaminho do Gelo Cortante na área 1
    (2, 2),  -- Pergaminho do Gelo Perfurante na área 2
    (3, 1),  -- Pergaminho da Água Espiritual na área 1
    (4, 3),  -- Pergaminho de Sangue na área 3
    (5, 2),  -- Poção Inferior na área 2
    (6, 3),  -- Pergaminho de Impacto de Terra na área 3
    (7, 1);  -- Pergaminho de Defesa Rochosa na área 1

INSERT INTO personagem (id, tipo) VALUES
    (1, 'G'),  -- Personagem de id 1 é um Guerreiro
    (2, 'M');  -- Personagem de id 2 é um Mago
    (3, 'G'),  -- Personagem de id 3 é um Guerreiro
    (4, 'M');  -- Personagem de id 4 é um Mago

-- Personagem Jogável (PC)
INSERT INTO pc (id, nome, vida_max, vida_atual, xp, elemento, nivel, moedas, peso_max_inventario,
                id_area_atual, item_capacete, item_peitoral, item_acessorio, item_botas, item_arma) VALUES
    (1, 'Aragorn', 200, 150, 500, 'fogo', 10, 100, 100.0, 1, 36, 41, 46, 51, 26),  -- Guerreiro com itens
    (2, 'Merlin', 150, 120, 300, 'ar', 8, 150, 100.0, 2, 37, 42, 47, 52, 27),  -- Mago com itens
    (3, 'Gimli', 180, 180, 700, 'terra', 12, 50, 120.0, 3, 38, 43, 48, 53, 28),  -- Guerreiro com itens
    (4, 'Gandalf', 220, 200, 800, 'todos', 15, 200, 100.0, 4, 39, 44, 49, 54, 29);  -- Mago com itens

INSERT INTO amigo (id, nome, vida_max, vida_atual, xp, elemento, nivel, fala_entrada, fala_saida, eh_mestre,
                    nivel_necessario_discipulo, eh_mercador, nivel_necessario_compra, mult_preco,
                    eh_curandeiro, preco_por_ponto_cura, id_area) VALUES
    (1, 'Elrond', 250, 240, 600, 'ar', 15, 'Bem-vindo, jovem herói.', 'Até logo, que os ventos te guiem.', TRUE, 5, FALSE, NULL, NULL, FALSE, NULL, 1),  -- Mestre
    (2, 'Frodo', 150, 100, 400, 'agua', 10, 'Estou aqui para ajudar no que for preciso.', 'Volte sempre, meu amigo.', FALSE, NULL, TRUE, 5, 1.5, TRUE, 10, 2),  -- Mercador e Curandeiro
    (3, 'Samwise', 180, 170, 550, 'terra', 12, 'Sempre ao seu lado, amigo.', 'Até a próxima, Aragorn.', FALSE, NULL, TRUE, 7, 1.2, FALSE, NULL, 3),  -- Mercador
    (4, 'Gimli', 200, 200, 700, 'fogo', 14, 'Os ventos de fogo me guiarão.', 'Até mais, nos veremos em breve.', FALSE, NULL, FALSE, NULL, NULL, TRUE, 15, 4);  -- Curandeiro

INSERT INTO fala_historia (dialogo, id_amigo) VALUES
    ('O destino nos chama, jovem guerreiro.', 1),  -- Elrond
    ('Cuidado, os perigos estão por toda parte.', 2),  -- Frodo
    ('Fique atento, Aragorn, o caminho será difícil.', 3),  -- Samwise
    ('Com a força do fogo, nós venceremos!', 4);  -- Gimli

INSERT INTO inimigo (id, nome, vida_max, vida_atual, xp, elemento, nivel, fala_entrada, fala_saida, xp_ganho,
                    num_moedas_ganho, id_area) VALUES
    (1, 'Orc', 150, 150, 100, 'terra', 5, 'Prepare-se para enfrentar minha força!', 'Você pode ter vencido, mas isso não vai acabar aqui...', 100, 10, 1),  -- Orc
    (2, 'Golem', 250, 250, 200, 'fogo', 8, 'Eu sou a rocha que você não pode quebrar.', 'Você pode ter me derrotado, mas não vai sobreviver ao que está por vir.', 200, 20, 2),  -- Golem
    (3, 'Dragão', 500, 500, 500, 'ar', 12, 'Vocês não têm ideia do que estão enfrentando.', 'Este é apenas o começo de minha vingança!', 500, 50, 3),  -- Dragão
    (4, 'Necromante', 400, 400, 300, 'agua', 10, 'A morte sempre prevalecerá.', 'Você pode ter me derrotado, mas a escuridão nunca se apaga.', 300, 30, 4);  -- Necromante

INSERT INTO fala_combate (dialogo, id_inimigo) VALUES
    ('Você jamais me derrotará, mortal!', 1),  -- Orc
    ('Eu sou invencível! Sinta meu poder!', 2),  -- Golem
    ('As minhas asas irão te esmagar!', 3),  -- Dragão
    ('A morte será o seu fim, insignificante!', 4);  -- Necromante

INSERT INTO combate (id_pc, id_inimigo, data_hora, id_vencedor) VALUES
    (1, 1, '2025-01-15 10:30:00', 1),  -- PC 1 (guerreiro) vs Orc - vencedor: PC
    (2, 2, '2025-01-15 12:45:00', 2),  -- PC 2 (mago) vs Golem - vencedor: Inimigo (Golem)
    (3, 3, '2025-01-16 14:00:00', 3),  -- PC 3 (arqueiro) vs Dragão - vencedor: PC
    (4, 4, '2025-01-17 16:30:00', 4);  -- PC 4 (curandeiro) vs Necromante - vencedor: Inimigo (Necromante)

INSERT INTO tecnica(nome, tipo) VALUES
    -- ataque
    ('Chicote de Água','A'),
    ('Sopro de Gelo','A'),
    ('Discos de Gelo','A'),
    ('Garras de Gelo','A'),
    ('Espinhos de Gelo','A'),
    ('Espada de Gelo','A'),
    ('Marionete','A'),

    ('Lançamento de Pedra','A'),
    ('Bloco de Terra','A'),
    ('Esmagamento da Terra','A'),
    ('Terremotos','A'),
    ('Bomba de Terra','A'),
    ('Balas de Rocha Compactada','A'),
    ('Onda de Lava','A'),
    ('Disco de Lava','A'),
    ('Lançamento de Metal','A'),

    ('Chute Ardente','A'),
    ('Lâmina de Fogo','A'),
    ('Bomba de Fogo','A'),
    ('Adaga de Fogo','A'),
    ('Chicote de Fogo','A'),
    ('Corrente de Fogo','A'),
    ('Açoite de Fogo','A'),
    ('Soco de Fogo','A'),
    ('Cometa de Fogo','A'),
    ('Míssil de Fogo','A'),
    ('Raio','A'),
    ('Explosão Mental','A'),

    ('Jato de Ar','A'),
    ('Bomba de Ar','A'),
    ('Soco de Ar','A'),
    ('Sopro de Ar','A'),
    ('Lâmina de Ar','A'),
    ('Esteira de Ar','A'),
    ('Asfixia','A'),
    ('Vendaval','A'),
    ('Furacão','A'),

    ('Ataque de Espada','A'),
    ('Lançamento de Bumerangue','A'),

    -- defesa
    ('Escudo de Gelo','D'),

    ('Escudo de Rocha','D'),
    ('Coluna da Terra','D'),
    ('Armadura de Rocha','D'),
    ('Armadura de Terra Aprimorada','D'),
    ('Escudo de Metal','D'),

    ('Escudo de Fogo','D'),
    ('Bloqueio de Fogo','D'),

    ('Escudo de Ar','D'),

    -- mobilidade
    ('Tornado de Agua','M'),
    ('Rampa de Gelo','M'),
    ('Corrida na Água','M'),

    ('Tornado de Areia','M'),
    ('Redemoinho de Poeira','M'),
    ('Túnel da Terra','M'),
    ('Onda da Terra','M'),
    ('Magnetização','M'),
    ('Escalada de Poeira','M'),
    ('Impulso de areia','M'),

    ('Pés Propulsores','M'),

    ('Tornado de Ar','M'),
    ('Roda de Ar','M'),
    ('Esfera de Ar','M'),
    ('Patinete Aéreo','M'),
    ('Vôo','M'),

    -- cura
    ('Cura Simples','C'),
    ('Cura Aprimorada','C');

-----------------------
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

INSERT INTO sabe_tecnica (id_personagem, nome_tecnica) VALUES
    -- Personagem 1
    (1, 'Chicote de Água'),
    (1, 'Sopro de Gelo'),
    (1, 'Discos de Gelo'),
    (1, 'Garras de Gelo'),
    (1, 'Escudo de Gelo'),
    
    -- Personagem 2
    (2, 'Lançamento de Pedra'),
    (2, 'Bloco de Terra'),
    (2, 'Esmagamento da Terra'),
    (2, 'Escudo de Rocha'),
    (2, 'Coluna da Terra'),
    
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