<?php

include_once '../generique/util_chap11.php';
include_once "../generique/fonc_oracle.php";

class PartiCoureur
{
    public $_conn;

    function __construct()
    {
        $this->_conn=OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    public function ajouterPartiCoureur($numCoureur, $numEquipe, $numSponsor, $anneeParticipation, $numDossard, $jeune, $valide)
    {
        $req = "INSERT INTO TDF_PARTI_COUREUR (N_COUREUR, N_EQUIPE, N_SPONSOR, ANNEE, N_DOSSARD, JEUNE, VALIDE) VALUES (:rnumCoureur, :rnumEquipe, :rnumSponsor, :rannee, :rnumDossard, :rjeune, :rvalide)";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumCoureur', $numCoureur, 10);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe, 10);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor, 10);
        ajouterParamOCI($cur, ':rannee', $anneeParticipation, 4);
        ajouterParamOCI($cur, 'rnumDossard', $numDossard, 10);
        ajouterParamOCI($cur, 'rjeune', $jeune, 1);
        ajouterParamOCI($cur, 'rvalide', $valide, 1);
        $res = ExecuterRequeteOCI($cur);
        if($res)
        {
            $comitted = ValiderTransacOCI($this->_conn);
            return $comitted;
        }
    }

    public function verifPartiCoureur($numCoureur, $annee)
    {
        $req = "SELECT count(*) as \"EXISTE\" FROM TDF_PARTI_COUREUR WHERE N_COUREUR=:rnumCoureur AND ANNEE=:rannee";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, 'rnumCoureur', $numCoureur);
        ajouterParamOCI($cur, ':rannee', $annee);
        $res = ExecuterRequeteOCI($cur);
        LireDonneesOCI($cur, $donnees);
        if($donnees[0]['EXISTE']!=0)
        {
            echo "Ce coureur à déjà une participation pour cette année !";
            return FALSE;
        }
        else 
        {
            return True;
        }
    }

    public function verifEquipeVide($numEquipe, $numSponsor, $annee)
    {
        $req = "SELECT count(*) as NBCOUREUR FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rannee', $annee);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor);
        ExecuterRequeteOCI($cur);
        LireDonneesOCI($cur,$donnees);
        if($donnees[0]['NBCOUREUR']==0)
        {
            return True;
        }
        else 
        {
            return False;
        }
    }

    public function verifEquipeNonComplete($numEquipe, $numSponsor, $annee)
    {
        $req = "SELECT count(*) as NBCOUREUR FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rannee', $annee);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor);
        ExecuterRequeteOCI($cur);
        LireDonneesOCI($cur,$donnees);
        if($donnees[0]['NBCOUREUR']!=9)
        {
            return True;
        }
        else 
        {
            return False;
        }
    }

    public function verifDossardExiste($annee, $numDossard)
    {
        $req = "SELECT count(*) as NBDOSSARD FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_DOSSARD=:rnumDossard";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rannee', $annee);
        ajouterParamOCI($cur, ':rnumDossard', $numDossard);
        ExecuterRequeteOCI($cur);
        LireDonneesOCI($cur,$donnees);
        if($donnees[0]['NBDOSSARD']!=0)
        {
            return True;
        }
        else 
        {
            return False;
        }
    }

    public function attribuerNumDossard($numEquipe, $numSponsor, $annee)
    {
        if(!$this->verifEquipeVide($numEquipe, $numSponsor, $annee))
        {
            if($this->verifEquipeNonComplete($numEquipe, $numSponsor, $annee))
            {
                $req = "SELECT max(N_DOSSARD) as DOSSARDMAX FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor";
                $cur = PreparerRequeteOCI($this->_conn, $req);
                ajouterParamOCI($cur, ':rannee', $annee);
                ajouterParamOCI($cur, ':rnumEquipe', $numEquipe);
                ajouterParamOCI($cur, ':rnumSponsor', $numSponsor);
                ExecuterRequeteOCI($cur);
                LireDonneesOCI($cur,$donnees);
                $numDossard = $donnees[0]['DOSSARDMAX']+1;
                return $numDossard;
            }
            else 
            {
                echo "Equipe complète !";
            }
        }
        else 
        {
            echo "Equipe vide ! Donnez le numéro de dossard du premier coureur de l'équipe !";
        }
    }

}

?>