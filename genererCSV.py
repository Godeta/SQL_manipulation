import csv
from faker import Faker
import datetime
import random  # uniquement pour l'identifiant

FirstId = random.getrandbits(16)  # on défini un premier identifiant aléatoire


def datagenerate(records, headers):
    # génerer nom, prefixe, adresses, ville et autre textes...
    fake = Faker('en_US')
    # génerer des numéros de télephone ou autre lettres
    fake1 = Faker('en_GB')
    with open("person_data.csv", 'wt') as csvFile:  # créer ou ouvrir le fichier csv
        # écrire dans le fichier, on précise aussi le header
        writer = csv.DictWriter(csvFile, fieldnames=headers)
        writer.writeheader()  # écriture du header défini plus bas
        for i in range(records):  # records -> nombre de ligne défini plus bas

            # tous les autres se suivent depuis le premier identifiant aléatoire, ainsi ils sont tous uniques
            userId = FirstId + i

            writer.writerow({  # écriture des lignes, précision pour chaque colonne
                "person_id": userId,  # id
                "Prefix": fake.prefix(),  # préfixe
                "first_name": fake.name(),  # nom
                "last_name": fake.name(),  # nom2
                "Birth Date": fake.date(pattern="%d-%m-%Y", end_datetime=datetime.date(2010, 1, 1)),
                "Phone Number": fake1.phone_number()  # numéro de tel
            })


if __name__ == '__main__':
    records = 10000  # nombre de lignes à génerer
    headers = ["person_id", "Prefix", "first_name",
               "last_name", "Birth Date", "Phone Number"]
    print("Veuillez patienter...")
    # lancement de l'écriture dans le fichier CSV
    datagenerate(records, headers)
    print("CSV generation complete!")
