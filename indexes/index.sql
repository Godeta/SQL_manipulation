--creation d'une table contenant 100,000,000 lignes, il va donc falloir utiliser des index pour optimiser le traitement des donn�es

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

--insertion des donn�es
--importation des donn�es dans pgadmin directement c'est plus simple

select count(*) as nombre_lignes from person;