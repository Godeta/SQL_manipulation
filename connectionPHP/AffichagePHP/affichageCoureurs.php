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
$numC = $_GET["numC"];
$prenom = $_GET["prenom"];
$annee_nai = $_GET["annee_nai"];
$annee_pre = $_GET["annee_pre"];
$pays = $_GET["nation"];
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
$colonne = "N_COUREUR";
if(!empty($numC)) {
$numC = $coureur->changeValSelonType($colonne,$numC);
}
//même traitement pour pays que pour nom (full majuscules, caractères interdits...)
$colonne = "NOM";
if(!empty($pays)) {
    $pays = $coureur->changeValSelonType($colonne,$pays);
    }


// $req = 'SELECT * FROM tdf_coureur where '.$colonne.' like \'' . $nom . '%\'';
$req = 'SELECT n_coureur as "N COUREUR",tdf_coureur.nom as "NOM COUREUR",prenom,tdf_nation.nom as NATIONALITE,annee_naissance,annee_prem FROM tdf_coureur 
join tdf_app_nation using (n_coureur)
join tdf_nation using (code_cio)
where tdf_coureur.NOM like \'%' . $nom . '%\' and PRENOM like \'%'.$prenom.'%\' and 
(annee_prem like \'%'.$annee_pre.'%\' or TRIM(annee_prem) is NULL) and
 (annee_naissance like \'%'.$annee_nai.'%\' or TRIM(annee_naissance) is NULL)
 and n_coureur like \'%'.$numC.'%\' order by n_coureur,tdf_nation.nom ';
// $req = 'select n_coureur,tdf_coureur.nom,prenom,tdf_nation.nom,annee_naissance,annee_prem from tdf_coureur
// join tdf_app_nation using (n_coureur)
// join tdf_nation using (code_cio) where NOM like \'%' . $nom . '%\' and PRENOM like \'%'.$prenom.'%\' and 
// (annee_prem like \'%'.$annee_pre.'%\' or TRIM(annee_prem) is NULL) and
//  (annee_naissance like \'%'.$annee_nai.'%\' or TRIM(annee_naissance) is NULL)
//  and N_COUREUR like \'%'.$numC.'%\' ';
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