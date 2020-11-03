<?php

include_once "../generique/fonc_oracle.php";

class Sponsor
{
    private $_conn;

    function __construct()
    {
        $this->_conn=OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    private function verifEquipeExiste($numEquipe)
    {
        $req = "SELECT N_EQUIPE FROM TDF_EQUIPE WHERE N_EQUIPE==:rnumEquipe";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe, 10);
        
    }

    public function insererNouveauSponsor($numEquipe, $numSponsor, $codeTDF, $nom, $naSponsor,$annee_sponsor)
    {
        
    }
}

?>