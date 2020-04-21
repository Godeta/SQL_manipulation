--objectif : charger un csv de 10 000 sons et le nettoyer avec delete puis analyser les données

--création de la table
drop table song;
create table song (
song_id serial not null,
title varchar(1000),
artist varchar(1000),
album varchar(1000),
year_released varchar(30),
duration numeric, --accepte les virgules
tempo numeric,
loudness numeric,
constraint song_id_pk primary key (song_id)
);

--importation des données dans pgadmin directement c'est plus simple
COPY song(song_id,title,artist,album,year_released,duration,tempo,loudness) 
FROM './songs.csv' DELIMITER ';' CSV HEADER;

--affichage

select count(*) as nombre_lignes from song;
select * from song;

select min(year_released) as son_plus_ancien, max(year_released) as plus_recent from song;
--on voit que le plus ancien est en l'an 0, il ne peut pas y avoir de son de cette époque donnée invalide
select distinct year_released 
from song
order by year_released; 
--on voit 0 puis 1926,1940... donc 0 était une valeur de base donnée pour des sons dont la date est inconnue !

select count(*) as nb_son_date_inconnue
from song
where year_released ='0';

--enlever les sons dont la date de sortie est inconnue
delete from song 
where year_released ='0';

--on vérifie pour le tempo
select min(tempo) as tempo_min, max(tempo) as tempo_max from song;
--un tempo de 0 est impossible !!!
select * from song where tempo = '0';
--on les enlève
delete from song where tempo ='0'; 

--durée
select min(duration) as plus_courte_musique, max(duration) as plus_longue_musique from song;
--loudness -> toujours inférieur à 0, plus il se rapproche de 0 plus c'est fort
select min (loudness) as son_le_moins_fort, max(loudness) as son_le_plus_fort from song;
--on enlève les incohérences
delete 
from song
where loudness >0;

--comment le tempo à évolué au fur et à mesure du temps ?
select year_released, round(avg(tempo),2) as moyenne_tempo --fait la moyenne des tempos par années arrondie 2 chiffres après la virgule
from song
group by year_released
order by year_released;