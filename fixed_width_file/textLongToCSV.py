# from unidecode import unidecode

# format encodage ansi (text enregistrer sous) -> donc win1252
# def remove_non_ascii(text):
#     return unidecode(text)


# fonctions définies pour rendre le programme plus clair


def mask():
    "Le masque à appliquer par exemple de 0 à 14 c'est la colonne dateH, de 15 à 16 c'est etat etc..."
    # pour le trouver on peut aller dans le fichier txt, mettre le curseur et regarder la valeur indiquée en bas à droite de l'éditeur avec la ligne et la colonne ->on rentre la valeur de la colonne
    return [0, 7, 8, 12, 13, 23, 25, 35, 38, 62, 65, 68, 70, 73, 74, 82, 84, 87, 92, 105, 113, 125, 128, 133]


def header():
    "Le header du csv"
    # les différentes colonnes/tables
    return " Entry;Per;Post_Date;GL_Account; Description;Srce;Cflow;Ref;Post;Debit;Credit;Alloc"


def traitementLigne(lineT):
    "Prend en paramètre la ligne à traiter et lui applique la transformation souhaitée."
    listeVal = mask()
    lineOut = ""
    # 12 colonnes
    for i in range(0, 12):
        # 2 valeurs pour chaque colonnes
        lineOut += lineT[listeVal[i*2]:listeVal[i*2+1]]
        # on ne met pas de virgule à la fin de la ligne
        if i < 11:
            lineOut += ";"  # séparé avec des points virgules car il y a des virgules dans le fichier et cela pourrai fausser le CSV
    return lineOut


def readEachLine(filename):
    "Lit ligne par ligne le fichier donné en paramètre."
    fp = open(filename, 'r', encoding='cp850')
    text = header()+"\n"  # on l'initialise avec le header
    number = 1
    while True:
        line = fp.readline()
        # On sort si on est à la fin du fichier, à faire avant les traitement des données
        if len(line) == 0:
            print("Il y a "+str(number)+" lignes")
            return text
        text += traitementLigne(line)
        number += 1


def writeToF(filename, text='Texte de base à ajouter !!!'):
    "Cette fonction prend en paramètre le nom du fichier et le texte puis l'écrit dans un fichier ou le créer si il n'existe pas."
    # a -> mode append, ajoute le texte au fichier ou le créer si il est vide. Write supp et écris dans le nouveau fichier vide
    try:  # essaye l'instruction et si il y a une erreur, renvoie le except
        obFichier = open(filename, 'w')
    except:
        print("Le fichier", filename, "est introuvable")
    obFichier.write(text)
    obFichier.close()


def cleanCSV(filename):
    "Enlève les espaces inutiles dans le fichier."
    monFichier = open(filename, 'r')
    data = monFichier.read()
    monFichier.close()
# récupère le contenu de data mais dès qu'il y a des espaces il les enlève
    data2 = data.replace(' ', '')
    # data3 = remove_non_ascii(data2)  # enlève les symboles inconnus
    monFichier = open(filename, 'w')
    monFichier.write(data2)
    print("Espaces et caractères inconnus enlevés dans le fichier !")
    monFichier.close()


def firstClean(filename):
    "Premier nettoyage, enlève les saut de ligne en trop"
    monFichier = open(filename, 'r')
    data = monFichier.read()
    monFichier.close()
    # récupère le contenu de data mais dès qu'il y a 2 sauts de lignes on en laisse qu'un seul
    data2 = data.replace('\n\n', '\n')
    monFichier = open(filename, 'w')
    # print(data2)
    monFichier.write(data2)
    monFichier.close()


# instructions effectuées au lancement de ce programme :
print("Entrer le nom du fichier à lire")
# FixedWidthExample2.txt
filename1 = input()
print("Entrer le nom du ficher dans lequel on mettra les données")
# dataExample.csv
filename2 = input()
firstClean(filename1)
writeToF(filename2, readEachLine(filename1))
cleanCSV(filename2)
