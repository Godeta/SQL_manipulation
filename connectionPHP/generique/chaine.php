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
    $req = 'SELECT max(n_coureur)as maxi from tdf_coureur';
    $cur = PreparerRequeteOCI($conn, $req);
    $res = ExecuterRequeteOCI($cur);
    $nb = LireDonneesOCI1($cur, $donnees);
    //AfficherDonnee2($donnees,$nb);
    return (intval($donnees[0]['MAXI']) + 1);
}

function skip_accents($str, $charset = 'utf-8')
{

    $str = htmlentities($str, ENT_NOQUOTES, $charset);

    $str = preg_replace('#&([A-za-z])(?:acute|cedil|caron|circ|grave|orn|ring|slash|th|tilde|uml);#', '\1', $str);
    $str = preg_replace('#&([A-za-z]{2})(?:lig);#', '\1', $str);
    $str = preg_replace('#&[^;]+;#', '', $str);

    return $str;
}

