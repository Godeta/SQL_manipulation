<?php
session_start();

include_once '../classesPHP/classe_coureur.php';

include_once '../Affichage/inserer_tdf_coureur.htm';

include_once '../generique/fonc_oracle.php';

$conn = OuvrirConnexionOCI($_SESSION['ident'],$_SESSION['mdp'], $_SESSION['site']);

$coureur = new Coureur();


if(!empty($_POST['nouvNom']) && !empty($_POST['nouvPrenom']))
{
        if($coureur->insert($_POST['nouvNom'], $_POST['nouvPrenom'],$_POST['annee_naissance'], $_POST['annee_prem'], $conn) ==0 ) {
        echo "<br/> Insertion réussie !";
        }
}

?>