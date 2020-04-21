--creation d'une table contenant 100,000,000 lignes, il va donc falloir utiliser des index pour optimiser le traitement des données

drop table person;
create table person (
person_id serial not null,
first_name varchar(30),
last_name varchar(30),
birthday date,
constraint person_di_pk primary key (person_id)
);