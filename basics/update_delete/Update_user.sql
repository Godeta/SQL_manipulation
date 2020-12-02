--création de la table

drop table secret_user;

create table secret_user (
user_id serial not null, --serial donc entier qui augmente automatiquement : 1,2,3...
first_name varchar(30),
last_name varchar(30),
code_name varchar(20),
country varchar (30),
organization varchar (40),
salary int,
knows_kung_fu boolean,
constraint secret_user_id_pk primary key (user_id)
);

-- insertion des données
insert into secret_user (first_name, last_name, code_name, country, organization, salary, knows_kung_fu) --pas besoin de mettre user_id car type serial, si on le met on dira valeur default et il se remplira de 1,2,3...
values 
('Jimmy','Bond','007','United Kingdom','MI6','97200',false),
('George', 'Smiley', 'Beggarman', 'United Kingdom', 'MI6', 97200, false),
 ('Jason', 'Bourne', 'Delta One', 'United States', 'CIA', 115000, false),
 ('Jack', 'Ryan', null, 'United States', 'CIA', 85000, false),
 ('Ethan', 'Hunt', 'Bravo Echo 1-1', 'United States', 'IMF', 250000, false),
 ('Emma', 'Peel', 'Mrs. Peel', 'United Kingdom', 'MI6', 97200, true),
 ('Susan', 'Hilton', 'Agent 99', 'United States', 'Control',250000 , false),
 ('Nick', 'Fury', 'Foxtrol', 'United States', 'SHIELD', 250000, false),
 
('Ranma','Dirac','1/2','Japan','Imperial Navy',100000,true);

--updates

--changement d'une valeur
update secret_user
set first_name = 'James'
where user_id = 1;
--changer 2 valeurs
update secret_user
set code_name = 'Neo2.0', salary = 115000
where first_name = 'Jack' and last_name = 'Ryan';

--changer le salaire de tous les membres de MI6
update secret_user
set salary = 115000
where organization = 'MI6';

--des agents on appri le jung_fu
update secret_user 
set knows_kung_fu = true
where user_id IN (5,7,8); --si l'id appartient à la liste

--augmentation des salaires de 10% pour tout le monde !
update secret_user
set salary = 1.1 *salary;

--affichage

--compte les lignes
select count(*) as nombre_lignes from secret_user;
--les affiches dans l'ordre de leur user_id
select * from secret_user order by user_id;
--affiche la somme des salaires
select sum(salary) as total_salaires from secret_user;
