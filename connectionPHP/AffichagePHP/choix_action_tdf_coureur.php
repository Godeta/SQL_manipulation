<?php
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../generique/util_chap9.php';
include_once '../generique/fonc_oracle.php';
include_once '../Affichage/choix_action_tdf_coureur.htm';


// $conn = OuvrirConnexionOCI($_SESSION['ident'],$_SESSION['mdp'], $_SESSION['site']);

// $coureur = new Coureur();


// if(!empty($_POST['numC']) || (!empty($_POST['selectNom']) && !empty($_POST['selectPrenom']) ))
// {
//         if($coureur->select($_POST['numC'], $_POST['selectNom'],$_POST['selectPrenom'], $conn) ==0 ) {
//         echo "<br/> Selection réussie !";
//         }
// }

?>