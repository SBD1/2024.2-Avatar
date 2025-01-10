import psycopg2
import time
import pandas as pd

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

    def getTecnicasAtaque(self):
        self.cur.execute("SELECT * FROM ataque")
        return pd.DataFrame(self.cur.fetchall(), columns=[desc[0] for desc in self.cur.description])
    
    def getTecnicasCura(self):
        self.cur.execute("SELECT * FROM cura")
        return pd.DataFrame(self.cur.fetchall(), columns=[desc[0] for desc in self.cur.description])
    
    def getTecnicasDefesa(self):
        self.cur.execute("SELECT * FROM defesa")
        return pd.DataFrame(self.cur.fetchall(), columns=[desc[0] for desc in self.cur.description])

    def getTecnicasMobilidade(self):
        self.cur.execute("SELECT * FROM mobilidade")
        return pd.DataFrame(self.cur.fetchall(), columns=[desc[0] for desc in self.cur.description])