<?php

include_once '../generique/util_chap11.php';
include_once '../generique/regex.php';
include_once '../generique/chaine.php';



class Etape
{
    public $_conn;

    function __construct()
    {
        $this->_conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    function remplirEtape($donnees)
    {
        echo "<option value=\"\"";
        echo VerifierSelect("cat_code","");
        echo ">";
        echo "</option>";
        for ($i = 0; $i < count($donnees); $i++) {
            echo "<option value=\"".$donnees[$i]['CAT_CODE']."\"";
            echo VerifierSelect("cat_code",$donnees[$i]['CAT_CODE']);
            echo ">";
            echo $donnees[$i]['CAT_CODE'];
            echo "</option>";
        }
    }

    function typeEtape(){
        $req="select distinct cat_code from tdf_etape order by cat_code asc";
        $cur = PreparerRequeteOCI($this->_conn,$req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur,$donnees);
        return $donnees;
    }

    public function insert($annee,$n_epreuve,$cat_code,$jour,$ville_a,$ville_d,$cioa,$ciod,$distance,$moyenne,$date)
    {
        $reqInsert = "INSERT INTO tdf_etape(annee,n_etape,n_comp,cat_code,datetape,ville_a,ville_d,code_cio_a,code_cio_d,distance,moyenne,date_insert) VALUES(:rannee,:rid,:rcomp,:rcat,:rjour,:rvillea,:rvilled,:rcioa,:rciod,:rdist,:rmoy,:rdatte)";
            $cur = PreparerRequeteOCI($this->_conn, $reqInsert);
            ajouterParamOCI($cur, ":rannee", $annee, 30);
            ajouterParamOCI($cur, ":rid", $n_epreuve, 30);
            $temp=" ";
            ajouterParamOCI($cur, ":rcomp", $temp, 30);
            ajouterParamOCI($cur, ":rcat", $cat_code, 30);
            ajouterParamOCI($cur, ":rjour", $jour, 30);
            ajouterParamOCI($cur, ":rvillea", $ville_a, 30);
            ajouterParamOCI($cur, ":rvilled", $ville_d, 30);
            ajouterParamOCI($cur, ":rcioa", $cioa, 30);
            ajouterParamOCI($cur, ":rciod", $ciod, 30);
            ajouterParamOCI($cur, ":rdist", $distance, 30);
            ajouterParamOCI($cur, ":rmoy", $moyenne, 30);
            ajouterParamOCI($cur, ":rdatte", $date, 30);
            $res = ExecuterRequeteOCI($cur);
            $comitted = ValiderTransacOCI($this->_conn);
            return 0;
    }
}
