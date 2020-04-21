url = "person_data.csv"
monFichier = open(url, 'r')  # url = fichier .txt
data = monFichier.read()
monFichier.close()
# récupère le contenu de data mais dès qu'il y a 2 sauts de lignes on en laisse qu'un seul
data2 = data.replace('\n\n', '\n')
monFichier = open(url, 'w')  # url = fichier .txt
# print(data2)
monFichier.write(data2)
monFichier.close()
