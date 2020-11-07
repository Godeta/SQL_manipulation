<?php
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../classesPHP/classe_parti_coureur.php';
include_once '../classesPHP/classe_equipe.php';
include_once '../generique/util_chap9.php';
include_once '../generique/fonc_oracle.php';

$coureur= new Coureur();
$partiCoureur = new PartiCoureur();
$equipe = new Equipe();

include_once '../Affichage/inserer_tdf_parti_coureur.htm';

$date = date('d/m/Y', time());
if((!empty($_POST['n_Coureur'])) && (!empty($_POST['n_Coureur'])) && (!empty($_POST['numEquipe'])) && (!empty($_POST['numSponsor'])) && (!empty($_POST['numDossard']))) {
    if(empty($_POST['valide'])){
        $valide='R';
    }
    else{
        $valide=0;
    }
        if($partiCoureur->ajouterPartiCoureur($_POST['n_Coureur'], $_POST['numEquipe'],$_POST['numSponsor'], $_POST['annee'],$_POST['numDossard'],$_POST['jeune'],$valide,$date) ==0 ) {
                echo "<span class = \"feedbackPositif\"><br/> Insertion réussie !</span>";
                }

        }


?>