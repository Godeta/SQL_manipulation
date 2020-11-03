<?php

include_once '../generique/util_chap9.php';
include_once '../generique/util_chap11.php';
include_once '../generique/chaine.php';



class Annee
{
    public $_conn;

    function __construct()
    {
        $this->_conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }


    function calculAnneeMax()
    {
        $req = 'SELECT annee from tdf_annee where annee >=all ( select annee from tdf_annee )';
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        return (intval($donnees[0]['ANNEE']));
    }

    function calculAnneeMin()
    {
        $req = 'SELECT annee from tdf_annee where annee <=all ( select annee from tdf_annee )';
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        return (intval($donnees[0]['ANNEE']));
        //return 1989; //on bidouille comme ça car la table tdf_classements_generaux n'est pas à jour avant 1989.
    }
    function remplirAnnee()
    {
        $nbLignes = $this->calculAnneeMax() - $this->calculAnneeMin() + 1;
        $min = $this->calculAnneeMin();
        for ($i = 0; $i < $nbLignes; $i++) {
            $temp = $min + $i;
            echo "<option value=\"" . $temp ."\"";
            echo VerifierSelect("annee",$temp);
            echo ">";
            echo $temp;
            echo '</option>';
        }
    }

    function classementGeneral($annee)
    {
        echo "<h1>Classement général</h1>";
        echo "</br>";
        $req = "select classement,n_coureur as \"N°COUREUR\",nom,prenom,temps_total as \"TEMPS TOTAL EN SECONDE\" from mon_classement_".$annee;
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function gagnantEtapes($annee)
    {
        echo "<h1>Gagnant par étape</h1>";
        echo "</br>";
        $req = "select nom,prenom,ville_d as Départ,ville_a as Arrivée,datetape as jour from tdf_coureur join tdf_temps using (n_coureur) join tdf_etape using (annee,n_etape) where annee=" . $annee . " and rang_arrivee=1 order by to_number(n_etape)";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function participants($annee)
    {
        echo "<h1>Participants</h1>";
        echo "</br>";
        $req = "select n_dossard as \"N°DOSSARD\",tdf_coureur.nom as nom,prenom,code_cio as nationalite,tdf_sponsor.nom as \"NOM D EQUIPE \" from tdf_parti_coureur join tdf_sponsor using (n_equipe,n_sponsor) join tdf_coureur using (n_coureur) where annee=" . $annee . " order by n_dossard";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function abandons($annee)
    {
        echo "<h1>Abandons</h1>";
        echo "</br>";
        $req = "select n_dossard as \"N°DOSSARD\",tdf_coureur.nom as nom,prenom,code_cio as nationalite,tdf_sponsor.nom as \"NOM D EQUIPE\",n_etape as etape,libelle as raison from tdf_abandon join tdf_coureur using (n_coureur) join tdf_parti_coureur using (n_coureur, annee) join tdf_sponsor using (n_equipe,n_sponsor) join tdf_typeaban using (c_typeaban) join tdf_etape using (annee,n_etape) where annee=" . $annee . "order by n_etape";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        AfficherRequete($donnees, false);
    }

    function choix($choix, $annee)
    {
        $objannee = new Annee();

        foreach ($choix as $option) {
            switch ($option) {
                case 'classementGeneral':
                    $objannee->classementGeneral($annee);
                    break;
                case 'gagnantEtapes':
                    $objannee->gagnantEtapes($annee);
                    break;
                case 'participants':
                    $objannee->participants($annee);
                    break;
                case 'abandons':
                    $objannee->abandons($annee);
                    break;
                default:
                    break;
            }
        }
    }
}
