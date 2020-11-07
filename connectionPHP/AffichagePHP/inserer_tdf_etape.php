<?php
session_start();
include_once '../generique/util_chap9.php';
include_once '../generique/fonc_oracle.php';
include_once '../classesPHP/classe_nation.php';
include_once '../classesPHP/classe_etape.php';

$nation=new Nation();
$etape=new Etape();


include_once '../Affichage/inserer_tdf_etape.htm';

$date = date('d/m/Y', time());
if(!empty($_POST['annee']) && !empty($_POST['nEtape']) && !empty($_POST['villeD']) && !empty($_POST['villeA']) && !empty($_POST['jour']) && !empty($_POST['cat_code']) && !empty($_POST['code_cio_a']) && !empty($_POST['code_cio_d']) && ($_POST['code_cio_a']!="NULL") && ($_POST['code_cio_d']!="NULL") && ($_POST['cat_code']!="NULL")){
        if($etape->insert($_POST['annee'],$_POST['nEtape'],$_POST['cat_code'],$_POST['jour'],$_POST['villeA'],$_POST['villeD'],$_POST['code_cio_a'],$_POST['code_cio_d'],$_POST['distance'],$_POST['moyenne'],$date) ==0 ) {
                echo "<span class = \"feedbackPositif\"><br/> Insertion réussie !</span>";
                }
        }
?>