<?php

include_once '../generique/util_chap9.php';
include_once '../generique/util_chap11.php';
include_once '../generique/chaine.php';



class Infos
{
    public $_conn;

    function __construct()
    {
        $this->_conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    function plusDeVictoires(){
        echo "<h1>Coureurs ayant plus de 10 victoires d'étape sur le tour</h1>";
        echo "</br>";
        $req = "select nom, prenom, count(*) as \"NOMBRE DE VICTOIRES D ETAPE\" from tdf_coureur
        join tdf_temps using (n_coureur) where rang_arrivee = 1 having count(*)>10 group by nom, prenom order by \"NOMBRE DE VICTOIRES D ETAPE\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function totalCoureurs(){
        echo "<h1>Nombre de coureurs enregistrés dans la base</h1>";
        echo "</br>";
        $req = "select count(*) as \"NOMBRE DE COUREURS\" from tdf_coureur";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function etapeDepart(){
        echo "<h1>Ville le plus de fois départ</h1>";
        echo "</br>";
        $req = "select ville_d, count(ville_d) as \"NOMBRE DE DEPARTS\" from tdf_etape having count(ville_d)>5 group by ville_d order by \"NOMBRE DE DEPARTS\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function etapeArrivee(){
        echo "<h1>Ville le plus de fois arrivée</h1>";
        echo "</br>";
        $req = "select ville_a, count(ville_a) as \"NOMBRE D ARRIVEES\" from tdf_etape having count(ville_a)>5 group by ville_a order by \"NOMBRE D ARRIVEES\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function etapeLongue(){
        echo "<h1>Etape la plus longue</h1>";
        echo "</br>";
        $req = "SELECT annee,n_etape as \"N°ETAPE\",ville_d as depart,ville_a as arrivee,distance as \"DISTANCE EN KM\", moyenne as \"MOYENNE EN KM/H\",datetape as jour from tdf_etape where distance >=all ( select distance from tdf_etape )";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
        
    }

    function etapeCourte(){
        echo "<h1>Etape la plus courte</h1>";
        echo "</br>";
        $req = "SELECT annee,n_etape as \"N°ETAPE\",ville_d as depart,ville_a as arrivee,distance as \"DISTANCE EN KM\", moyenne as \"MOYENNE EN KM/H\",datetape as jour from tdf_etape where distance <=all ( select distance from tdf_etape )";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
        
    }
}