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
  echo "<div class=\"table-wrapper\">\n";
  echo "<div class=\"table-scroll\">\n";
  echo "<table>\n";
  echo "<thead>\n";
  echo "<tr>\n";
  foreach ($tab[0] as $key => $val)  // lecture des noms de colonnes
  {
    echo "<th>$key</th>\n";
  }
  echo "</tr>\n";
  echo "</thead>\n";
  echo "<tbody>\n";

  foreach ($tab as $ligne) {
    echo "<tr>\n";
    foreach ($ligne as $valeur) {
      echo "<td>" . $valeur . "</td>\n";
    }
    if($bool) {
    echo "<td> <form><button formaction='../coureurSelect.php' class =\"coureurVal\" name = \"coureurData\"
     type =\"submit\" onclick=\"infosCoureur(this)\">";
      echo "modifier";
  echo "</button></form> </td>";
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
