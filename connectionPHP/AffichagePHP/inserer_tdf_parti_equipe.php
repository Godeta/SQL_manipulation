<?php
session_start();
include_once '../generique/util_chap9.php';

include_once '../generique/fonc_oracle.php';
include_once '../classesPHP/classe_equipe.php';

$equipe=new Equipe();

include_once '../Affichage/inserer_tdf_parti_equipe.htm';

$date = date('d/m/Y', time());
if((!empty($_POST['annee'])) && (!empty($_POST['nEquipe'])) && (!empty($_POST['nSponsor'])) && (!empty($_POST['preDirecteur'])) && (!empty($_POST['coDirecteur']))){
        if($equipe->insertParti($_POST['annee'],$_POST['nEquipe'],$_POST['nSponsor'],$_POST['preDirecteur'],$_POST['coDirecteur'],$date) ==0 ) {
                echo "<span class = \"feedbackPositif\"><br/> Insertion réussie !</span>";
                }
        }
?>