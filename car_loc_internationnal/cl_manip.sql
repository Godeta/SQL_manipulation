-- Donner la liste des clients du calvados classés par ville décroissant et nom croissant
select * from cl_client 
order by cli_ville desc, cli_nom;

--Afficher les prénom et noms des clients fidélisés et la ville des agences où ils ont déjà emprunté un véhicule (regardez bien la
--capture)
select concat(cli_nom,' ') ||cli_prenom as client, age_ville --avec oracle concat seule 2 string
from cl_client
join cl_agence using (pay_code);

--Afficher les 5 agences de plus grand code postal.
select age_cpostal from cl_agence
where  rownum <=5 
order by age_cpostal desc;

--