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

    public function afficherPartiCoureurAnnee($numCoureur, $anneeParticipation)
    {
        $req = "SELECT N_EQUIPE, N_SPONSOR, N_DOSSARD FROM TDF_COUREUR JOIN TDF_PARTI_COUREUR USING (:rnumCoureur) WHERE ANNEE == :rannee";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumCoureur', $numCoureur, 10);
        ajouterParamOCI($cur, ':rannee', $anneeParticipation, 4);
        $res = ExecuterRequeteOCI($cur);
        $afpc = LireDonnneesOCI1($res, $donnees);
        print_r($donnees);
        if(empty($donnees[0]['N_EQUIPE']))
        {
            echo "Aucune équipe trouvée pour ce coureur ou cette année";
        }
        else
        {
            $this->afficherDonnees($donnees);
        }
    }

    public function afficherPartisCoureur($numCoureur)
    {
        $req = "SELECT DISTINCT NOM as \"NOM DE L'EQUIPE\", N_DOSSARD FROM TDF_PARTI_COUREUR JOIN TDF_SPONSOR USING (N_EQUIPE, N_SPONSOR) WHERE N_COUREUR==:rcoureur";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumCoureur', $numCoureur, 10);
        $res = ExecuterRequeteOCI($cur);
        $afpc = LireDonnneesOCI1($res, $donnees);
        print_r($donnees);
        if(empty($donnees[0]['N_EQUIPE']))
        {
            echo "Aucune équipe trouvée pour ce coureur ou cette année";
        }
        else
        {
            $this->afficherDonnees($donnees);
        }
    }

    public function afficherDonnees($donnees)
    {
        foreach($donnees as $ligne)
        {
            foreach($ligne as $valeur)
                echo $valeur." ";
            echo "<br/>";
        }
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
        $comitted = ValiderTransacOCI($this->_conn);
    }

}

?>