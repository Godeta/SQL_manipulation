<?php 
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../generique/util_chap9.php';
include_once '../Affichage/supprimer_tdf_coureur.htm';

include_once '../generique/fonc_oracle.php';

$conn = OuvrirConnexionOCI($_SESSION['ident'],$_SESSION['mdp'], $_SESSION['site']);

$coureur = new Coureur();


if(!empty($_POST['numC']) || (!empty($_POST['suppNom']) && !empty($_POST['suppPrenom']) ))
{
        if($coureur->delete($_POST['numC'], $_POST['suppNom'],$_POST['suppPrenom'], $conn) ==0 ) {
        echo "<br/> Suppression réussie !";
        }
}