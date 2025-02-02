import psycopg2
from psycopg2.extras import NamedTupleCursor
import time

class Database:
  def __init__(self):
    time.sleep(10)  # Aguarda o banco estar pronto
    try:
      self.conn = psycopg2.connect(
        user="postgres",
        password="postgres",
        host="db",
        port="5432",
        database="DB",
      )
    except psycopg2.Error as e:
      print(f"Erro ao conectar ao banco de dados: {e}")
      raise

  def query_all(self, sql, params=None):
    try:
      with self.conn.cursor(cursor_factory=NamedTupleCursor) as cursor:
        cursor.execute(sql, params)
        return cursor.fetchall()
    except psycopg2.Error as e:
      print(f"Erro ao executar query_all: {e}")
      raise

  def query_one(self, sql, params=None):
    try:
      with self.conn.cursor(cursor_factory=NamedTupleCursor) as cursor:
        cursor.execute(sql, params)
        return cursor.fetchone()
    except psycopg2.Error as e:
      print(f"Erro ao executar query_one: {e}")
      raise

  def create(self, sql, params=None):
    try:
      with self.conn.cursor(cursor_factory=NamedTupleCursor) as cursor:
        cursor.execute(sql, params)
        if cursor.description:
          results = cursor.fetchall()
          if results:
            self.conn.commit()
            return results[0]
        self.conn.commit()
        return None
    except psycopg2.Error as e:
      print(f"Erro ao executar create: {e}")
      self.conn.rollback()
      raise

  def update(self, sql, params=None):
    try:
      with self.conn.cursor() as cursor:
        cursor.execute(sql, params)
        self.conn.commit()
    except psycopg2.Error as e:
      print(f"Erro ao executar update: {e}")
      self.conn.rollback()
      raise

  def close(self):
    self.conn.close()

  def create_player(self, nome):
    sql_update_id = "SELECT setval('personagem_id_seq', (SELECT MAX(id) FROM personagem))"
    self.update(sql_update_id)
  
    sql_personagem = "INSERT INTO personagem (tipo) VALUES (%s) RETURNING id"
    id_personagem = self.create(sql_personagem, ('P',))

    sql_jogador = "INSERT INTO pc (id, nome) VALUES (%s, %s)"
    self.create(sql_jogador, (id_personagem, nome))

    return id_personagem

  def get_player(self, id_jogador):
    sql = "SELECT * FROM pc WHERE id = %s"
    return self.query_one(sql, (id_jogador,))

  def get_area(self, id_area):
    sql = "SELECT * FROM area WHERE id = %s"
    return self.query_one(sql, (id_area,))


  def get_players(self):
    sql = "SELECT id, nome FROM pc ORDER BY id"
    players = self.query_all(sql)

    if players == None:
      return []

    return players
  
  def get_nome_area(self, id_area):
    sql = "SELECT nome FROM area WHERE id = %s"
    result = self.query_one(sql, (id_area,))
    return result.nome if result else "Nenhuma"

  def update_player_area(self, id_jogador, id_area):
    sql = "UPDATE pc SET id_area_atual = %s WHERE id = %s"
    self.update(sql, (id_area, id_jogador))

  def get_tecnica(self, nome):
    sql = "SELECT tipo FROM tecnica WHERE nome = %s"
    tipo_tecnica = self.query_one(sql, (nome,))
    
    if not tipo_tecnica:
      print(f"Técnica '{nome}' não encontrada.")
      return None
    
    tipo = tipo_tecnica.tipo

    if tipo == 'A':
      sql = "SELECT * FROM ataque WHERE nome = %s"
    elif tipo == 'D':
      sql = "SELECT * FROM defesa WHERE nome = %s"
    elif tipo == 'M':
      sql = "SELECT * FROM mobilidade WHERE nome = %s"
    elif tipo == 'C':
      sql = "SELECT * FROM cura WHERE nome = %s"
    else:
      print(f"Tipo de técnica inválido: {tipo}")
      return None

    return self.query_one(sql, (nome,))
  
 
# Buscas para NPC

  def get_npc(self, id_npc):
    sql = """
    SELECT *
    FROM amigo
    WHERE id = %s
    """
    return self.query_one(sql, (id_npc,))
  
  def get_npcs_por_area(self, id_area):
    sql = """
    SELECT *
    FROM amigo
    WHERE id_area = %s
    """
    npcs_area = self.query_all(sql, (id_area,))
    
    if npcs_area == None:
      return []
    
    return npcs_area
  
# Buscas para inimigo

  def get_inimigo(self, id_inimigo):
    sql = """
    SELECT *
    FROM inimigo
    WHERE id = %s
    """
    return self.query_one(sql, (id_inimigo,))
  
  def get_inimigos_por_area(self, id_area):
    sql = """
    SELECT *
    FROM inimigo
    WHERE id_area = %s
    """
    inimigos_area = self.query_all(sql, (id_area,))
    
    if inimigos_area == None:
      return []
    
    return inimigos_area

