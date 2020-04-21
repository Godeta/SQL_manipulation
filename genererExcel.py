# genère des données random grace à faker et pydbgen
import faker
import pydbgen
from pydbgen import pydbgen
print("import success")
# création d'un objet base de donnée
myDB = pydbgen.pydb()


# File faker\proxy.py", line 83, in __getattribute__
# raise TypeError(msg) erreur génerée ici !!!

# Enlever ça :
#   if attr == 'seed':
#             msg = (
#                 'Calling `.seed()` on instances is deprecated. '
#                 'Use the class method `Faker.seed()` instead.'
#             )
#             raise TypeError(msg)
#         else:

# car MAJ de Faker ^^

# affiche 10 villes avec des noms random
print(myDB.gen_data_series(num=8, data_type='city'))

# genère un fichier excel, il faut installer openpy et ajouter DOmain.txt au dossier !!!
myDB.gen_excel(10000, fields=['name', 'year', 'email', 'license_plate', 'Job title'],
               filename='Employe.xlsx', real_email=True)

print("Le fichier Excel a été généré !!!")
# Attempts to create an Excel file using Pandas excel_writer function. User can specify various data types to be included. All data types (fields) in the Excel file will be of text type. Data types available:

# Name, country, city, real (US) cities, US state, zipcode, latitude, longitude
# Month, weekday, year, time, date
# Personal email, official email, SSN
# Company, Job title, phone number, license plate
# Customization choices are following:

# real_email: If True and if a person's name is also included in the fields, a realistic email will be generated corresponding to the name of the person. For example, Tirtha Sarkar name with this choice enabled, will generate emails like TSarkar21@gmail.com or Sarkar.Tirtha@att.net.
# real_city: If True, a real US city's name will be picked up from a list (included as a text data file with the installation package). Otherwise, a fictitious city name will be generated.
# phone_simple: If True, a 10 digit US number in the format xxx-xxx-xxxx will be generated. Otherwise, an international number with different format may be returned.
# filename: Name of the Excel file to be created or updated. Default file name will be chosen if not specified by user.
