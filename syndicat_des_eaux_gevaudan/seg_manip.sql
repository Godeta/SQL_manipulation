--création de la table SEG alimenter Secours

create table seg_alimenter_secours (
res_code varchar(5) not null,
cap_code varchar(5) not null,
tec_matricule varchar(5) not null,
als_remarque varchar(70),
constraint pk_res_cap_code primary key (res_code,cap_code)
);

-- mise à jour de données
--insérer valeur, insérer un technicien T11 (ne rien insérer dans TEC_TELEPHONE)
insert into seg_technicien (tec_matricule,tec_nom,tec_prenom)
values ('T11','Porcq','Eric');
--verif
SELECT * FROM SEG_TECHNICIEN order by tec_matricule;

--mettre à jour valeur
--Modifier dans Alimenter_secours le code du technicien Fabien TROJ par celui de Philippe SUTURB.
update seg_alimenter_secours
set tec_matricule = (select tec_matricule from seg_technicien where tec_nom='SUTURB' and tec_prenom='Philippe') 
where tec_matricule = (select tec_matricule from seg_technicien where tec_nom='TROJ' and tec_prenom='Fabien');

--suppression
--Supprimer les analyses qui contiennent plus de 17mg de plomb.
delete from seg_contenir
where con_quantite>17;
--verif 
select * from seg_analyse join seg_contenir using (ana_id);

-- requêtes projection

--1. Donner la liste des techniciens en affichant leur matricule, leur prénom, la première lettre de leur nom suivi de 3 " * ".
select tec_matricule,tec_prenom,concat(substr(tec_nom,1,1),'***')
from seg_technicien;

--2. Afficher toutes les informations des techniciens et le nom des captages de secours dont ils ont la charge