# Buscas para itens

  def get_pergaminho(self, id_instancia, id_pergaminho):
    sql = """
    SELECT *
    FROM
      (SELECT id_instancia
      FROM instancia_item
      WHERE id_instancia = %s),
      (SELECT * 
      FROM pergaminho
      WHERE id = %s)
    """
    return self.query_one(sql, (id_instancia, id_pergaminho,))

  def get_pocao(self, id_instancia, id_pocao):
    sql = """
    SELECT *
    FROM
      (SELECT id_instancia
      FROM instancia_item
      WHERE id_instancia = %s),
      (SELECT * 
      FROM pocao
      WHERE id = %s)
    """
    return self.query_one(sql, (id_instancia, id_pocao,))

  
  def get_arma(self, id_instancia, id_arma):
    sql = """
    SELECT *
    FROM
      (SELECT id_instancia
      FROM instancia_item
      WHERE id_instancia = %s),
      (SELECT * 
      FROM arma
      WHERE id = %s)
    """
    return self.query_one(sql, (id_instancia, id_arma,))
  
  def get_armadura(self, id_instancia, id_armadura):
    sql = """
    SELECT *
    FROM
      (SELECT id_instancia
      FROM instancia_item
      WHERE id_instancia = %s),
      (SELECT * 
      FROM armadura
      WHERE id = %s)
    """
    return self.query_one(sql, (id_instancia, id_armadura,))

  def get_instancia_item(self, id_instancia):
    sql = """
    SELECT * 
    FROM instancia_item
    WHERE id_instancia = %s
    """
    return self.query_one(sql, (id_instancia,))
  
  def get_item(self, id_instancia, tipo_item="Todos"):
    sql = """
      SELECT *
      FROM instancia_item, item
      WHERE instancia_item.id_instancia = %s AND instancia_item.id_item = item.id
    """
    item = self.query_one(sql, (id_instancia,))
    if item.tipo == 'S' and (tipo_item == "Pergaminhos" or tipo_item == "Todos"):
      item = self.get_pergaminho(id_instancia, item.id)
      return item
    elif item.tipo == 'P' and (tipo_item == "Poções" or tipo_item == "Todos"):
      item = self.get_pocao(id_instancia, item.id)
      return item
    elif item.tipo == 'W' and (tipo_item == "Armas" or tipo_item == "Todos"):
      item = self.get_arma(id_instancia, item.id)
      return item
    elif item.tipo == 'A' and (tipo_item == "Armaduras" or tipo_item == "Todos"):
      item = self.get_armadura(id_instancia, item.id)
      return item
    
    return False

  def get_itens_por_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM instancia_item
    WHERE id_pc = %s
    """
    return self.query_all(sql, (id_personagem,))

  def get_itens_por_inimigo(self, id_inimigo):
    sql = """
    SELECT * 
    FROM instancia_item
    WHERE id_inimigo = %s
    """
    return self.query_all(sql, (id_inimigo,))

  def get_itens_por_npc(self, id_mercador):
    sql = """
    SELECT * 
    FROM instancia_item
    WHERE id_mercador = %s
    """
    return self.query_all(sql, (id_mercador,))

  def get_itens_por_area(self, id_area):
    sql = """
    SELECT * 
    FROM contem_item
    WHERE id_area = %s
    """
    instancias_area = self.query_all(sql, (id_area,))
    
    if instancias_area == None:
      return []
    
    itens = []
    for instancia in instancias_area:
      itens.append(self.get_item(instancia.id_instancia_item))
    
    return itens

  def add_item_inventario(self, id_instancia, id_jogador):
    item = self.get_instancia_item(id_instancia)

    sql = "UPDATE instancia_item SET id_pc = %s WHERE id_instancia = %s"
    self.update(sql, (id_jogador, id_instancia))

    sql = "DELETE FROM contem_item WHERE id_instancia_item = %s"
    self.update(sql, (id_instancia,))

    return True

  def drop_item(self, id_instancia, id_area):
    item = self.get_instancia_item(id_instancia)

    sql = "UPDATE instancia_item SET id_pc = NULL, id_inimigo = NULL, id_mercador = NULL WHERE id_instancia = %s"
    self.update(sql, (id_instancia,))

    sql = "INSERT INTO contem_item (id_instancia_item, id_area) VALUES (%s, %s)"
    self.create(sql, (id_instancia, id_area))

    return True
  
  def get_itens_inventario_por_aba(self, id_jogador, aba_inventario):
    instancias_inventario = self.get_itens_por_personagem(id_jogador)
    
    if instancias_inventario == None:
      return []
    
    itens = []
    
    if aba_inventario == "Todas":
      for instancia in instancias_inventario:
        item = self.get_item(instancia.id_instancia)
        if item:
          itens.append(item)
      return itens
    
    elif aba_inventario == "Poções":
      for instancia in instancias_inventario:
        item = self.get_item(instancia.id_instancia, "Poções")
        if item:
          itens.append(item)
      return itens
      
    elif aba_inventario == "Pergaminhos":
      for instancia in instancias_inventario:
        item = self.get_item(instancia.id_instancia, "Pergaminhos")
        if item:
          itens.append(item)
      return itens
      
    elif aba_inventario == "Armas":
      for instancia in instancias_inventario:
        item = self.get_item(instancia.id_instancia, "Armas")
        if item:
          itens.append(item)
      return itens
      
    elif aba_inventario == "Armaduras":
      for instancia in instancias_inventario:
        item = self.get_item(instancia.id_instancia, "Armaduras")
        if item:
          itens.append(item)
      return itens
    
    return itens

  def equipar_arma(self, id_instancia, id_jogador):
    item = self.get_item(id_instancia)
    sql = "UPDATE pc SET item_arma = %s WHERE id = %s"
    self.update(sql, (id_instancia, id_jogador))

    return True

  def desequipar_arma(self, id_instancia, id_jogador):
    item = self.get_item(id_instancia)
    sql = "UPDATE pc SET item_arma = NULL WHERE id = %s"
    self.update(sql, (id_jogador,))

    return True

  def equipar_armadura(self, id_instancia, id_jogador):
    item = self.get_item(id_instancia)
    
    sql = ""
    if (item.parte_corpo == 'capacete'):
      sql = "UPDATE pc SET item_capacete = %s WHERE id = %s"
    elif (item.parte_corpo == 'peitoral'):
      sql = "UPDATE pc SET item_peitoral = %s WHERE id = %s"
    elif (item.parte_corpo == 'acessorio'):
      sql = "UPDATE pc SET item_acessorio = %s WHERE id = %s"
    elif (item.parte_corpo == 'botas'):
      sql = "UPDATE pc SET item_botas = %s WHERE id = %s"
    
    self.update(sql, (id_instancia, id_jogador))

    return True

  def desequipar_armadura(self, id_instancia, id_jogador):
    item = self.get_item(id_instancia)
    
    sql = ""
    if (item.parte_corpo == 'capacete'):
      sql = "UPDATE pc SET item_capacete = NULL WHERE id = %s"
    elif (item.parte_corpo == 'peitoral'):
      sql = "UPDATE pc SET item_peitoral = NULL WHERE id = %s"
    elif (item.parte_corpo == 'acessorio'):
      sql = "UPDATE pc SET item_acessorio = NULL WHERE id = %s"
    elif (item.parte_corpo == 'botas'):
      sql = "UPDATE pc SET item_botas = NULL WHERE id = %s"
    
    self.update(sql, (id_jogador,))

    return True

  # Funções de combate
  def deal_damage(self, id_personagem, dano_causado):
    sql_type = "SELECT tipo FROM personagem WHERE id = %s"
    tipo = self.query_one(sql_type, (id_personagem,)).tipo

    if tipo == 'I':
      sql = "UPDATE inimigo SET vida_atual = vida_atual - %s WHERE id = %s"
    elif tipo == 'P':
      sql = "UPDATE pc SET vida_atual = vida_atual - %s WHERE id = %s"
    elif tipo == 'A':
      sql = "UPDATE amigo SET vida_atual = vida_atual - %s WHERE id = %s"

    self.update(sql, (dano_causado, id_personagem))

  def use_heal(self, id_personagem, pontos_cura):
    sql_type = "SELECT tipo FROM personagem WHERE id = %s"
    tipo = self.query_one(sql_type, (id_personagem,)).tipo

    if tipo == 'I':
      sql = "UPDATE inimigo SET vida_atual = vida_atual + %s WHERE id = %s"
    elif tipo == 'P':
      sql = "UPDATE pc SET vida_atual = vida_atual + %s WHERE id = %s"
    elif tipo == 'A':
      sql = "UPDATE amigo SET vida_atual = vida_atual + %s WHERE id = %s"

    self.update(sql, (pontos_cura, id_personagem))

  def add_combate(self, id_jogador, id_inimigo, id_vencedor):
    sql = "INSERT INTO combate (id_pc, id_inimigo, id_vencedor) VALUES (%s, %s, %s)"
    self.create(sql, (id_jogador, id_inimigo, id_vencedor))

  def get_inimigo(self, id_inimigo):
    sql = "SELECT * FROM inimigo WHERE id = %s"
    return self.query_one(sql, (id_inimigo,))
  
  def get_tecnicas_personagem(self, id_personagem):
    return (
      self.get_ataques_personagem(id_personagem) +
      self.get_defesas_personagem(id_personagem) +
      self.get_mobilidades_personagem(id_personagem) +
      self.get_curas_personagem(id_personagem))
    

  def get_ataques_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM ataque A
    JOIN sabe_tecnica ST
    ON ST.nome_tecnica = A.nome
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  
  def get_defesas_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM defesa D 
    JOIN sabe_tecnica ST 
    ON ST.nome_tecnica = D.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  
  def get_mobilidades_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM mobilidade M 
    JOIN sabe_tecnica ST 
    ON ST.nome_tecnica = M.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  
  def get_curas_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM cura C 
    JOIN sabe_tecnica ST 
    ON ST.nome_tecnica = C.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  