from sqlalchemy import create_engine, insert, text
import time

time.sleep(5)

engine = create_engine("postgresql+psycopg2://postgres:postgres@db:5432/DB")
conn = engine.connect()


print('done')