import psycopg2
import time

# Number of rows to add in each batch
n = 10000

# génerer pleins de requêtes insert into
single_query = """Insert into post (user_id,post_text)
Values (1, 'All work and no play makes Jake a dull boy.');"""


# génerer une seule grosse requête insert into avec pleins de values
big_query = "Insert into post (user_id,post_text) Values "

for i in range(n):  # 10000 fois
    big_query += "(1, 'All work and no play makes Jake a dull boy.'),"
# remplace la dernière virgule par un point-virgule
big_query = big_query.strip(',')+';'

# se connecter à la base de données et créer le curseur
#password = open('password.txt', 'r').read()
password = "mypassword"  # il faut penser à mettre mon mot de passe
conn = psycopg2.connect(
    "dbname= socratica user = postgres password={0}".format(password))
cur = conn.cursor()

# Le temps des n requetes individuelles
start_time = time.time()
for i in range(n):
    cur.execute(single_query)
conn.commit()
stop_time = time.time()
print("{0} individual queries took {1} seconds".format(n, stop_time-start_time))

# pour la grosse requête
start_time = time.time()
cur.execute(big_query)
conn.commit()
stop_time = time.time()
print("The query with {0} row took {1} seconds".format(
    n, stop_time-start_time))

# fermer le curseur et la connection à la base
cur.close()
conn.close()
