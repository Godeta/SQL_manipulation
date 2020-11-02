<?php

function formatPrenom($prenom) //IMPORTANT PRECISER mb_internal_encoding("UTF-8") absolument
{
    if (is_string($prenom)) {
        $temp = mb_strtolower($prenom); 
        $temp = decollerLettres($temp);
        $temp = trim($temp);
        $temp = majSeparateur("-", $temp);
        $temp = majSeparateur("'", $temp);
        $temp = majSeparateur(" ", $temp);
        $temp = modifSeparateur("''", "' '", $temp);
        return $temp;
    }
}

function majSeparateur($separateur, $nom)
{
    $array = explode($separateur, $nom);
    $temp = '';
    foreach ($array as $word) {
        $word = mb_strtoupper(skip_accents(mb_substr($word, 0, 1))) . mb_substr($word, 1);
        $temp = $temp . $word;
        $temp = $temp . $separateur;
    }
    $temp = substr($temp, 0, -strlen($separateur));
    return $temp;
}

function modifSeparateur($separateurRencontre, $separateurDesire, $nom)
{
    $array = explode($separateurRencontre, $nom);
    $temp = '';
    foreach ($array as $word) {
        $word = mb_strtoupper(skip_accents(mb_substr($word, 0, 1))) . mb_substr($word, 1);
        $temp = $temp . $word;
        $temp = $temp . $separateurDesire;
    }
    $temp = substr($temp, 0, -strlen($separateurDesire));
    return $temp;
}

function decollerLettres($mot)//ne pas appeler avant mb_strtolower
{
    $mot = preg_replace('/œ/', 'oe', $mot);
    $mot = preg_replace('/Œ/', 'oe', $mot);
    $mot = preg_replace('/æ/', 'ae', $mot);
    $mot = preg_replace('/Æ/', 'ae', $mot);
    return $mot;
}

function formatNom($nom)
{
    if (is_string($nom)) {
        $temp = skip_accents($nom);
        $temp = decollerLettres($temp); 
        $temp = mb_strtoupper($temp);
        return $temp;
    }
}

function calculNumCoureur($conn)
{
    $req = 'SELECT max(n_coureur)as num from tdf_coureur';
    $cur = PreparerRequeteOCI($conn, $req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur, $donnees);
    return (intval($donnees[0]['NUM']) + 1);
}

function dernierNumCoureur($conn)
{
    return (calculNumCoureur($conn)-1);
}


function skip_accents($str, $charset = 'utf-8')
{

    $str = htmlentities($str, ENT_NOQUOTES, $charset);

    $str = preg_replace('#&([A-za-z])(?:acute|cedil|caron|circ|grave|orn|ring|slash|th|tilde|uml);#', '\1', $str);
    $str = preg_replace('#&([A-za-z]{2})(?:lig);#', '\1', $str);
    $str = preg_replace('#&[^;]+;#', '', $str);

    return $str;
}

function remplirAnnee($nbLignes, $min)
    {
        for ($i = 0; $i < $nbLignes; $i++) {
            $temp = $min + $i;
            echo '<option value="' . $temp . '">';
            echo $temp;
            echo '</option>';
        }
    }

function classementGeneral($annee,$conn){
echo "<h1>Classement général</h1>";
echo"</br>";
$req="select * from tdf_classements_generaux where annee=".$annee." order by rang_arrivee";
$cur = PreparerRequeteOCI($conn,$req);
$res = ExecuterRequeteOCI($cur);
$nb = LireDonneesOCI1($cur,$donnees);
AfficherRequete($donnees,false);
}

function gagnantEtapes($annee,$conn){
    echo "<h1>Gagnant par étape</h1>";
    echo"</br>";
    $req="select n_etape,n_coureur,nom,prenom,ville_d as Départ,ville_a as Arrivée,datetape as jour from tdf_coureur join tdf_temps using (n_coureur) join tdf_etape using (annee,n_etape) where annee=".$annee." and rang_arrivee=1 order by to_number(n_etape)";
    $cur = PreparerRequeteOCI($conn,$req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur,$donnees);
    AfficherRequete($donnees,false);
}

function participants($annee,$conn){
    echo "<h1>Participants</h1>";
    echo"</br>";
    $req="select n_coureur,n_dossard,tdf_coureur.nom as nom,prenom,code_cio,tdf_sponsor.nom as nom_equipe from tdf_parti_coureur join tdf_sponsor using (n_equipe,n_sponsor) join tdf_coureur using (n_coureur) where annee=".$annee." order by n_equipe";
    $cur = PreparerRequeteOCI($conn,$req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur,$donnees);
    AfficherRequete($donnees,false);
}

function abandons($annee,$conn){
    echo "<h1>Abandons</h1>";
    echo"</br>";
    $req="select n_coureur,n_dossard,tdf_coureur.nom as nom,prenom,code_cio,tdf_sponsor.nom as nom_equipe,n_etape,libelle from tdf_abandon join tdf_coureur using (n_coureur) join tdf_parti_coureur using (n_coureur, annee) join tdf_sponsor using (n_equipe,n_sponsor) join tdf_typeaban using (c_typeaban) join tdf_etape using (annee,n_etape) where annee=".$annee."order by n_etape";
    $cur = PreparerRequeteOCI($conn,$req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur,$donnees);
    AfficherRequete($donnees,false);
}
