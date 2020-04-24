-- Donner la liste des clients du calvados class�s par ville d�croissant et nom croissant
select * from cl_client 
order by cli_ville desc, cli_nom;

--Afficher les pr�nom et noms des clients fid�lis�s et la ville des agences o� ils ont d�j� emprunt� un v�hicule (regardez bien la
--capture)
select concat(cli_nom,' ') ||cli_prenom as client, age_ville --avec oracle concat seule 2 string
from cl_client
join cl_agence using (pay_code);

--Afficher les 5 agences de plus grand code postal.
select age_cpostal from cl_agence
where  rownum <=5 
order by age_cpostal desc;

--