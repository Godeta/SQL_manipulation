<?php
session_start();
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../generique/projet.css" media="all" />
    <title>Classement général</title>
</head>
<body>
    <?php
    include '../generique/chaine.php';
    include '../generique/fonc_oracle.php';
    include '../generique/util_chap11.php';
    $conn = OuvrirConnexionOCI($_SESSION['ident'],$_SESSION['mdp'], $_SESSION['site']);
    $min = calculAnneeMin($conn);
    $max = calculAnneeMax($conn);
    $nbLignes = ($max - $min) + 1;

    if (!empty($_POST)) {
        if (isset($_POST['annee'])) {
            $annee = $_POST['annee'];
            classementGeneral($annee,$conn);
            gagnantEtapes($annee,$conn);
        }
    } else
        include '../Affichage/annee.htm';
    ?>
</body>
</html>