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
}
