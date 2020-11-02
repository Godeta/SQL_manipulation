<?php
session_start();
?>
<?php
    include_once '../classesPHP/classe_annee.php';
    include_once '../generique/chaine.php';
    include_once '../generique/fonc_oracle.php';
    include_once '../generique/util_chap11.php';    
    $annee = new Annee();

    if (!empty($_POST)) {
        include_once '../Affichage/annee.htm';
        if (isset($_POST['annee'])) {
            $anneeChoisie = $_POST['annee'];
            $annee->classementGeneral($anneeChoisie);
            $annee->participants($anneeChoisie);
            $annee->gagnantEtapes($anneeChoisie);
            $annee->abandons($anneeChoisie);
        }
    } else
        include_once '../Affichage/annee.htm';
    ?>

</html>