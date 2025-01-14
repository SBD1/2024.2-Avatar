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
  
  def get_tecnicas_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM sabe_tecnica ST 
    JOIN tecnica T 
    ON ST.nome_tecnica = T.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))

  def get_ataques_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM sabe_tecnica ST 
    JOIN ataque A 
    ON ST.nome_tecnica = A.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  
  def get_defesas_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM sabe_tecnica ST 
    JOIN defesa D 
    ON ST.nome_tecnica = D.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  
  def get_mobilidades_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM sabe_tecnica ST 
    JOIN mobilidade M 
    ON ST.nome_tecnica = M.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  
  def get_curas_personagem(self, id_personagem):
    sql = """
    SELECT * 
    FROM sabe_tecnica ST 
    JOIN cura C 
    ON ST.nome_tecnica = C.nome 
    WHERE ST.id_personagem = %s
    """
    return self.query_all(sql, (id_personagem,))
  