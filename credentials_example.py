import os

DB_URL = f'mysql+pymysql://{os.environ["MYSQL_USER"]}:{os.environ["MYSQL_PASSWORD"]}@lu-database/{os.environ["MYSQL_DATABASE"]}'
