<?php
session_start();
// fonction principale -------------------------------------------------------------------
include_once '../generique/fonc_oracle.php';
include_once '../generique/util_chap11.php';
include_once '../generique/chaine.php';
include_once '../classesPHP/classe_coureur.php';

$conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'],$_SESSION['site']);
$coureur = new coureur();
$colonne = $_GET["column"];
$nom = $coureur->changeValSelonType($colonne,$_GET["nom"]);
$req = 'SELECT * FROM tdf_coureur where '.$colonne.' like \'' . $nom . '%\'';
$cur = PreparerRequeteOCI($conn,$req);
$res = ExecuterRequeteOCI($cur);
$nb = LireDonneesOCI1($cur,$donnees);
// AfficherDonnee2($donnees,$nb);
AfficherRequete($donnees,true);
//au lieu d'utiliser afficher données, on le refait nous même et on créer des boutons qui renverrons vers une page
// foreach($donnees as $ligne)
//   {
//     echo "<form><button formaction='../coureurSelect.php'
//        class =\"coureurVal\" name = \"coureurData\" 
//        type =\"submit\" onclick=\"infosCoureur(this)\">";
//     foreach($ligne as $valeur) {
//     echo $valeur." ";
//     }
//     echo "</button></form>";
//   }
FermerConnexionOCI($conn);
//---------------------------------------------------------------------------------------------

// $nom = strtoupper($_GET["nom"]);
// $prenom = strtoupper($_GET["prenom"]);
// $numero = strtoupper($_GET["numero"]);
// $req = 'SELECT nom,prenom FROM tdf_coureur where nom like \'' . $nom . '%\' or prenom like \'' . $prenom . '%\' or n_coureur like \'' . $numero . '%\'' ;
