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
        return 1;
    }
    return (intval($donnees[0]['NUM']) + 1);
}

public function insert($nequipe,$cio,$nom,$noma,$annee,$date)
    {
        $reqInsert = "INSERT INTO tdf_sponsor(n_equipe,n_sponsor,code_cio,nom,na_sponsor,annee_sponsor,date_insert) VALUES(:rid,:ridspo,:rcio,:rnom,:rna,:rannee,:rdate)";
            $idspo = $this->calculNumSponsor($nequipe);
            $cur = PreparerRequeteOCI($this->_conn, $reqInsert);
            ajouterParamOCI($cur, ":rid", $nequipe, 32);
            ajouterParamOCI($cur, ":ridspo", $idspo, 32);
            ajouterParamOCI($cur, ":rcio", $cio, 3);
            ajouterParamOCI($cur, ":rnom", $nom, 32);
            ajouterParamOCI($cur, ":rna", $noma, 3);
            ajouterParamOCI($cur, ":rannee", $annee, 4);
            ajouterParamOCI($cur, ":rdate", $date, 12);
            $res = ExecuterRequeteOCI($cur);
            $comitted = ValiderTransacOCI($this->_conn);
            return 0;
    }
    //Fonction permettant de supprimer un sponsor. 
    public function delete($id)
    {
        $reqDelete = "DELETE from tdf_sponsor where n_sponsor = ':rid'";
                ajouterParamOCI($cur, ":rid", $id, 10);
                echo "<script> alert(\"Si ce sponsor a des participations dans le tour de France il ne sera pas supprimé.\"); </script>";
                $res = ExecuterRequeteOCI($cur);
                $comitted = ValiderTransacOCI($this->_conn);
                return 0;
    }
}
