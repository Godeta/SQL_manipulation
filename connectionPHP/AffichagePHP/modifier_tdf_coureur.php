<?php 
session_start();

include_once '../classesPHP/classe_coureur.php';
include_once '../generique/util_chap9.php';
include_once '../Affichage/modifier_tdf_coureur.htm';

include_once '../generique/fonc_oracle.php';

$conn = OuvrirConnexionOCI($_SESSION['ident'],$_SESSION['mdp'], $_SESSION['site']);

$coureur = new Coureur();

// vérification que l'identification du coureur est remplie
if(!empty($_POST['numC']) || (!empty($_POST['changNomA']) && !empty($_POST['changPrenomA']) ))
{
    // vérification que le choix et la valeur de modification sont remplis
    if (!empty($_POST['changValN']) && !empty($_POST['valType'])) {
        if($coureur->update($_POST['numC'], $_POST['changNomA'],$_POST['changPrenomA'],$_POST['changValN'],$_POST['valType'], $conn) ==0 ) {
        echo "<br/> Modification réussie !";
        }
    }
}