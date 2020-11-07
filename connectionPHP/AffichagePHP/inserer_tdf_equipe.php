<?php
session_start();
include_once '../generique/util_chap9.php';
include_once '../classesPHP/classe_equipe.php';
include_once '../generique/fonc_oracle.php';
$equipe=new Equipe();
include_once '../Affichage/inserer_tdf_equipe.htm';

if(isset($_POST['annee_crea'])) {
        if($equipe->insert($_POST['annee_crea'],$_POST['annee_dispa']) ==0 ) {
                echo "<span class = \"feedbackPositif\"><br/> Insertion réussie !</span>";
                }
        }

?>