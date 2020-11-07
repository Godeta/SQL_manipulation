<?php
session_start();
include_once '../generique/util_chap9.php';
include_once '../generique/fonc_oracle.php';

include_once '../classesPHP/classe_sponsor.php';
include_once '../classesPHP/classe_nation.php';

$sponsor = new Sponsor();
$nation = new Nation();

include_once '../Affichage/inserer_tdf_sponsor.htm';

$date = date('d/m/Y', time());
if(!empty($_POST['nEquipe']) && !empty($_POST['pays']) && $_POST['pays']!="NULL" && !empty($_POST['nomSponsor'])){
        if($sponsor->insert($_POST['nEquipe'],$_POST['pays'],$_POST['nomSponsor'],$_POST['NomAbr'],$_POST['annee_sponsor'],$date) ==0 ) {
                echo "<span class = \"feedbackPositif\"><br/> Insertion réussie !</span>";
                }
        }
?>