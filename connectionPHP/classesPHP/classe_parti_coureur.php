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

    //Fonction qui insert une participation d'un coureur au tour de France.
    //Prend en paramètre le numéro du coureur, de l'équipe, du sponsor, l'année de participation au tdf, le numéro de dossard, si il est jeune et si il est valide.
    //Retourne true si s'est exécuté sans soucis et false si non.
    public function ajouterPartiCoureur($numCoureur, $numEquipe, $numSponsor, $anneeParticipation, $numDossard, $jeune, $valide, $date)
    {
        $req = "INSERT INTO TDF_PARTI_COUREUR (N_COUREUR, N_EQUIPE, N_SPONSOR, ANNEE, N_DOSSARD, JEUNE, VALIDE, date_insert) VALUES (:rnumCoureur, :rnumEquipe, :rnumSponsor, :rannee, :rnumDossard, :rjeune, :rvalide, :rdate)";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumCoureur', $numCoureur, 32);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe, 32);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor, 32);
        ajouterParamOCI($cur, ':rannee', $anneeParticipation, 32);
        ajouterParamOCI($cur, ':rnumDossard', $numDossard, 32);
        ajouterParamOCI($cur, ':rjeune', $jeune, 32);
        ajouterParamOCI($cur, ':rvalide', $valide, 32);
        ajouterParamOCI($cur, ':rdate', $date, 32);
        $res = ExecuterRequeteOCI($cur);
        if($res)
        {
            $comitted = ValiderTransacOCI($this->_conn);
            return $comitted;
        }
    }

    //Fonction qui vérifie si un coureur fait partie de la table tdf_part_coureur.
    //Prend en paramètres le numéro du coureur et l'année de sa participation.
    //Retourne faux si le coureur à déjà une participation pour l'année demandée true si non.
    public function verifPartiCoureur($numCoureur, $annee)
    {
        $req = "SELECT count(*) as \"EXISTE\" FROM TDF_PARTI_COUREUR WHERE N_COUREUR=:rnumCoureur AND ANNEE=:rannee";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, 'rnumCoureur', $numCoureur);
        ajouterParamOCI($cur, ':rannee', $annee);
        $res = ExecuterRequeteOCI($cur);
        LireDonneesOCI1($cur, $donnees);
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

    //Fonction qui vérifie si une équipe de la table tdf_parti_coureur possède des membres ou non.
    //Prend en paramètres le numéro de l'équipe, du sponsor et l'année de participation.
    //Retourne true si l'équipe ne possède aucun membre, false si non.
    public function verifEquipeVide($numEquipe, $numSponsor, $annee)
    {
        $req = "SELECT count(*) as NBCOUREUR FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rannee', $annee);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor);
        ExecuterRequeteOCI($cur);
        LireDonneesOCI1($cur,$donnees);
        if($donnees[0]['NBCOUREUR']==0)
        {
            return True;
        }
        else 
        {
            return False;
        }
    }

    //Fonction qui vérifie si une équipe de la table tdf_parti_coureur possède tous ses membres ou non.
    //Prend en paramètres le numéro de l'équipe, du sponsor et l'année de participation.
    //Retourne true si l'équipe ne possède pas tous ses membres, false si non.
    public function verifEquipeNonComplete($numEquipe, $numSponsor, $annee)
    {
        $req = "SELECT count(*) as NBCOUREUR FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rannee', $annee);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor);
        ExecuterRequeteOCI($cur);
        LireDonneesOCI1($cur,$donnees);
        if($donnees[0]['NBCOUREUR']!=9)
        {
            return True;
        }
        else 
        {
            return False;
        }
    }

    //Fonction qui vérifie si un numéro de dossard est déjà prit pour une année.
    //Prend en paramètres l'année de participation et le numéro de dossard.
    //Retourne true si le numéro de dossard existe déjà, false si non.
    public function verifDossardExiste($annee, $numDossard)
    {
        $req = "SELECT count(*) as NBDOSSARD FROM TDF_PARTI_COUREUR WHERE ANNEE=:rannee AND N_DOSSARD=:rnumDossard";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rannee', $annee);
        ajouterParamOCI($cur, ':rnumDossard', $numDossard);
        ExecuterRequeteOCI($cur);
        LireDonneesOCI1($cur,$donnees);
        if($donnees[0]['NBDOSSARD']!=0)
        {
            return True;
        }
        else 
        {
            return False;
        }
    }


    //Fonction qui attribue automatiquement un numéro de dossard un membre d'une équip qui possède déjà son premier membre.
    //Prend en paramètre le numéro de l'équipe, du sponsor et l'année de participation.
    //Retourne le numéro de dossard.
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
                LireDonneesOCI1($cur,$donnees);
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