<?php

/*function verif_mon_nomjs($nom) //javascript
{
    echo $nom;
    return (preg_grep('#^\'?\s*[a-zA-Z\xC0-\xFFŸ]+(\s*\'?-?\'?\s*[a-zA-Z\xC0-\xFFŸ]+)?\'?(\s*-?\s*-?\s*[a-zA-Z\xC0-\xFFŸ]+)?(\s*\'?-?\'?\s*[a-zA-Z\xC0-\xFFŸ]+)?\s*\'?\s*$#',$nom));
}*/
function verif_taille($nom)
{
    return mb_strlen($nom)<=30;
}

function verif_mon_nom($nom) //php
{
    return (preg_match('#^(\s*\'?(([a-zA-Z]|[àâäéèêëïîôöùûüÿçæœÀÂÄÉÈÊËÏÎÔÖÙÛÜŸÇÆŒ]){1,10})){1,2}(--([a-zA-Z]|[àâäéèêëïîôöùûüÿçæœÀÂÄÉÈÊËÏÎÔÖÙÛÜŸÇÆŒ]){1,10})?(\s*\'?)*(-?\s*\'?([a-zA-Z]|[àâäéèêëïîôöùûüÿçæœÀÂÄÉÈÊËÏÎÔÖÙÛÜŸÇÆŒ]){1,10}){0,4}(\s*\'?)?$#',$nom));
}

function verif_mon_prenom($nom) //php
{
    return (preg_match('#^\s*\'?([a-zA-Z]|[àâäéèêëïîôöùûüÿçæœÀÂÄÉÈÊËÏÎÔÖÙÛÜŸÇÆŒ]){1,10}(\s*\'?)*(-?\s*\'?([a-zA-Z]|[àâäéèêëïîôöùûüÿçæœÀÂÄÉÈÊËÏÎÔÖÙÛÜŸÇÆŒ]){1,10}){0,4}(\s*\'?)?$#',$nom));
}

function verif_annee_nai($an) //php
{
    return (preg_match('/^[0-9]*$/',$an));
}
// regex pour une année au format DD/MM/YYYY : #^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$#
function verif_date_DDMMYY($an) //php
{
    return (preg_match('#^[0-9]*$#',$an));
}
function verif_compte($an) //php
{
    return (preg_match('/^[A-z]{3,}[0-9]*_?[0-9]*$/',$an));
}
function verif_num($an) //php
{
    return (preg_match('/^[0-9]*$/',$an));
}
function verif_annee_prem($an) //php
{
    return (preg_match('/^[0-9]{4}$/',$an));
}
?>