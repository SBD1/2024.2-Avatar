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