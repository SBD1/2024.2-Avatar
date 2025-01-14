-- Buscas para pergaminhos
SELECT * FROM pergaminho;
SELECT * FROM pergaminho WHERE raridade = 'comum';
SELECT * FROM pergaminho WHERE raridade = 'raro';
SELECT * FROM pergaminho WHERE raridade = 'epico';
SELECT * FROM pergaminho WHERE raridade = 'lendario';

-- Buscas para poções
SELECT * FROM pocao;
SELECT * FROM pocao WHERE nome = 'Poção Inferior';
SELECT * FROM pocao WHERE nome = 'Poção Básica';
SELECT * FROM pocao WHERE nome = 'Poção Intermediária';
SELECT * FROM pocao WHERE nome = 'Poção Avançada';
SELECT * FROM pocao WHERE nome = 'Poção Superior';

-- Buscas para armas
SELECT * FROM arma;

-- Buscas para armaduras
SELECT * FROM armadura;
SELECT * FROM armadura WHERE parte_corpo = 'capacete';
SELECT * FROM armadura WHERE parte_corpo = 'peitoral';
SELECT * FROM armadura WHERE parte_corpo = 'acessorio';
SELECT * FROM armadura WHERE parte_corpo = 'botas';

-- Buscas para itens em personagens
SELECT * FROM instancia_item;
SELECT * FROM instancia_item WHERE id_pc IS NOT NULL;
SELECT * FROM instancia_item WHERE id_inimigo IS NOT NULL GROUP BY id_inimigo;
SELECT * FROM instancia_item WHERE id_mercador IS NOT NULL GROUP BY id_mercador;

-- Buscas para itens em áreas
SELECT * FROM contem_item;
SELECT * FROM contem_item GROUP BY id_area;
