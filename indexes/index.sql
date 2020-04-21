--creation d'une table contenant 100,000,000 lignes, il va donc falloir utiliser des index pour optimiser le traitement des données

drop table person;
create table person (
person_id serial not null,
prefix varchar(10),
first_name varchar(30),
last_name varchar(30),
birthday varchar(10),
phone_number varchar(30),
constraint person_di_pk primary key (person_id)
);

--insertion des données
--importation des données dans pgadmin directement c'est plus simple

select count(*) as nombre_lignes from person;
--150 millisecondes pour cette requête !
select count(*) as nombre_lignes from person where last_name ='Smith';
-- 156 milliseconde
select count(*) as nombre_lignes from person where first_name ='Emma';
-- 140 milliseconde sans l'index, 2 millisecondes avec l'index  
select count(*) as nombre_lignes from person where birthday like '%1980%'; --le nombre de personnes nées en 1980
--176 millisecondes

select count(*) as nombre_lignes from person where last_name in ('Hawkins', 'Snow');
--170 millisecondes

select count(*) as nombre_lignes from person where first_name = 'Julie' and last_name = 'Andrews';
--33 milisecondes grâce à l'index first name qui a un effet dès que l'on cherche une colonne avec le prénom
-- 2 millisecondes grâce à l'index first and last name


select count(*) as nombre_lignes from person where first_name = 'John' and last_name = 'Williams';
-- 3 millisecondes grâce à l'index first and last name

select count(*) as nombre_lignes from person where birthday = '13-02-1970' and first_name = 'Rebecca';
--33 milisecondes grâce à l'index qui a un effet dès que l'on cherche une colonne avec le prénom

--note : les index prennent de la place de stockage et lorsque l'on ajoute des données cela change l'index, sinon c'est super efficace pour optimiser les recherches

create index person_first_name_idx --création d'un index qui contient toute la colonne first_name et permet de rendre les requêtes plus rapides
on person (first_name);
--2,8 s

create index  person_first_and_last_name_idx
on person (first_name,last_name);
-- 4,9 s
