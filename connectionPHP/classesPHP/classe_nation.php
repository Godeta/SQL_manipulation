<?php

include_once "../generique/fonc_oracle.php";

class Nation
{
    public $_conn;

    function __construct()
    {
        $this->_conn=OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    function remplirNation($donnees)
    {
        echo "<option value=\"NULL\"";
        echo VerifierSelect("pays","NULL");
        echo ">";
        echo "</option>";
        for ($i = 0; $i < count($donnees); $i++) {
            echo "<option value=\"".$donnees[$i]['CODE_CIO']."\"";
            echo VerifierSelect("pays",$donnees[$i]['CODE_CIO']);
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

    function insertion($code){
        $req="insert into tdf_app_nation (CODE_CIO,N_COUREUR) VALUES (:rcode, :rid)";
        $cur=PreparerRequeteOCI($this->_conn,$req);
        $id=dernierNumCoureur($this->_conn);
        ajouterParamOCI($cur, ":rid", $id,32);
        ajouterParamOCI($cur, ":rcode", $code, 3);
        $res = ExecuterRequeteOCI($cur);
        $comitted = ValiderTransacOCI($this->_conn);
        return 0;
    }
}
