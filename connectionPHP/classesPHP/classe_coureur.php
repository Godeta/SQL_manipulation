<?php

include_once '../generique/util_chap11.php';
include_once '../generique/regex.php';
include_once '../generique/chaine.php';

error_reporting(E_ERROR | E_PARSE);

class Coureur
{
    public $_conn;

    function __construct()
    {
        $this->_conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    //Vérifie si le nom et le prénom ne sont pas vide.
    //Prend en paramètre le nom et le prénom à vérifier.
    //Renvoie "True" si non vide, "False" si vide.
    public function verifNomPrenomVide($nom, $prenom)
    {
        if (!empty($nom) && !empty($prenom)) {
            return true;
        } else {
            if (empty($nom)) {
                echo "<br/> Nom vide <br/>";
            }
            if (empty($prenom)) {
                echo "<br/> Prénom vide <br/>";
            }
            return false;
        }
    }

    //Fonction qui vérifie l'éligibilité du nom et du prénom du coureur. 
    //Prend en paramètre le nom et le prénom à vérifier.
    //Renvoie "True" si passe, "False" si passe pas.
    public function verifNomPrenom($nom, $prenom)
    {
        if ($this->verifNomPrenomVide($nom, $prenom)) //vérifie si le nom et le prénom ne sont pas vide.
        {
            if (verif_taille($prenom) && verif_mon_prenom($prenom)) //Vérifie si le prénom dépasse la taille réglementaire et passe la regex. 
            {
                echo "<br/> <span class =\"feedbackPositif\"> Prénom valide <br/></span>";
                $verifPrenom = true;
            } else {
                echo "<br/><span class =\"feedbackNegatif\">  Prénom invalide </span><br/>";
                $verifPrenom = false;
            }
            if (verif_taille($nom) && verif_mon_nom($nom)) //Vérifie si le nom dépasse la taille réglementaire et passe la regex. 
            {
                echo "<br/> <span class =\"feedbackPositif\">  Nom valide </span><br/>";
                $verifNom = true;
            } else {
                echo "<br/><span class =\"feedbackNegatif\">  Nom invalide </span><br/>";
                $verifNom = false;
            }
            if ($verifNom ==  true && $verifPrenom == true) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    // Vérifie si les années entrées respectent le format de la base de données ou son nulles.
    // Prend en paramètre les années de naissance et de première participation du coureur.
    // Renvoie "True" si conforme ou "False" autrement.
    public function verifAnnees($annee_nai, $annee_prem)
    {
        if ($annee_nai == null || verif_annee_nai($annee_nai)) {
            if ($annee_prem == null || verif_annee_prem($annee_prem)) {
                if(($annee_prem >= $annee_nai+20 && $annee_nai<= 2020) || $annee_prem == null || $annee_nai == null )
                return true;
            } else {
                echo "L'année de première participation $annee_prem ne respecte pas le format imposé !";
            }
        } else {
            echo "La date de naissance $annee_nai ne respecte pas le format imposé !";
        }
        return false;
    }

    // Formatte une valeur selon le type demandé
    // Prend en paramètre un type de valeur et une valeur
    // Renvoie la valeur reformatée ou -1 en cas d'erreur
    function changeValSelonType($typeVal, $valN)
    {
        switch ($typeVal) {
            case 'N_COUREUR':
                if (verif_num($valN))
                    return $valN;
                else {
                    echo "Nouvelle valeur de type numéro de coureur, invalide ! (admet uniquement des nombres)";
                    return -1;
                }
                break;
            case 'NOM':
                if (verif_taille($valN) && verif_mon_nom($valN)) { //Vérifie si le prénom dépasse la taille réglementaire et passe la regex. 
                    $valN = formatNom($valN);
                    return $valN;
                } else {
                    echo "Nouvelle valeur de type Nom, invalide !";
                    return -1;
                }
                break;
            case 'PRENOM':
                if (verif_taille($valN) && verif_mon_prenom($valN)) {
                    $valN = formatPrenom($valN);
                    return $valN;
                } else {
                    echo "Nouvelle valeur de type Prenom, invalide !";
                    return -1;
                }
                break;
            case 'ANNEE_NAISSANCE':
                if (verif_annee_nai($valN))
                    return $valN;
                else {
                    echo "Nouvelle valeur de type année de naissance, invalide !";
                    return -1;
                }
                break;
            case 'ANNEE_PREM':
                if (verif_annee_prem($valN))
                    return $valN;
                else {
                    echo "Nouvelle valeur de type année de première participation, invalide !";
                    return -1;
                }
                break;
            case 'COMPTE_ORACLE':
                if (verif_compte($valN))
                    return $valN;
                else {
                    echo "Nouvelle valeur de type compte Oracle, invalide !";
                    return -1;
                }
                break;
            case 'DATE_INSERT':
                if (verif_date_DDMMYY($valN))
                    return $valN;
                else {
                    echo "Nouvelle valeur de type date d'insertion, invalide !";
                    return -1;
                }
                break;
            default:
                echo "<br/>Le type de la valeur est inconnu !";
                return -1;
                break;
        }
    }

    //Fonction permettant de supprimer un coureur de la table tdf_coureur. 
    //Prend en paramètre le nom, le prénom, le numéro du coureur et la connection la base de donnée.
    //Renvoie 0 si exécuté, -1 si échoue.
    public function delete($id, $nom, $prenom)
    {
        $reqDeleteNation = "DELETE FROM tdf_app_nation WHERE N_COUREUR=:numC OR n_coureur = (select n_coureur from tdf_coureur where NOM=:nomSup AND PRENOM=:prenomSup)";
        $reqDelete = "DELETE FROM tdf_coureur WHERE N_COUREUR=:numC OR (NOM=:nomSup AND PRENOM=:prenomSup)";
        if ($this->verifNomPrenom($nom, $prenom) || !empty($id)) {
            $nomSup = formatNom($nom);
            //impossible de supprimer si le coureur à participé au tour de france
            $reqParticip = "SELECT n_coureur from tdf_coureur join tdf_parti_coureur using(n_coureur)
             where n_coureur = :numC OR n_coureur = (select n_coureur from tdf_coureur where NOM=:nomSup AND PRENOM=:prenomSup)";
            $cur = PreparerRequeteOCI($this->_conn, $reqParticip);
            $numC = empty($id) ? -1  : $id;
            ajouterParamOCI($cur, ":nomSup", $nom, 50);
            ajouterParamOCI($cur, ":prenomSup", $prenom, 50);
            ajouterParamOCI($cur, ":numC", $numC, 10);
            $res = ExecuterRequeteOCI($cur);
            $nb = LireDonneesOCI1($cur, $donnees);
            if (empty($donnees[0]["N_COUREUR"])) {
                //suppression dans app_nation
                $cur = PreparerRequeteOCI($this->_conn, $reqDeleteNation);
                //si il n'y a pas de numéro de coureur on met -1
                $numC = empty($id) ? -1  : $id;
                ajouterParamOCI($cur, ":nomSup", $nom, 50);
                ajouterParamOCI($cur, ":prenomSup", $prenom, 50);
                ajouterParamOCI($cur, ":numC", $numC, 10);
                $res = ExecuterRequeteOCI($cur);
                $comitted = ValiderTransacOCI($this->_conn);
                //suppression dans tdf_coureur
                $cur = PreparerRequeteOCI($this->_conn, $reqDelete);
                //si il n'y a pas de numéro de coureur on met -1
                $numC = empty($id) ? -1  : $id;
                ajouterParamOCI($cur, ":nomSup", $nom, 50);
                ajouterParamOCI($cur, ":prenomSup", $prenom, 50);
                ajouterParamOCI($cur, ":numC", $numC, 10);
                $res = ExecuterRequeteOCI($cur);
                $comitted = ValiderTransacOCI($this->_conn);
                echo "<br/> Nouvelle donnée supprimée dans tdf_coureur : $nom $prenom $cur <br/>";
                return 0;
            } else {
                echo "<script> alert(\"Suppression du coureur échouée : il a une participation dans le tour de France :/\"); </script>";
                return -1;
            }
        }

        echo "<br/> Suppression du coureur échouée : $nom $prenom $cur <br/>";
        return -1;
    }

    //Fonction qui insert un coureur dans la base de donnée.
    //Prend en paramètre le nom, le prénom, le numéro du coureur et la connection la base de donnée.
    //Renvoie 0 si exécuté, -1 si échoue.
    public function insert($nom, $prenom, $annee_nai, $annee_prem, $date)
    {
        $reqInsert = "INSERT INTO tdf_coureur(N_COUREUR, NOM, PRENOM, ANNEE_NAISSANCE, ANNEE_PREM, DATE_INSERT) VALUES(:rid, :rnom, :rprenom, :rannee_nai, :rannee_prem,:rdate)";
        if(!empty($_POST['nouvNom']) )
    {
        if(!empty($_POST['nouvPrenom'])) {
            if(!empty($_POST['pays']) && $_POST['pays']!="NULL"){
            if (!$this->coureurExiste($nom, $prenom)) {
                if ($this->verifNomPrenom($nom, $prenom) && $this->verifAnnees($annee_nai, $annee_prem)) {
                    $id = calculNumCoureur($this->_conn);
                    $cur = PreparerRequeteOCI($this->_conn, $reqInsert);
                    ajouterParamOCI($cur, ":rid", $id, 32);
                    $nom = formatNom($nom);
                    ajouterParamOCI($cur, ":rnom", $nom, 32);
                    $prenom = formatPrenom($prenom);
                    ajouterParamOCI($cur, ":rprenom", $prenom, 32);
                    ajouterParamOCI($cur, ":rannee_nai", $annee_nai, 32);
                    ajouterParamOCI($cur, ":rannee_prem", $annee_prem, 32);
                    ajouterParamOCI($cur, ":rdate", $date, 10);
                    $res = ExecuterRequeteOCI($cur);
                    $comitted = ValiderTransacOCI($this->_conn);
                    return 0;
                } else {
                    echo "</br>";
                    echo "<span class=\"feedbackNegatif\">Echec de l'insertion, certaines valeurs ne sont pas valides.</span>";
                }
            }
            else{
                echo "<span class=\"feedbackNegatif\">Insertion impossible, coureur déjà existant</span>";
            }
        }
        else {
            echo "<span class = \"feedbackNegatif\">La nationalité n'est pas remplie !</span>";
    }
    }
    else {
        echo "<span class = \"feedbackNegatif\">Le prénom est vide !</span>";
    }
}

else {
    echo "<span class = \"feedbackNegatif\">Le nom est vide !</span>";
}
        return -1;
    }

    //Fonction permettant de mettre à jour le nom d'un coureur de la table tdf_coureur. 
    //Prend en paramètre l'ancien nom, le nouveau nom du coureur et la connection la base de donnée.
    //Renvoie 0 si exécuté, -1 si échoue.
    public function update($id, $ancienNom, $ancienPrenom, $valN, $typeVal)
    {
        $reqUpdate = "UPDATE tdf_coureur SET $typeVal =:valN WHERE N_COUREUR=:numC OR (NOM=:ancienNom AND PRENOM=:ancienPrenom)";
        // vérification qu'ils ne soient pas vides
        if ($this->verifNomPrenom($ancienNom, $ancienPrenom) || !empty($id)) {
            if (!empty($valN) && !empty($typeVal)) {
                $cur = PreparerRequeteOCI($this->_conn, $reqUpdate);
                ajouterParamOCI($cur, ":numC", $id, 30);
                ajouterParamOCI($cur, ":ancienPrenom", $ancienPrenom, 30);
                ajouterParamOCI($cur, ":ancienNom", $ancienNom, 50);
                echo ("<br/> La colonne : $typeVal");
                $valN = $this->changeValSelonType($typeVal, $valN);
                ajouterParamOCI($cur, ":valN", $valN, 50);
                $res = ExecuterRequeteOCI($cur);
                $comitted = ValiderTransacOCI($this->_conn);
                echo "<br/>Nouvelle donnée modifiée dans tdf_coureur : $typeVal du coureur $id $ancienNom $ancienPrenom devient -> $valN <br/>";
                return 0;
            } else {
                echo ("La nouvelle valeur ou son type est vide !");
            }
        } else {
            echo ("Le nécessaire pour identifier le coureur (numéro ou nom + prénom) n'est pas rempli !");
        }
        return -1;
    }

    //Fonction qui selectionne un/des coureur(s) dans la base de donnée et les affiche.
    //Prend en paramètre le nom, le prénom du coureur et la connection la base de donnée.
    //Renvoie rien.
    public function select($id, $nom, $prenom)
    {
        $nom = formatNom($nom);
        $prenom = formatPrenom($prenom);
        $reqSelect = "SELECT nom, prenom FROM tdf_coureur where N_COUREUR=:numC OR (NOM like ':nom %' OR PRENOM like ':prenom %') ";
        $cur = PreparerRequeteOCI($this->_conn, $reqSelect);
        ajouterParamOCI($cur, ":numC", $id, 30);
        ajouterParamOCI($cur, ":nom", $nom, 30);
        ajouterParamOCI($cur, ":prenom", $prenom, 30);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        print_r($donnees);
        afficherDonnees($donnees);
        return 0;
    }

    //Fonction qui affiche les données passé en paramètre.
    //Prend en paramètre un tableau de donnée de coureur.
    //Renvoie rien.
    public function afficherDonnees($donnees)
    {
        foreach ($donnees as $ligne) {
            echo "<form><button formaction='coureurSelect.php'
                class =\"coureurVal\" name = \"coureurData\"
                type = \"submit\" onclick = \"infosCoureur(this)\">";
            foreach ($ligne as $valeur)
                echo $valeur . " ";
            echo "</button></form><br/>";
        }
    }

    public function afficherPalmares($ncoureur)
    {
        $req = "select annee,n_etape,ville_d as départ,ville_a as arrivée,heure,minute,seconde from tdf_coureur join tdf_temps using (n_coureur)join tdf_etape using (annee,n_etape) where rang_arrivee=1 and n_coureur=" . $ncoureur . "order by annee";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    public function coureurExiste($nom, $prenom)
    {
        $req = "select count(*) as nb from tdf_coureur where nom like upper('" . $nom . "') and upper(prenom) like upper('" . $prenom . "')";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        return $donnees[0]['NB'];
    }

    //Fonction qui selectionne un/des coureur(s) dans la base de donnée et les affiche.
    //Renvoie le tableau de données.
    public function selectCoureurs()
    {
        $reqSelect = "SELECT  N_COUREUR, NOM, PRENOM FROM tdf_coureur";
        $cur = PreparerRequeteOCI($this->_conn, $reqSelect);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        return $donnees;
    }

    public function afficherSelectCoureurs($donnees)
    {
        echo "<option value=\"null\" selected>";
        echo "</option>";
        for($i=0; $i<count($donnees); $i++)
        {
            echo "<option value=\"".$donnees[$i]['N_COUREUR']."\">";
            echo $donnees[$i]['NOM']." ".$donnees[$i]['PRENOM'];
            echo "</option>";
        }
    }

    public function ensembleSelectAffichage()
    {
        $donnees=$this->selectCoureurs();
		$this->afficherSelectCoureurs($donnees);
    }
}
