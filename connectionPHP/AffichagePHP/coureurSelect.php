<?php
session_start();
include_once "../generique/fonc_oracle.php";
include_once "../generique/util_chap11.php";
include_once "../generique/util_chap9.php";
include_once "../classesPHP/classe_coureur.php";
$conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
if (!empty($_GET['id'])) {
$numC = $_GET['id'];

$req = "SELECT * from tdf_coureur where n_coureur = $numC";
    $cur = PreparerRequeteOCI($conn, $req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur, $donnees);
    // print_r($donnees);
$nomC = $donnees[0]["NOM"];
$prenomC = $donnees[0]["PRENOM"];
$annee_nai = $donnees[0]["ANNEE_NAISSANCE"];


include_once "../Affichage/coureurSelect.html";

$coureur = new Coureur();

// vérification que l'identification du coureur est remplie
if(!empty($numC) )
{
    // vérification que le choix et la valeur de modification sont remplis
    if (!empty($_POST['changValN']) && !empty($_POST['valType'])) {
        if($coureur->update($numC, "","",$_POST['changValN'],$_POST['valType']) ==0 ) {
        echo "<br/> Modification réussie !";
        // redirige vers la même page sans garder la même valeur de get pour arrêter d'afficher le résultat de la suppression
        $location="../AffichagePHP/coureurSelect.php?id=$numC";
        echo '<META HTTP-EQUIV="refresh" CONTENT="0;URL='.$location.'">';
        exit;
        }
    }
}
}

?>