<?php

include_once "../generique/fonc_oracle.php";

class Equipe
{
    public $_conn;

    function __construct()
    {
        $this->_conn=OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    public function sponsor()
    {
        $req="SELECT DISTINCT n_sponsor as \"NUM\", nom FROM tdf_sponsor order by nom asc";
        $cur = PreparerRequeteOCI($this->_conn,$req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur,$donnees);
        return $donnees;
    }

    public function remplirNomEquipe($donnees)
    {
        echo "<option value=\"NULL\" selected>";
            echo "</option>";
        for ($i = 0; $i < count($donnees); $i++) {
            echo "<option value=\"".$donnees[$i]['NUM']."\">";
            echo $donnees[$i]['NOM'];
            echo "</option>";
        }
    }

    /*public function obtenirEquipe($numSponsor)
    {
        $req="SELECT DISTINCT n_equipe FROM TDF_SPONSOR WHERE n_sponsor==:rnumSponsor order by asc";
        $cur = PreparerRequeteOCI($this->_conn,$req);
        ajouterParam($cur, ':rnumSponsor', $numSponsor);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur,$donnees);
        return $donnees;
    }

    public function remplirNumEquipe($donnees)
    {

    }*/
}

?>