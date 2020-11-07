<?php

include_once "../generique/fonc_oracle.php";
include_once '../generique/regex.php';

class Nation
{
    public $_conn;

    function __construct()
    {
        $this->_conn=OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    function remplirNation($donnees,$name)
    {
        echo "<option value=\"\"";
        echo VerifierSelect($name,"");
        echo ">";
        echo "</option>";
        for ($i = 0; $i < count($donnees); $i++) {
            echo "<option value=\"".$donnees[$i]['CODE_CIO']."\"";
            echo VerifierSelect($name,$donnees[$i]['CODE_CIO']);
            echo ">";
            echo $donnees[$i]['NOM'];
            echo "</option>";
        }
    }


    function nationalite(){
        $req="select distinct code_cio,nom from tdf_nation order by nom asc";
        $cur = PreparerRequeteOCI($this->_conn,$req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur,$donnees);
        return $donnees;
    }

    function insertion($code,$debut,$fin){
        $req="insert into tdf_app_nation (CODE_CIO,N_COUREUR,ANNEE_DEBUT,ANNEE_FIN) VALUES (:rcode, :rid,:rdebut,:rfin)";
        $cur=PreparerRequeteOCI($this->_conn,$req);
        $id=dernierNumCoureur($this->_conn);
        ajouterParamOCI($cur, ":rid", $id,32);
        ajouterParamOCI($cur, ":rcode", $code, 3);
        if($this->verifAnnees($debut, $fin)) {
        ajouterParamOCI($cur, ":rdebut", $debut,8);
        ajouterParamOCI($cur, ":rfin", $fin, 8);
        // echo ("Valeurs : $code, $id, $debut, $fin");
        }
        else {
            echo "Erreur de verification des années";
            return -1;
        }
        $res = ExecuterRequeteOCI($cur);
        $comitted = ValiderTransacOCI($this->_conn);
        return 0;
    }

    // Vérifie si les années entrées respectent le format de la base de données ou son nulles.
    // Prend en paramètre les années de naissance et de première participation du coureur.
    // Renvoie "True" si conforme ou "False" autrement.
    public function verifAnnees($annee_nai, $annee_prem)
    {
        if (empty($annee_nai) || verif_annee_nai($annee_nai)) {
            if (empty($annee_prem) || verif_annee_prem($annee_prem)) {
                return true;
            } else {
                echo "L'année de première participation $annee_prem ne respecte pas le format imposé !";
            }
        } else {
            echo "La date de naissance $annee_nai ne respecte pas le format imposé !";
        }
        return false;
    }
}
