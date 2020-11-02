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

//lorsque l'on clique sur le bouton supprimer renvoie sur la page
if (!empty($_GET['id'])) {
    $numC = $_GET['id'];

$coureur = new Coureur();

if($coureur->delete($numC, "","") ==0 ) {
    // redirige vers la même page sans garder la même valeur de get pour arrêter d'afficher le résultat de la suppression
    $location="../AffichagePHP/choix_action_tdf_coureur.php";
    echo '<META HTTP-EQUIV="refresh" CONTENT="0;URL='.$location.'">';
    echo "<br/> Suppression réussie !";
    exit;
}

}

?>