import mysql.connector as mysql_con
from mysql.connector import Error

import pandas as pd
from pandas.core.frame import DataFrame

class Database:

    def __init__(self, config):

        self.host = config.db_host
        self.dbname = config.db_name
        self.password = config.db_password
        self.username = config.db_user
        self.port = config.db_port
        self.conn = None
        

    def open_cursor(self):
        # opens connection and returns a cursor
        if self.conn is None:
            self.conn = mysql_con.connect(
                user = self.username, 
                database = self.dbname, 
                password = self.password,
                port = self.port,
                host = self.host
                )

            return self.conn.cursor(dictionary=True)

    def run_view(self, query_txt):
        # runs a select query and returns a dataframe with results

        # 1. opens connection and initialize a cursor   
        cur = Database.open_cursor(self)

        # 2. runs query and returns df
        try:
            records = []
            cur.execute(query_txt)
            result = cur.fetchall()
            for row in result:
                records.append(row)
            df_res = pd.DataFrame(records)
            cur.close()
        except:
            # something is wrong, we return an empty frame
            df_res = pd.DataFrame()
        finally:
            self.conn.close()
            self.conn = None
            return df_res

    def run_action(self, query_txt) -> str:
        # runs an action query - ie insert, delete, update returns success/error message
        # !!! query_txt in this case is a list with one or more commands !!!
        # methods returns success/failure message

        # 1. opens connection and initialize a cursor   
        cur = Database.open_cursor(self)

        # 2. runs query and returns message
        try:
            for sql_text in query_txt:
                cur.execute(sql_text)
            self.conn.commit()
            cur.close()
            mesaj = "OK"
        except:
            mesaj = "Eroare"
        finally:
            self.conn.close()
            self.conn = None
            return mesaj