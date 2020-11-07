<?php
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../classesPHP/classe_nation.php';
include_once '../generique/util_chap9.php';
$coureur = new Coureur();
$nation = new Nation();
include_once '../Affichage/inserer_tdf_coureur.htm';

include_once '../generique/fonc_oracle.php';

$date = date('d/m/Y', time());
if(isset($_POST['annee_naissance'])) {
        if($coureur->insert($_POST['nouvNom'], $_POST['nouvPrenom'],$_POST['annee_naissance'], $_POST['annee_prem'],$date) ==0 ) {
                echo "<span class = \"feedbackPositif\"><br/> Insertion réussie !</span>";
                                $nation->insertion($_POST['pays'],$_POST['annee_debut'],$_POST['annee_fin']);
                }

        }

?>