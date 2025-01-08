CREATE TABLE nacao
(
  nome VARCHAR(20) PRIMARY KEY ,
  descricao VARCHAR(250) NOT NULL
);

CREATE TABLE cidade
(
  nome VARCHAR(50) PRIMARY KEY,
  descricao VARCHAR(250) NOT NULL,
  nivel_necessario_entrar INT NOT NULL,
  nacao VARCHAR(20) NOT NULL,
  FOREIGN KEY (nacao) REFERENCES nacao(nome)
);

CREATE TABLE area
(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  nome VARCHAR(50) NOT NULL,
  descricao VARCHAR(250) NOT NULL,
  area_norte INT,
  area_sul INT,
  area_leste INT,
  area_oeste INT,
  cidade VARCHAR(50) NOT NULL,
  FOREIGN KEY (area_norte) REFERENCES area(id),
  FOREIGN KEY (area_sul) REFERENCES area(id),
  FOREIGN KEY (area_leste) REFERENCES area(id),
  FOREIGN KEY (area_oeste) REFERENCES area(id),
  FOREIGN KEY (cidade) REFERENCES cidade(nome)
);

CREATE TABLE item
(
  id INT PRIMARY KEY,
  tipo CHAR(1) NOT NULL
);

CREATE TABLE pergaminho
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) UNIQUE NOT NULL,
  peso REAL NOT NULL,
  preco INT NOT NULL,
  raridade TEXT CHECK (raridade in ('comum', 'raro', 'epico', 'lendario')) DEFAULT 'comum',
  movimento VARCHAR(50) NOT NULL,

  FOREIGN KEY (id)  REFERENCES item(id)
);

CREATE TABLE pocao 
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) UNIQUE NOT NULL,
  peso REAL NOT NULL,
  preco INT NOT NULL,
  pontos_cura INT NOT NULL,

  FOREIGN KEY (id)  REFERENCES item(id)
);

CREATE TABLE arma
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) UNIQUE NOT NULL,
  peso REAL NOT NULL,
  preco INT NOT NULL,
  dano INT NOT NULL,

  FOREIGN KEY (id)  REFERENCES item(id)
);

CREATE TABLE armadura
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) UNIQUE NOT NULL,
  peso REAL NOT NULL,
  preco INT NOT NULL,
  pontos_protecao INT NOT NULL,
  parte_corpo TEXT CHECK (parte_corpo in ('capacete', 'peitoral', 'acessorio', 'botas')) NOT NULL,

  FOREIGN KEY (id)  REFERENCES item(id)
);

CREATE TABLE instancia_item
(
  id_instancia INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  id_item INT NOT NULL,
  id_pc INT,
  id_inimigo INT,
  id_mercador INT,

  FOREIGN KEY (id_item) REFERENCES item(id)
);

CREATE TABLE contem_item
(
  id_instancia_item INT PRIMARY KEY,
  id_area INT NOT NULL,

  FOREIGN KEY (id_instancia_item) REFERENCES instancia_item(id_instancia),
  FOREIGN KEY (id_area) REFERENCES area(id)
);

CREATE TABLE personagem
(
  id INT PRIMARY KEY,
  tipo CHAR(1) NOT NULL
);

CREATE TABLE pc
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  vida_max INT NOT NULL,
  vida_atual INT NOT NULL,
  xp INT NOT NULL,
  nivel INT NOT NULL,
  num_ouro INT,
  num_prata INT,
  num_cobre INT,
  peso_max_inventario REAL DEFAULT 100.00,
  id_area_atual INT NOT NULL,
  item_capacete INT,
  item_peitoral INT,
  item_acessorio INT,
  item_botas INT,
  item_arma INT,

  FOREIGN KEY (id) REFERENCES personagem(id),
  FOREIGN KEY (id_area_atual) REFERENCES area(id),
  FOREIGN KEY (item_capacete) REFERENCES instancia_item(id_instancia),
  FOREIGN KEY (item_peitoral) REFERENCES instancia_item(id_instancia),
  FOREIGN KEY (item_acessorio) REFERENCES instancia_item(id_instancia),
  FOREIGN KEY (item_botas) REFERENCES instancia_item(id_instancia),
  FOREIGN KEY (item_arma) REFERENCES instancia_item(id_instancia)
);

