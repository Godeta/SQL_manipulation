select * from earthquake; --ctrl fin pour voir les 23119 lignes produites, ce qui veut dire 23119 séisme de magnitude > 5.5 ces 50 dernières années

select count(*) as nombre from earthquake; --retourne le nombre de colonnes, plus rapide

select magnitude,place,occurred_on 
from earthquake 
where occurred_on >= '2010-01-01' and occurred_on <= '2010-12-31'
order by magnitude desc
limit 1; --afficher seulement le premier de tous les séismes en 2010 ordonnés par magnitude 

--voir le premier et dernier séisme
select MIN(occurred_on) as premier, MAX(occurred_on) as dernier
from earthquake;
select min(magnitude),max(magnitude) from earthquake;

select distinct cause from earthquake;
select count(*) as nombre_seisme_naturels
from earthquake
where cause ='earthquake'; --between single quote

drop view nb_nuclear_explosion;
create view nb_nuclear_explosion as 
select count(*) as nombre_seisme_nucle
from earthquake
where cause ='nuclear explosion'; --between single quote
select * from nb_nuclear_explosion;

--les 10 plus gros séismes
select place, magnitude, occurred_on
from earthquake
order by magnitude desc
limit 10;

--compter les aftershock
select count(*) as number_aftershock
from earthquake
where place like '%Honshu%Japan%' --toute place contenant le mot Honshu avant Japan
and occurred_on between '2011-03-11' and '2011-03-18';


