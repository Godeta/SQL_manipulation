<?php
// E.Porcq  util_chap11.php  28/08/2018 

function AfficherDonnee1($tab, $nbLignes)
{
  if ($nbLignes > 0) {
    echo "<table border=\"1\">\n";
    echo "<tr>\n";
    foreach ($tab as $key => $val)  // lecture des noms de colonnes
    {
      echo "<th>$key</th>\n";
    }
    echo "</tr>\n";
    echo $nbLignes;
    for ($i = 0; $i < $nbLignes; $i++) // balayage de toutes les lignes
    {
      echo "<tr>\n";
      foreach ($tab as $data) // lecture des enregistrements de chaque colonne
      {
        echo "<td>$data[$i]</td>\n";
      }
      echo "</tr>\n";
    }
    echo "</table>\n";
  } else {
    echo "Pas de ligne<br />\n";
  }
  echo "$nbLignes Lignes lues<br />\n";
}
//---------------------------------------------------------------------------------------------
function AfficherDonnee2($tab)
{
  foreach ($tab as $ligne) {
    foreach ($ligne as $valeur)
      echo $valeur . " ";
    echo "<br/>";
  }
}
//---------------------------------------------------------------------------------------------
function AfficherDonnee3($tab, $nb)
{
  for ($i = 0; $i < $nb; $i++)
    echo $tab[$i][0] . " " . $tab[$i][1] . " " . $tab[$i][2] . "\n";
}
//---------------------------------------------------------------------------------------------
function AfficherTab($tab)
{
  echo "<PRE>";
  print_r($tab);
  echo "</PRE>";
}
//---------------------------------------------------------------------------------------------
function AfficherRequete($tab, $bool)
{
  if(empty($tab))  {
    echo "Pas de résultats correspondants dans la base !";
  }
  else {
  echo "<div class=\"table-wrapper\">\n";
  echo "<div class=\"table-scroll\">\n";
  echo "<table>\n";
  echo "<thead>\n";
  echo "<tr>\n";
  foreach ($tab[0] as $key => $val)  // lecture des noms de colonnes
  {
    echo "<th>$key</th>\n";
  }
  if($bool) {echo "<th> Modifier </th> <th> Supprimer </th>"; }
  echo "</tr>\n";
  echo "</thead>\n";
  echo "<tbody>\n";

  foreach ($tab as $ligne) {
    echo "<tr>\n";
    foreach ($ligne as $valeur) {
      //on récupère le numéro du coureur
      if($bool) {$numCour = $ligne["N_COUREUR"]; }
      echo "<td>" . $valeur . "</td>\n";
    }
    if($bool) {
      echo "<td> <form><a href='../AffichagePHP/coureurSelect.php?id=$numCour'>";
  echo "<img src='../img/modify.png' alt='Une image symbolisant la modification' width='40' height ='40' > </a></td>";
  echo "</button></form> </td>";
  echo "<td> <form><a href='../AffichagePHP/choix_action_tdf_coureur.php?id=$numCour'>";
  echo "<img src='../img/remove.png' alt='Une croix rouge indiquant la suppression' width='40' height ='40' > </a></td>";
    }
    echo "</tr>\n";
  }
  // echo "</table>\n";
  // echo "</div>\n";
  // echo "</td>\n";
  // echo "</tr>\n";
  echo "</tbody>\n";
  echo "</table>";
  echo "</div>\n";
  echo "</div>\n";
}
}