CREATE TABLE amigo
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  vida_max INT NOT NULL,
  vida_atual INT NOT NULL,
  xp INT NOT NULL,
  nivel INT NOT NULL,
  fala_entrada VARCHAR(150) NOT NULL,
  fala_saida VARCHAR(150) NOT NULL,
  eh_mestre BOOLEAN ,
  nivel_necessario_discipulo INT,
  eh_mercador BOOLEAN,
  nivel_necessario_compra INT,
  mult_preco REAL,
  eh_curandeiro BOOLEAN,
  preco_por_ponto_cura INT,
  id_area INT NOT NULL,

  FOREIGN KEY (id) REFERENCES personagem(id),
  FOREIGN KEY (id_area) REFERENCES area(id)
);

CREATE TABLE fala_historia
(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  dialogo VARCHAR(150) NOT NULL,
  id_amigo INT NOT NULL,

  FOREIGN KEY (id_amigo) REFERENCES amigo(id)
);

CREATE TABLE inimigo
(
  id INT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  vida_max INT NOT NULL,
  vida_atual INT NOT NULL,
  xp INT NOT NULL,
  nivel INT NOT NULL,
  fala_entrada VARCHAR(150) NOT NULL,
  fala_saida VARCHAR(150) NOT NULL,
  xp_ganho INT NOT NULL,
  num_moedas_ganho INT NOT NULL,
  id_area INT NOT NULL,

  FOREIGN KEY (id) REFERENCES personagem(id),
  FOREIGN KEY (id_area) REFERENCES area(id)
);

CREATE TABLE fala_combate
(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  dialogo VARCHAR(150) NOT NULL,
  id_inimigo INT NOT NULL,

  FOREIGN KEY (id_inimigo) REFERENCES inimigo(id)
);

CREATE TABLE combate
(
  id_pc INT,
  id_inimigo INT,
  data_hora timestamp,
  id_vencedor INT NOT NULL,

  PRIMARY KEY (id_pc, id_inimigo, data_hora),
  FOREIGN KEY (id_pc) REFERENCES pc(id),
  FOREIGN KEY (id_inimigo) REFERENCES inimigo(id)
);

CREATE TABLE dobra
(
  nome VARCHAR(50) PRIMARY KEY,
  mult_dano INT NOT NULL
);

CREATE TABLE subdobra
(
  nome VARCHAR(50) PRIMARY KEY,
  mult_dano INT NOT NULL,
  dobra VARCHAR(50) NOT NULL,

  FOREIGN KEY (dobra) REFERENCES dobra(nome)
);

CREATE TABLE movimento
(
  nome VARCHAR(50) PRIMARY KEY,
  dano INT NOT NULL,
  descricao VARCHAR(250) NOT NULL,
  nivel_necessario_aprender INT NOT NULL,
  tipo TEXT CHECK (tipo in ('dobra', 'golpe')),
  dobra VARCHAR(50),
  subdobra VARCHAR(50),

  FOREIGN KEY (dobra) REFERENCES dobra(nome),
  FOREIGN KEY (subdobra) REFERENCES subdobra(nome)
);

CREATE TABLE sabe_movimento
(
  id_personagem INT,
  nome_movimento VARCHAR(50),

  PRIMARY KEY (id_personagem, nome_movimento),
  FOREIGN KEY (id_personagem) REFERENCES personagem(id),
  FOREIGN KEY (nome_movimento) REFERENCES movimento(nome)
);

CREATE TABLE domina_dobra
(
  id_personagem INT,
  nome_dobra VARCHAR(50),

  PRIMARY KEY (id_personagem, nome_dobra),
  FOREIGN KEY (id_personagem) REFERENCES personagem(id),
  FOREIGN KEY (nome_dobra) REFERENCES dobra(nome)
);

ALTER TABLE instancia_item
  ADD FOREIGN KEY (id_pc) REFERENCES pc(id),
  ADD FOREIGN KEY (id_inimigo) REFERENCES inimigo(id),
  ADD FOREIGN KEY (id_mercador) REFERENCES amigo(id);

ALTER TABLE pergaminho ADD FOREIGN KEY (movimento) REFERENCES movimento(nome);