<?php
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../classesPHP/classe_nation.php';
$coureur = new Coureur();
$nation = new Nation();
include_once '../Affichage/inserer_tdf_coureur.htm';

include_once '../generique/fonc_oracle.php';



$date = date('d/m/Y', time());

if(!empty($_POST['nouvNom']) && !empty($_POST['nouvPrenom']))
{
        if($coureur->insert($_POST['nouvNom'], $_POST['nouvPrenom'],$_POST['annee_naissance'], $_POST['annee_prem'],$date) ==0 ) {
                echo "<br/> Insertion réussie !";
        }
}

if(!empty($_POST['pays'])){
        if ($_POST['pays']!="NULL"){
                $nation->insertion($_POST['pays']);
        }
}

?>