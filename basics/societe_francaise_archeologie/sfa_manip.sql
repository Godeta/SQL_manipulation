--modélisation
--vil_code dans la table sfa_objet permet avec sit_code d'avoir la clé primaire de la table sfa_site et donc de relier les deux tables,
--on prend donc toute la clé primaire

--Un index est utile lorsque l'on souhaite optimiser la vitesse d'une requête, si on utilise une table présente dans un index
--lors d'une requête alors elle sera plus rapide.

--La requête : select * from sfa_ouvrage where ouv_titre like 'Archeologie%' or ouv_titre like 'La momification%';
-- pourrait être optimisée car on demande ici tout ce qui commence par Archeologie or dans la table Archeologie est le nom entier
-- On pourrait donc faire : 
select * from sfa_ouvrage where ouv_titre = 'Archeologie' or ouv_titre = 'La momification';

--création de la table Objet
create table SFA_OBJET
(
    OBJ_NUM number(3)  not null,
    SIT_CODE number(3)  not null,
    VIL_CODE number(4)  not null,
    MUS_CODE number(3)  not null,
    OBJ_DESIGNATION varchar2(64)  null,
    OBJ_TYPE varchar2(32)  null,
    OBJ_ANNEE number(4)  null,
    constraint pk_objet primary key (obj_num)  
);

CREATE  INDEX I_FK_SFA_OBJET_SFA_SITE
     ON SFA_OBJET (VIL_CODE ASC, SIT_CODE ASC);

CREATE  INDEX I_FK_SFA_OBJET_SFA_MUSEE
     ON SFA_OBJET (MUS_CODE ASC);
     
alter table sfa_objet add (
     constraint fk_objet_vil_sit_code
          foreign key (vil_code, sit_code)
               references sfa_site (vil_code, sit_code));

ALTER TABLE SFA_OBJET ADD (
     CONSTRAINT FK_SFA_OBJET_SFA_MUSEE
          FOREIGN KEY (MUS_CODE)
               REFERENCES SFA_MUSEE (MUS_CODE));

--mise à jour de données
--Enregistrer un nouvel ouvrage en n'écrivant que dans les colonnes ouv_num,ouv_titre et ouv_nb_pages. ouv_num doit être calculé
--automatiquement.
insert into sfa_ouvrage (ouv_num,ouv_titre,ouv_nb_pages,edi_num) --edi_num ne peut pas être null
values (50,'SQL pour les nuls',999,70); --il faut que ouv_num ai la propriété auto_increment
select * from sfa_ouvrage;
--Supprimer les ouvrages dont l'éditeur est Grasset
delete from sfa_ouvrage where edi_num = (select edi_num from sfa_editeur where edi_rais_soc = 'Grasset');
--il faut que les enfants soient déclarés "on delete cascade" 

--Placer tous les objets de type " coupe " au Louvre
update sfa_objet
set mus_code = (select mus_code from sfa_musee where mus_nom = 'Le Louvre')
where obj_type = 'coupe';

--requêtes de projection
--1. Afficher le nombre d'objets de la table Objet
select count(*) from sfa_objet;

--2. Afficher le ou les objets dont l’année est la plus récente.
select * from sfa_objet where obj_annee in (select max(obj_annee) from sfa_objet);

--3. Afficher les villes sans musée
select * from sfa_ville where vil_code not in
( select vil_code from sfa_musee);

--4. Afficher le titre, l''âge des ouvrages en jours et en année
select ouv_titre, round(trunc(sysdate-ouv_date_edition)/365,2)||' ans' as age_annees,trunc(sysdate-ouv_date_edition)|| ' jours' as age_jours
from sfa_ouvrage;

--5 Donner le nombre d'ouvrages par éditeur (edi_num) avec le nombre d'ouvrages total. Donner une solution avec le total à droite
--de chaque ligne et une solution avec le total en dernière ligne
--solution 1
select edi_num,count(*) as nb_ouvrage_par_editeur, (select count(*) as nb_total from sfa_ouvrage)
from sfa_ouvrage
group by edi_num;

--solution 2
select to_char(edi_num) as numero_editeur,count(*) as nb_ouvrage_par_editeur
from sfa_ouvrage
group by edi_num
union all
select 'Total' ,count(*) as nb_total 
from sfa_ouvrage;

--6. Afficher le nom des éditeurs(edi_rais_soc) avec la somme des pages d'ouvrages qu'ils ont publiés
select edi_rais_soc, sum(ouv_nb_pages) as somme_pages_publiées
from sfa_editeur join sfa_ouvrage using(edi_num)
group by (edi_rais_soc);

--7. Même question mais en ne conservant que ceux qui ont publiés plus de la moyenne de pages de tous les ouvrages
select edi_rais_soc, sum(ouv_nb_pages) as somme_pages_publiées
from sfa_editeur join sfa_ouvrage using(edi_num)
having sum(ouv_nb_pages) > (
select avg(somme_pages) from (
select sum(ouv_nb_pages) as somme_pages from sfa_ouvrage 
group by edi_num)
)
group by (edi_rais_soc);