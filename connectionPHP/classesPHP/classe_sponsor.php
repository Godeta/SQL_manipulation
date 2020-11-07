<?php

include_once '../generique/util_chap11.php';
include_once '../generique/regex.php';
include_once '../generique/chaine.php';



class Sponsor
{
    public $_conn;

    function __construct()
    {
        $this->_conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    function calculNumSponsor($nequipe)
{
    $req = "SELECT max(n_sponsor)as num from tdf_sponsor where n_equipe=".$nequipe;
    $cur = PreparerRequeteOCI($this->_conn, $req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur, $donnees);
    if (($donnees[0]['NUM'])==null){
        return 0;
    }
    return (intval($donnees[0]['NUM']) + 1);
}

public function insert($crea, $dispa)
    {
        $reqInsert = "INSERT INTO tdf_sponsor(n_equipe,n_sponsor,code_cio,nom,na_sponsor,annee_sponsor) VALUES(:rid,:ridspo,:rcio,:rnom,:rna,:rannee)";
        if (!empty($_POST['nEquipe'])) {
            $id = $this->calculNumEquipe($this->_conn);
            $cur = PreparerRequeteOCI($this->_conn, $reqInsert);
            ajouterParamOCI($cur, ":requipe", $id, 32);
            ajouterParamOCI($cur, ":rcrea", $crea, 4);
            ajouterParamOCI($cur, ":rdispa", $dispa, 4);
            $res = ExecuterRequeteOCI($cur);
            $comitted = ValiderTransacOCI($this->_conn);
            return 0;
        }
    }
}
