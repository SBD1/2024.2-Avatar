import psycopg2
import time
import pandas as pd

class Database:
    def __init__(self):
        time.sleep(10) # aguarda 5 segundos para garantir que o banco de dados esteja pronto
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
      return {
          "id": player_data[0],
          "nome": player_data[1],
          "vida_atual": player_data[2],
          "vida_max": player_data[3],
          "xp": player_data[4],
          "nivel": player_data[5],
          "id_area_atual": player_data[9],
      }
    
    def get_area(self, id_area):
      sql = "SELECT * FROM area WHERE id = %s"
      self.cur.execute(sql, (id_area,))
      areas = self.cur.fetchone()
      return {
          "id": areas[0],
          "nome": areas[1],
          "descricao": areas[2],
          "area_norte": areas[3],
          "area_sul": areas[4],
          "area_leste": areas[5],
          "area_oeste": areas[6],
          "cidade": areas[7],
      }
    
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
      