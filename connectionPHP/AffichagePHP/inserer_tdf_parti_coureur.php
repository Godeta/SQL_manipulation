<?php
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../classesPHP/classe_parti_coureur.php';
include_once '../classesPHP/classe_equipe.php';
include_once '../generique/util_chap9.php';

$coureur= new Coureur();
$partiCoureur = new PartiCoureur();
$equipe = new Equipe();
include_once '../Affichage/inserer_tdf_parti_coureur.htm';

include_once '../generique/fonc_oracle.php';

if(!empty($_POST['numCoureur']) && !empty($_POST['annee']) && !empty($_POST['numEquipe']) && !empty($_POST['numSponsor']))
{
    if($partiCoureur->verifPartiCoureur($_POST['numCoureur'], $_POST['annee']))
    {
        if($equipe->verifEquipeExiste($_POST['numEquipe'], $_POST['numSponsor']))
        {
            if($equipe->verifEquipeExisteAnnee($_POST['numEquipe'], $_POST['numSponsor'], $_POST['annee']))
            {
                if((empty($_POST['valide']) || $_POST['valide']=='O'))
                {
                    if(empty($_POST['valide']))
                    {
                        $valide = 'R';
                    }
                    else 
                    {
                        $valide = $_POST['valide'];
                    }
                    if((empty($_POST['jeune']) || $_POST['jeune']=='o'))
                    {
                        $jeune = $_POST['jeune'];
                        if(empty($_POST['numDossard']))
                        {
                            if($partiCoureur->verifEquipeNonComplete($_POST['numEquipe'], $_POST['numSponsor'], $_POST['annee']))
                            {
                                $numDossard = $partiCoureur->attribuerNumDossard($_POST['numEquipe'], $_POST['numSponsor'], $_POST['annee']);
                                if($partiCoureur->ajouterPartiCoureur($_POST['numCoureur'], $_POST['numEquipe'], $_POST['numSponsor'], $_POST['annee'], $numDossard, $jeune, $valide))
                                {
                                    echo "<span class=\"feedbackNegatif\">Insertion réussie !";
                                }
                                else 
                                {
                                    echo "<span class=\"feedbackNegatif\">Insertion échouée !";
                                }
                            }
                        }
                        else 
                        {
                            if($partiCoureur->verifEquipeVide($_POST['numEquipe'], $_POST['numEquipe'], $_POST['annee']))
                            {
                                if(!$partiCoureur->verifDossardExiste($_POST['annee'], $_POST['numDossard']))
                                {
                                    if($partiCoureur->ajouterPartiCoureur($_POST['numCoureur'], $_POST['numEquipe'], $_POST['numSponsor'], $_POST['annee'], $numDossard, $jeune, $valide))
                                {
                                    echo "<span class=\"feedbackNegatif\">Insertion réussie !</span>";
                                }
                                else 
                                {
                                    echo "<span class=\"feedbackNegatif\">Insertion échouée !</span>";
                                }
                                }
                                else 
                                {
                                    echo "<span class=\"feedbackNegatif\">Numéro de dossard déjà existant !</span>";
                                }
                            }
                            else 
                            {
                                echo "<span class=\"feedbackNegatif\">L'équipe possède déjà un coureur !</span>";
                            }
                        }
                    }
                    else
                    {
                        echo "<span class=\"feedbackNegatif\">Maivaise valeur de jeune !</span>";
                    }
                }
                else 
                {
                    echo "<span class=\"feedbackNegatif\">Mauvaise valuer pour valide !</span>";
                }
                
            }
        }
    }
}
?>