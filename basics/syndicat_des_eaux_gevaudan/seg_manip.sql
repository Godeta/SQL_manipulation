--création de la table SEG alimenter Secours

create table seg_alimenter_secours (
res_code varchar(5) not null,
cap_code varchar(5) not null,
tec_matricule varchar(5) not null,
als_remarque varchar(70),
constraint pk_alimenter_res_cap_code primary key (res_code,cap_code)
);

--clés étrangères 
alter table seg_alimenter_secours add (
constraint fk_alimenter_matricule
foreign key(tec_matricule)
references seg_technicien(tec_matricule)
);

alter table seg_alimenter_secours add (
constraint fk_alimenter_cap_code
foreign key(cap_code)
references seg_captage(cap_code)
);

alter table seg_alimenter_secours add (
constraint fk_alimenter_res_code
foreign key(res_code)
references seg_reservoir(res_code)
);

--Index
create index i_fk_alimenter_matricule
     on seg_alimenter_secours (tec_matricule);

create index i_fk_alimenter_cap_code
     ON seg_alimenter_secours (cap_code);

create index i_fk_alimenter_res_code
     on seg_alimenter_secours (res_code);

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
where ana_id in (select ana_id from seg_contenir where con_quantite >17) and 
sub_code = (select sub_code from seg_substance where sub_nom = 'plomb') and
res_code in (select res_code from seg_contenir where con_quantite >17) ;
--verif 
select * from seg_analyse join seg_contenir using (ana_id);

-- requêtes projection

--1. Donner la liste des techniciens en affichant leur matricule, leur prénom, la première lettre de leur nom suivi de 3 " * ".
select tec_matricule,tec_prenom,concat(substr(tec_nom,1,1),'***')
from seg_technicien;

--2. Afficher toutes les informations des techniciens et le nom des captages de secours dont ils ont la charge
select tec_matricule,tec_nom,tec_prenom,tec_telephone,cap_nom from seg_technicien 
join seg_alimenter_secours using(tec_matricule)
join seg_captage using (cap_code);

--3. Même question que précédemment sauf que cette fois si, il faut afficher le nom de tous les techniciens, même ceux qui ne
--sont affectés à aucun captage de secours. Pour ces derniers, on écrira " AUCUN " dans cap_nom.
select tec_matricule,tec_nom,tec_prenom,tec_telephone,nvl(cap_nom,'AUCUN') from seg_technicien 
left join seg_alimenter_secours using(tec_matricule)
left join seg_captage using (cap_code)
order by tec_matricule;

--4. Pour chaque substance mesurée (dans seg_contenir), afficher le nom, sub_val_max et la valeur moyenne des quantités
--analysées. La projection devra avoir cette forme (ne pas oublier d'arrondir à deux chiffres après la virgule) :
select sub_nom, round(avg(con_quantite),2) as QuantiteMoyenne, sub_valmax 
from seg_contenir
join seg_substance using (sub_code)
group by (sub_nom,sub_valmax);

--5. Pour chaque substance mesurée (dans seg_contenir), afficher le nom, le nombre de mesures. Sur chaque ligne, afficher en
--outre le nombre total de mesures. 2 solutions sont demandées (voir capture)
--Ne pas oublier d'arrondir à deux chiffres après la virgule.

--solution 1 :
select sub_nom, count(sub_code) as nombre_analyse, sum(count(sub_code)) OVER() as total
from seg_contenir
join seg_substance using (sub_code)
group by (sub_nom,sub_code);

--solution 2 :
select sub_nom, count(sub_code) as nombre_analyse
from seg_contenir
join seg_substance using (sub_code)
group by (sub_nom,sub_code)

union all
select 'total', sum(count(sub_code)) OVER()
from seg_contenir;

--6 On cherche à connaître les mois où le débit moyen est le plus élevé. Afficher le mois et la quantité totale des débits moyens
--par mois pour ceux dont la quantité totale dépasse la moyenne des quantités totales par mois.

--moyenne des sommes par mois
select avg(somme_par_mois) from (
select sum(pos_debit_moyen) as somme_par_mois
from seg_possede
group by (moi_numero)
) somme_par_mois ;

--requête 6
select moi_libelle, sum(pos_debit_moyen) as quantite from seg_possede
join seg_mois using (moi_numero)
having sum(pos_debit_moyen) > (select avg(somme_par_mois) from ( 
select sum(pos_debit_moyen) as somme_par_mois from seg_possede
group by (moi_numero)
) )
group by (moi_libelle,moi_numero);

--PL/SQL
