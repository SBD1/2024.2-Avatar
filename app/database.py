import psycopg2

class Database:
    def __init__(self):
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


    def getDobras(self):
        self.cur.execute("SELECT * FROM dobra")
        return self.cur.fetchall()
    
    def getMovimentos(self):
        self.cur.execute("SELECT * FROM movimento")
        return self.cur.fetchall()
    
    def getSubdobras(self):
        self.cur.execute("SELECT * FROM subdobra")
        return self.cur.fetchall()