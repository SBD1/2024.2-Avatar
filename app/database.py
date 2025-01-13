import psycopg2
import time
import pandas as pd
from types import SimpleNamespace

# Tranforma o resultado (tupla) em uma lista de objetos
def transform_result(description, fetch):
    # pega todas as colunas do resultado
    columns = [col[0] for col in description]
    # cria um objeto SimpleNamespace para cada linha
    
    return [SimpleNamespace(**dict(zip(columns, row))) for row in fetch]

class Database:
    def __init__(self):
        time.sleep(5) # aguarda 5 segundos para garantir que o banco de dados esteja pronto
        self.conn = psycopg2.connect(
            user="postgres",
            password="postgres",
            host="db",
            port="5432",
            database="DB",
        )
        self.cur = self.conn.cursor()

    def close(self):
        self.cur.close()
        self.conn.close()

    def create_player(self, nome):
        # Cria uma nova referência de um PC na tabela personagem
        sql_personagem = "INSERT INTO personagem (tipo) VALUES (%s) RETURNING id"
        self.cur.execute(sql_personagem, ('P',))
        id_personagem = self.cur.fetchone()[0]
        
        # Cria um novo jogador na tabela pc (playable character)
        sql_jogador = "INSERT INTO pc (id, nome) VALUES (%s, %s)"
        self.cur.execute(sql_jogador, (id_personagem, nome))
        
        self.conn.commit()
        return id_personagem

    def get_player(self, id_jogador):
      sql = "SELECT * FROM pc WHERE id = %s"
      self.cur.execute(sql, (id_jogador,))
      player_data = self.cur.fetchone()
      # [0] no final, pois transform_result sempre retorna uma lista de objetos (mesmo que unico)
      return transform_result(self.cur.description, [player_data])[0]

    def get_players(self):
      sql = "SELECT id, nome FROM pc ORDER BY id"
      self.cur.execute(sql)

      players = self.cur.fetchall()

      if players == None:
        return []

      return transform_result(self.cur.description, players)
    
    def get_area(self, id_area):
      sql = "SELECT * FROM area WHERE id = %s"
      self.cur.execute(sql, (id_area,))
      areas = self.cur.fetchone()
      return transform_result(self.cur.description, [areas])[0]
    
    def get_nome_area(self, id_area):
      sql = "SELECT nome FROM area WHERE id = %s"
      self.cur.execute(sql, (id_area,))
      result = self.cur.fetchone()[0]
      if (result == None):
        return "Nenhuma"
      return result

    def update_player_area(self, id_jogador, id_area):
      sql = "UPDATE pc SET id_area_atual = %s WHERE id = %s"
      self.cur.execute(sql, (id_area, id_jogador))
      self.conn.commit()

      