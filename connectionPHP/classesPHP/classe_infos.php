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
        $req = "select nom, prenom, count(*) as \"NOMBRE DE VICTOIRES D ETAPE\" from tdf_coureur
        join tdf_temps using (n_coureur) where rang_arrivee = 1 group by nom, prenom order by \"NOMBRE DE VICTOIRES D ETAPE\" desc";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }
}