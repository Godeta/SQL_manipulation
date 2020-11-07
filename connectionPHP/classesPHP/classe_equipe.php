<?php

include_once '../generique/util_chap11.php';
include_once '../generique/regex.php';
include_once '../generique/chaine.php';



class Equipe
{
    public $_conn;

    function __construct()
    {
        $this->_conn = OuvrirConnexionOCI($_SESSION['ident'], $_SESSION['mdp'], $_SESSION['site']);
    }

    function calculNumEquipe()
    {
        $req = 'SELECT max(n_equipe) as num from tdf_equipe';
        $cur = PreparerRequeteOCI($this->_conn, $req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        return (intval($donnees[0]['NUM']) + 1);
    }

    public function insert($nEquipe,$crea,$dispa)
    {
        $reqInsert = "INSERT INTO tdf_equipe(n_equipe,annee_creation, annee_disparition) VALUES(:requipe,:rcrea,:rdispa)";
        if(!empty($_POST['nouvNom']) )
        {
            if(!empty($_POST['nouvPrenom'])) 
            {
                if(!empty($_POST['pays']) && $_POST['pays']!="NULL")
                {
                    if (!$this->coureurExiste($nom, $prenom)) 
                    {
                        if ($this->verifNomPrenom($nom, $prenom) && $this->verifAnnees($annee_nai, $annee_prem)) 
                        {
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
                        } 
                        else 
                        {
                            echo "</br>";
                            echo "<span class=\"feedbackNegatif\">Echec de l'insertion, certaines valeurs ne sont pas valides.</span>";
                        }
                    }
                    else
                    {
                        echo "<span class=\"feedbackNegatif\">Insertion impossible, coureur déjà existant</span>";
                    }
                }
                else 
                {
                    echo "<span class = \"feedbackNegatif\">La nationalité n'est pas remplie !</span>";
                }
            }
        }
        else 
        {
            echo "<span class = \"feedbackNegatif\">Le prénom est vide !</span>";
        }
    }

    public function sponsor()
    {
        $req="SELECT distinct n_sponsor, n_equipe, nom, na_sponsor FROM tdf_sponsor JOIN TDF_PARTI_EQUIPE using (n_equipe, n_sponsor) ORDER BY NOM ASC";
        $cur = PreparerRequeteOCI($this->_conn,$req);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur,$donnees);
        return $donnees;
    }

    //Fonction qui crée les options d'une liste déroulante de sponsors.
    //Prend en paramètres les données renvoyées par la fonction sponsor().
    //Ne retourne rien.
    public function remplirNomEquipe($donnees)
    {
        echo "<option value=\"Non sélectionné\" selected>";
            echo "</option>";
        for ($i = 0; $i < count($donnees); $i++) {
            echo "<option value=\"".$donnees[$i]['N_SPONSOR']."\">";
            echo $donnees[$i]['NOM']."&nbsp;&nbsp;&nbsp;&nbsp;N°".$donnees[$i]['N_SPONSOR'];
            echo "</option>";
        }
    }

    //Fonction qui vérifie si une équipe existe dans la table tdf_parti_equipe.
    //Prend en paramètre le numéro d'équipe et le numéro du sponsor.
    //Retourne true si elle existe, false si non.
    public function verifEquipeExiste($numEquipe, $numSponsor)
    {
        $req = "SELECT count(*) as \"EXISTE\" FROM TDF_parti_EQUIPE WHERE N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe, 10);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor, 10);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        if(ceil($donnees[0]['EXISTE']) != 0)
        {
            return True;
        }
        else
        {
            echo "L'équipe sélectionnée ne participe pas au tour !";
            return False;
        }
    }

    //Fonction qui vérifie si une équipe existe dans la table tdf_parti_equipe pour une année donnée.
    //Prend en paramètre le numéro d'équipe et le numéro du sponsor et l'année de participation.
    //Retourne true si elle existe, false si non.
    public function verifEquipeExisteAnnee($numEquipe, $numSponsor, $annee)
    {
        $req = "SELECT count(*) as \"EXISTE\" FROM TDF_parti_EQUIPE WHERE N_EQUIPE=:rnumEquipe AND N_SPONSOR=:rnumSponsor AND ANNEE=:rannee";
        $cur = PreparerRequeteOCI($this->_conn, $req);
        ajouterParamOCI($cur, ':rnumEquipe', $numEquipe, 10);
        ajouterParamOCI($cur, ':rnumSponsor', $numSponsor, 10);
        ajouterParamOCI($cur, ':rannee', $annee, 4);
        $res = ExecuterRequeteOCI($cur);
        $nb = LireDonneesOCI1($cur, $donnees);
        if($this->verifEquipeExiste($numEquipe, $numSponsor))
        {
            if(ceil($donnees[0]['EXISTE']) != 0)
            {
                return True;
            }
            else
            {
                echo "L'équipe sélectionnée ne participe pas au tour cette année là !";
                return False;
            }
        }
        else 
        {
            return False;
        }
        
    }

    public function insertParti($annee,$n_equipe,$n_sponsor,$dir,$codir,$date)
    {
        $reqInsert = "INSERT INTO tdf_parti_equipe(annee,n_equipe,n_sponsor,n_pre_directeur,n_co_directeur,date_insert) VALUES(:rannee,:rid,:ridspo,:rpre,:rco,:rdate)";
            $cur = PreparerRequeteOCI($this->_conn, $reqInsert);
            ajouterParamOCI($cur, ":rannee", $annee, 32);
            ajouterParamOCI($cur, ":rid", $n_equipe, 32);
            ajouterParamOCI($cur, ":ridspo", $n_sponsor, 32);
            ajouterParamOCI($cur, ":rpre", $dir, 32);
            ajouterParamOCI($cur, ":rco", $codir, 32);
            ajouterParamOCI($cur, ":rdate", $date, 32);
            $res = ExecuterRequeteOCI($cur);
            $comitted = ValiderTransacOCI($this->_conn);
            return 0;
    }
    
}
