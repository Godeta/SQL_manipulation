<?php
session_start();
// fonction principale -------------------------------------------------------------------
include_once '../generique/fonc_oracle.php';
include_once '../generique/util_chap11.php';
include_once '../generique/chaine.php';
include_once '../classesPHP/classe_coureur.php';

$conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'],$_SESSION['site']);
$coureur = new coureur();
$colonne = "NOM";
$nom = $_GET["nom"];
$prenom = $_GET["prenom"];
$annee_nai = $_GET["annee_nai"];
$annee_pre = $_GET["annee_pre"];
if(!empty($nom)) {
$nom = $coureur->changeValSelonType($colonne,$nom);
}
$colonne = "PRENOM";
if(!empty($prenom)) {
$prenom = $coureur->changeValSelonType($colonne,$prenom);
}
//plus permisif pour la recherche, on accepte même si il n'y a que un chiffre donc même regex que n_coureur
$colonne = "N_COUREUR";
if(!empty($annee_nai)) {
$annee_nai = $coureur->changeValSelonType($colonne,$annee_nai);
}
$colonne = "N_COUREUR";
if(!empty($annee_pre)) {
$annee_pre = $coureur->changeValSelonType($colonne,$annee_pre);
}

// $req = 'SELECT * FROM tdf_coureur where '.$colonne.' like \'' . $nom . '%\'';
$req = 'SELECT * FROM tdf_coureur where NOM like \'%' . $nom . '%\' and PRENOM like \'%'.$prenom.'%\' and annee_prem like \'%'.$annee_pre.'%\' and annee_naissance like \'%'.$annee_nai.'%\' ';
$cur = PreparerRequeteOCI($conn,$req);
$res = ExecuterRequeteOCI($cur);
$nb = LireDonneesOCI1($cur,$donnees);
AfficherRequete($donnees,true);
FermerConnexionOCI($conn);
//---------------------------------------------------------------------------------------------

// $nom = strtoupper($_GET["nom"]);
// $prenom = strtoupper($_GET["prenom"]);
// $numero = strtoupper($_GET["numero"]);
// $req = 'SELECT nom,prenom FROM tdf_coureur where nom like \'' . $nom . '%\' or prenom like \'' . $prenom . '%\' or n_coureur like \'' . $numero . '%\'' ;