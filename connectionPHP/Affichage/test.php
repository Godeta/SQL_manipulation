<?php
include 'fonc_oracle.php';

for ($i=2;$i<8;$i++){
    try{
    $id="pphp2a_0".$i;
    echo $id;
    $mdp="PPHP2A_0".$i;
    echo $mdp;
}catch(Exception $e){

}
$conn=OuvrirConnexionOCI($id,$mdp,'kiutoracle18.unicaen.fr:1521/info.kiutoracle18.unicaen.fr');
echo $conn;
}

// $req = "select distinct nom from tdf_nation order by nom asc";
//         $cur = PreparerRequeteOCI($this->_conn, $req);
//         $res = ExecuterRequeteOCI($cur);
//         $nb = LireDonneesOCI1($cur, $donnees);
//         AfficherRequete($donnees, false);

//         drop table TDF_ABANDON cascade constraints;
// drop table TDF_ANNEE cascade constraints;
// drop table TDF_APP_NATION cascade constraints;
// drop table TDF_CATEGORIE_EPREUVE cascade constraints;
// drop table TDF_CLASSEMENTS_GENERAUX cascade constraints;
// drop table TDF_COMMENTAIRE cascade constraints;
// drop table TDF_COUREUR cascade constraints;
// drop table TDF_DIRECTEUR cascade constraints;
// drop table TDF_EQUIPE cascade constraints;
// drop table TDF_EQU_SUCCEDE cascade constraints;
// drop table TDF_ETAPE cascade constraints;
// drop table TDF_NATION cascade constraints;
// drop table TDF_NAT_SUCCEDE cascade constraints;
// drop table TDF_ORDREQUI cascade constraints;
// drop table TDF_PARTI_COUREUR cascade constraints;
// drop table TDF_PARTI_EQUIPE cascade constraints;
// drop table TDF_PRIX_CEE cascade constraints;
// drop table TDF_PRIX_CEP cascade constraints;
// drop table TDF_PRIX_CFE cascade constraints;
// drop table TDF_PRIX_CFI cascade constraints;
// drop table TDF_SPONSOR cascade constraints;
// drop table TDF_TEMPS cascade constraints;
// drop table TDF_TEMPS_DIFFERENCE cascade constraints;
// drop table TDF_TYPEABAN cascade constraints;
// drop table TDF_TYPE_EPREUVE cascade constraints;
// drop table TDF_USER cascade constraints;
