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

    function plusDeVictoires()
    {
        echo "<h1>Coureurs ayant plus de 10 victoires d'étape sur le tour</h1>";
        echo "</br>";
        $req = "select nom, prenom, count(*) as \"NOMBRE DE VICTOIRES D ETAPE\" from tdf_coureur
        join tdf_temps using (n_coureur) where rang_arrivee = 1 having count(*)>10 group by nom, prenom order by \"NOMBRE DE VICTOIRES D ETAPE\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function totalCoureurs()
    {
        echo "<p><b>Nombre de coureurs enregistrés dans la base</b></p>";
        $req = "select count(*) as \"NOMBRE DE COUREURS\" from tdf_coureur";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        echo (intval($donnees[0]['NOMBRE DE COUREURS']));
    }

    function etapeDepart()
    {
        echo "<h1>Villes le plus de fois départ</h1>";
        echo "</br>";
        $req = "select ville_d, count(ville_d) as \"NOMBRE DE DEPARTS\" from tdf_etape having count(ville_d)>5 group by ville_d order by \"NOMBRE DE DEPARTS\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function etapeArrivee()
    {
        echo "<h1>Villes le plus de fois arrivée</h1>";
        echo "</br>";
        $req = "select ville_a, count(ville_a) as \"NOMBRE D ARRIVEES\" from tdf_etape having count(ville_a)>5 group by ville_a order by \"NOMBRE D ARRIVEES\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function etapeLongue()
    {
        echo "<p><b>Etape la plus longue</b></p>";
        $req = "SELECT annee,n_etape as \"N°ETAPE\",ville_d as depart,ville_a as arrivee,distance as \"DISTANCE EN KM\",datetape as jour from tdf_etape where distance >=all ( select distance from tdf_etape )";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        echo "Etape n°" . $donnees[0]['N°ETAPE'] . " " . $donnees[0]['DEPART'] . "-" . $donnees[0]['ARRIVEE'] . " datant du " . $donnees[0]['JOUR'] . " : " . $donnees[0]['DISTANCE EN KM'] . "km";
    }

    function etapeCourte()
    {
        echo "<p><b>Etape la plus courte</b></p>";
        $req = "SELECT annee,n_etape as \"N°ETAPE\",ville_d as depart,ville_a as arrivee,distance as \"DISTANCE EN KM\", moyenne as \"MOYENNE EN KM/H\",datetape as jour from tdf_etape where distance <=all ( select distance from tdf_etape )";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        echo "Etape n°" . $donnees[0]['N°ETAPE'] . " " . $donnees[0]['DEPART'] . "-" . $donnees[0]['ARRIVEE'] . " datant du " . $donnees[0]['JOUR'] . " : " . $donnees[0]['DISTANCE EN KM'] . "km";
    }

    function villeEtapes()
    {
        echo "<h1>Villes étapes du tour</h1>";
        echo "</br>";
        $req = "(select distinct ville_d as ville from tdf_etape
        union 
        select distinct ville_a as ville from tdf_etape)";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function paysPresents()
    {
        echo "<h1>Pays visités par le tour</h1>";
        echo "</br>";
        $req = "select distinct nom as pays from tdf_etape et
        join tdf_nation na on et.code_cio_a=na.code_cio
        union
        select distinct nom as pays from tdf_etape et
        join tdf_nation na on et.code_cio_d=na.code_cio";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function nationRepresentees()
    {
        echo "<h1>Nations représentées sur le tour</h1>";
        $req = "select distinct nom from tdf_nation order by nom asc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function equipes()
    {
        echo "<h1>Equipes ayant participées au tour</h1>";
        $req = "select n_equipe as \"N°EQUIPE\",tdf_equipe.annee_creation as \"DATE DE CREATION\",tdf_equipe.annee_disparition as \"DATE DE DISPARITION\",tdf_sponsor.nom as \"NOM DU SPONSOR\",tdf_nation.nom as \"NATIONALITE\",annee_sponsor as \"DEBUT DU SPONSORING\" from tdf_equipe 
        join tdf_sponsor using (n_equipe)
        join tdf_nation using (code_cio)
        order by n_equipe,\"DEBUT DU SPONSORING\"";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }
}
