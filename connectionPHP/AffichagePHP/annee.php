<?php
session_start();
    include_once '../classesPHP/classe_annee.php';
    include_once '../generique/chaine.php';
    include_once '../generique/fonc_oracle.php';
    include_once '../generique/util_chap11.php';    
    $annee = new Annee();

    if (!empty($_POST)) {
        include_once '../Affichage/annee.htm';
        if (isset($_POST['annee']) && isset($_POST['classement'])) {
            $anneeChoisie = $_POST['annee'];
            $choix= $_POST['classement'];
            $annee->choix($choix,$anneeChoisie);
        }
    } else
        include_once '../Affichage/annee.htm';
