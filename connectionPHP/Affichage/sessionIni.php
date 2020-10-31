<?php
//partout où l'on souhaite utiliser le tableau de session il faut commencer par session_start(); même avant html
session_start();
include_once "../generique/fonc_oracle.php";
if (!empty($_POST['ident']) && !empty($_POST["mdp"])) {

    $ident = $_POST['ident'];
    $mdp = $_POST["mdp"];
    $test = @oci_connect($ident, $mdp, 'kiutoracle18.unicaen.fr:1521/info.kiutoracle18.unicaen.fr');
    // echo "$test";
    if (!$test) {
        header('Location: page_accueil.htm');
        exit();
    }
    else {
    $_SESSION['ident'] = $ident;
    $_SESSION['mdp'] = $mdp;
    $_SESSION['site'] = 'kiutoracle18.unicaen.fr:1521/info.kiutoracle18.unicaen.fr';
    //on passe à la page de manipulations de la table
    header('Location: ../AffichagePHP/choix_action_tdf_coureur.php');
    // print_r($_SESSION);
}
}