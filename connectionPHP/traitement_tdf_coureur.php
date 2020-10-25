<?php
//partout où l'on souhaite utiliser le tableau de session il faut commencer par session_start(); même avant html
// session_start();
// include_once 'fonc_oracle.php';
include_once 'generique/util_chap11.php';
include_once 'generique/regex.php';
include_once 'generique/chaine.php';
include_once "generique/util_chap9.php";
include_once "manip_tdf_coureur.htm";

//si on est pas passé par la page de connexion donc variables de session non initialisées
if (empty($_SESSION['ident']) ||empty($_SESSION['mdp']) ||empty($_SESSION['site']) ) {
    echo "<b>Vous ne vous êtes pas connecté correctement avec page_acceuil.htm, retournez vous connecter pour pouvoir accéder à la base !</b>";
}
    else {
    $conn = OuvrirConnexionOCI('pphp2a_08', 'EygQpI7Wie8K1CAq','kiutoracle18.unicaen.fr:1521/info.kiutoracle18.unicaen.fr');
    //si on a bien des valeurs pour le prénom et nom à insérer
    if (!empty($_POST['nouvNom']) && !empty($_POST['nouvPrenom']) ) {
        if (verif_taille($_POST["nouvNom"]) && verif_mon_nom($_POST["nouvNom"])) {
        $nom = formatNom($_POST["nouvNom"]);
        if (verif_taille($_POST["nouvPrenom"]) && verif_mon_prenom($_POST["nouvPrenom"])) {
        $prenom = formatPrenom($_POST["nouvPrenom"]);
        $id = calculNumCoureur();
        echo "<br/>Insertion d'un nouveau coureur : $nom $prenom";
        
        echo "Requête : <br/> INSERT INTO tdf_coureur (N_COUREUR,NOM,PRENOM) VALUES($id,'$nom','$prenom') returning ROWID into :rid ";

        // insertion de données paramétrée, code récupéré depuis oci_connection_select.php
        $req = "INSERT INTO tdf_coureur (N_COUREUR,NOM,PRENOM) VALUES(:rid,:rnom,:rprenom)  ";
        $cur = PreparerRequeteOCI($conn,$req);
        ajouterParamOCI($cur,":rid",$id, 32);
        ajouterParamOCI($cur,":rnom",$nom, 32);
        ajouterParamOCI($cur,":rprenom",$prenom, 32);
        $res = ExecuterRequeteOCI($cur);
        $committed = ValiderTransacOCI($conn);
        echo "<br/>Nouvelle donnée insérée dans tdf_coureur : $nom $prenom <hr />";
        }
        else {
            echo "<br/><b>Le prenom : ".$_POST["nouvPrenom"]." n'est pas valide selon les contraintes.</b><br/>";
        }
    }
        else {
            echo "<br/><b>Le nom : ".$_POST["nouvNom"]." n'est pas valide selon les contraintes.</b><br/>";
        }
    }

    else {
        echo "<br/>Nom ou Prenom à insérer non défini !<br/>";
    }

    //si on a bien des valeurs pour le prénom et nom à changer
        if (!empty($_POST['changNomA']) && !empty($_POST['changNomN'])) {
            //on vérifie si le nouveau nom choisi respecte les contraintes regex
            if (verif_mon_nom($_POST['changNomN']) ) {
        // Maj de données paramétrée
        $req = "update tdf_coureur set NOM=:nouveau where NOM=:ancien" ;
        $cur = PreparerRequeteOCI($conn,$req);
        echo "<br>identifiant de second curseur : $cur<br />";
        $ancien= formatNom($_POST['changNomA']);
        $nouveau = formatNom($_POST['changNomN']);
        ajouterParamOCI($cur,":nouveau",$nouveau, 30);
        ajouterParamOCI($cur,":ancien",$ancien, 50);
        $res = ExecuterRequeteOCI($cur);
        $committed = ValiderTransacOCI($conn);
        echo "<br/>Nouvelle donnée modifiée dans tdf_coureur : $ancien devient -> $nouveau <hr />";
    }
    else {
        echo "<br/>Le nouveau nom :".$_POST['changNomN']." ne respecte pas les contraintes !";
    }
}
    else {
        echo "<br/>Nom ou Prenom à modifier non défini !<br/>";
    }

    //si on a bien des valeurs pour le prénom et nom à supprimer ou le num du coureur
    if ( (!empty($_POST['suppNom']) && !empty($_POST['suppPrenom']) ) || !empty($_POST['numC'])) {
        echo 'Suppression de : '.$_POST["suppNom"] . " " . $_POST["suppPrenom"] . $_POST['numC'];
        // Maj de données paramétrée
        $req = "DELETE FROM tdf_coureur WHERE N_COUREUR=:numC or (NOM=:nomSup and PRENOM=:prenomSup)";
        $cur = PreparerRequeteOCI($conn,$req);
        $nomSup= formatNom($_POST['suppNom']);
        $prenomSup = $_POST['suppPrenom'];
        //si il n'y a pas de numéro de coureur on met -1
        $numC = empty($_POST['numC']) ? -1 : $_POST['numC'];
        ajouterParamOCI($cur,":nomSup",$nomSup, 50);
        ajouterParamOCI($cur,":prenomSup",$prenomSup, 50);
        ajouterParamOCI($cur,":numC",$numC, 10);
        $res = ExecuterRequeteOCI($cur);
        $committed = ValiderTransacOCI($conn);
        echo "<br/>Nouvelle donnée supprimée dans tdf_coureur : $nomSup $prenomSup $cur <hr />";
        }
        
        else {
            echo "<br/>Nom ou Prenom à modifier non défini !<br/>";
        }
        

    FermerConnexionOCI($conn);

}