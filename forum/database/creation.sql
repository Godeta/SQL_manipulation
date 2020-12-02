--------------------------------------------------------
--  La base sql 
--------------------------------------------------------
DROP TABLE "TDF_ABANDON" cascade constraints;
DROP TABLE "TDF_ANNEE" cascade constraints;
DROP TABLE "TDF_APP_NATION" cascade constraints;
DROP TABLE "TDF_CATEGORIE_EPREUVE" cascade constraints;
DROP TABLE "TDF_CLASSEMENTS_GENERAUX" cascade constraints;
DROP TABLE "TDF_COMMENTAIRE" cascade constraints;
DROP TABLE "TDF_COUREUR" cascade constraints;
DROP TABLE "TDF_DIRECTEUR" cascade constraints;
DROP TABLE "TDF_EQUIPE" cascade constraints;
DROP TABLE "TDF_EQU_SUCCEDE" cascade constraints;
DROP TABLE "TDF_ETAPE" cascade constraints;
DROP TABLE "TDF_NATION" cascade constraints;
DROP TABLE "TDF_NAT_SUCCEDE" cascade constraints;
DROP TABLE "TDF_ORDREQUI" cascade constraints;
DROP TABLE "TDF_PARTI_COUREUR" cascade constraints;
DROP TABLE "TDF_PARTI_EQUIPE" cascade constraints;
DROP TABLE "TDF_PRIX_CEE" cascade constraints;
DROP TABLE "TDF_PRIX_CEP" cascade constraints;
DROP TABLE "TDF_PRIX_CFE" cascade constraints;
DROP TABLE "TDF_PRIX_CFI" cascade constraints;
DROP TABLE "TDF_SPONSOR" cascade constraints;
DROP TABLE "TDF_TEMPS" cascade constraints;
DROP TABLE "TDF_TEMPS_DIFFERENCE" cascade constraints;
DROP TABLE "TDF_TYPEABAN" cascade constraints;
DROP TABLE "TDF_TYPE_EPREUVE" cascade constraints;
DROP TABLE "TDF_USER" cascade constraints;

--------------------------------------------------------
--  DDL for Table TDF_ABANDON
--------------------------------------------------------

  CREATE TABLE "TDF_ABANDON" 
   (	"ANNEE" NUMBER(4,0), 
	"N_ETAPE" NUMBER(2,0), 
	"N_COMP" CHAR(1), 
	"N_COUREUR" NUMBER(6,0), 
	"C_TYPEABAN" CHAR(2), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE, 
	"COMMENTAIRE" NVARCHAR2(70)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_ANNEE
--------------------------------------------------------

  CREATE TABLE "TDF_ANNEE" 
   (	"ANNEE" NUMBER(4,0), 
	"JOUR_REPOS" NUMBER(1,0), 
	"COMPTE_ORACLE" CHAR(20), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_APP_NATION
--------------------------------------------------------

  CREATE TABLE "TDF_APP_NATION" 
   (	"N_COUREUR" NUMBER(6,0), 
	"CODE_CIO" CHAR(3), 
	"ANNEE_DEBUT" NUMBER(4,0), 
	"ANNEE_FIN" NUMBER(4,0), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_CATEGORIE_EPREUVE
--------------------------------------------------------

  CREATE TABLE "TDF_CATEGORIE_EPREUVE" 
   (	"CAT_CODE" CHAR(3), 
	"TEP_CODE" CHAR(2), 
	"LIBELLE" VARCHAR2(40)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_CLASSEMENTS_GENERAUX
--------------------------------------------------------

  CREATE TABLE "TDF_CLASSEMENTS_GENERAUX" 
   (	"ANNEE" NUMBER(4,0), 
	"RANG_ARRIVEE" NUMBER(3,0), 
	"N_COUREUR" NUMBER(6,0), 
	"DOSSARD" NUMBER(3,0), 
	"NOM" VARCHAR2(30), 
	"PRENOM" NVARCHAR2(30), 
	"CODE_PAYS" CHAR(3), 
	"EQUIPE" VARCHAR2(50), 
	"TEMPS" NUMBER(6,0)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_COMMENTAIRE
--------------------------------------------------------

  CREATE TABLE "TDF_COMMENTAIRE" 
   (	"ANNEE" NUMBER(4,0), 
	"COMMENTAIRE" NVARCHAR2(400), 
	"COMPTE_ORACLE" VARCHAR2(25), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_COUREUR
--------------------------------------------------------

  CREATE TABLE "TDF_COUREUR" 
   (	"N_COUREUR" NUMBER(6,0), 
	"NOM" VARCHAR2(35), 
	"PRENOM" NVARCHAR2(30), 
	"ANNEE_NAISSANCE" NUMBER(4,0), 
	"ANNEE_PREM" NUMBER(4,0), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_DIRECTEUR
--------------------------------------------------------

  CREATE TABLE "TDF_DIRECTEUR" 
   (	"N_DIRECTEUR" NUMBER(3,0), 
	"NOM" VARCHAR2(30), 
	"PRENOM" NVARCHAR2(30), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_EQUIPE
--------------------------------------------------------

  CREATE TABLE "TDF_EQUIPE" 
   (	"N_EQUIPE" NUMBER(3,0), 
	"ANNEE_CREATION" NUMBER(4,0), 
	"ANNEE_DISPARITION" NUMBER(4,0)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_EQU_SUCCEDE
--------------------------------------------------------

  CREATE TABLE "TDF_EQU_SUCCEDE" 
   (	"N_EQUIPE" NUMBER(3,0), 
	"N_EQ_SUCCESSEUR" NUMBER(3,0)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_ETAPE
--------------------------------------------------------

  CREATE TABLE "TDF_ETAPE" 
   (	"ANNEE" NUMBER(4,0), 
	"N_ETAPE" NUMBER(2,0), 
	"N_COMP" CHAR(1), 
	"VILLE_D" VARCHAR2(40), 
	"VILLE_A" VARCHAR2(40), 
	"DISTANCE" NUMBER(4,1), 
	"MOYENNE" NUMBER(5,3), 
	"CODE_CIO_D" CHAR(3), 
	"CODE_CIO_A" CHAR(3), 
	"DATETAPE" DATE, 
	"CAT_CODE" CHAR(3), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_NATION
--------------------------------------------------------

  CREATE TABLE "TDF_NATION" 
   (	"CODE_CIO" CHAR(3), 
	"CODE_ISO" CHAR(3), 
	"NOM" VARCHAR2(50), 
	"ANNEE_CREATION" NUMBER(4,0), 
	"ANNEE_DISPARITION" NUMBER(4,0), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_NAT_SUCCEDE
--------------------------------------------------------

  CREATE TABLE "TDF_NAT_SUCCEDE" 
   (	"CODE_CIO" CHAR(3), 
	"NAT_SUCCESSEUR" CHAR(3), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_ORDREQUI
--------------------------------------------------------

  CREATE TABLE "TDF_ORDREQUI" 
   (	"ANNEE" NUMBER(4,0), 
	"N_EQUIPE" NUMBER(3,0), 
	"N_SPONSOR" NUMBER(2,0), 
	"NUMERO_ORDRE" NUMBER(2,0), 
	"SCORE" NUMBER(7,2), 
	"TYPE_CLASSEMENT" VARCHAR2(20), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_PARTI_COUREUR
--------------------------------------------------------

  CREATE TABLE "TDF_PARTI_COUREUR" 
   (	"ANNEE" NUMBER(4,0), 
	"N_COUREUR" NUMBER(6,0), 
	"N_EQUIPE" NUMBER(3,0), 
	"N_SPONSOR" NUMBER(2,0), 
	"N_DOSSARD" NUMBER(3,0), 
	"JEUNE" CHAR(1), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE, 
	"VALIDE" CHAR(1)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_PARTI_EQUIPE
--------------------------------------------------------

  CREATE TABLE "TDF_PARTI_EQUIPE" 
   (	"ANNEE" NUMBER(4,0), 
	"N_EQUIPE" NUMBER(3,0), 
	"N_SPONSOR" NUMBER(4,0), 
	"N_PRE_DIRECTEUR" NUMBER(3,0), 
	"N_CO_DIRECTEUR" NUMBER(3,0), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_PRIX_CEE
--------------------------------------------------------

  CREATE TABLE "TDF_PRIX_CEE" 
   (	"ANNEE" NUMBER(4,0), 
	"RANG_ARRIVEE" NUMBER(2,0), 
	"MONTANT" NUMBER(5,0), 
	"UNITE" CHAR(1)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_PRIX_CEP
--------------------------------------------------------

  CREATE TABLE "TDF_PRIX_CEP" 
   (	"ANNEE" NUMBER(4,0), 
	"TEP_CODE" CHAR(2), 
	"RANG_ARRIVEE" NUMBER(3,0), 
	"MONTANT" NUMBER(5,0), 
	"UNITE" CHAR(1)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_PRIX_CFE
--------------------------------------------------------

  CREATE TABLE "TDF_PRIX_CFE" 
   (	"ANNEE" NUMBER(4,0), 
	"RANG_ARRIVEE" NUMBER(3,0), 
	"MONTANT" NUMBER(6,0), 
	"UNITE" CHAR(1)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_PRIX_CFI
--------------------------------------------------------

  CREATE TABLE "TDF_PRIX_CFI" 
   (	"ANNEE" NUMBER(4,0), 
	"RANG_ARRIVEE" NUMBER(3,0), 
	"MONTANT" NUMBER(8,0), 
	"UNITE" CHAR(1)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_SPONSOR
--------------------------------------------------------

  CREATE TABLE "TDF_SPONSOR" 
   (	"N_EQUIPE" NUMBER(3,0), 
	"N_SPONSOR" NUMBER(2,0), 
	"NOM" VARCHAR2(50), 
	"NA_SPONSOR" CHAR(3), 
	"CODE_CIO" CHAR(3), 
	"ANNEE_SPONSOR" NUMBER(4,0), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_TEMPS
--------------------------------------------------------

  CREATE TABLE "TDF_TEMPS" 
   (	"ANNEE" NUMBER(4,0), 
	"N_COUREUR" NUMBER(6,0), 
	"N_ETAPE" NUMBER(2,0), 
	"N_COMP" CHAR(1), 
	"HEURE" NUMBER(4,0), 
	"MINUTE" NUMBER(2,0), 
	"SECONDE" NUMBER(2,0), 
	"TOTAL_SECONDE" NUMBER(8,0), 
	"RANG_ARRIVEE" NUMBER(3,0), 
	"RANG_INITIAL" NUMBER(3,0), 
	"TEMPS_CME" VARCHAR2(8), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_TEMPS_DIFFERENCE
--------------------------------------------------------

  CREATE TABLE "TDF_TEMPS_DIFFERENCE" 
   (	"ANNEE" NUMBER(4,0), 
	"N_COUREUR" NUMBER(6,0), 
	"DIFFERENCE" NUMBER(5,0), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_TYPEABAN
--------------------------------------------------------

  CREATE TABLE "TDF_TYPEABAN" 
   (	"C_TYPEABAN" CHAR(2), 
	"LIBELLE" CHAR(25), 
	"COMPTE_ORACLE" VARCHAR2(15), 
	"DATE_INSERT" DATE, 
	"COMMENTAIRE" NVARCHAR2(60)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_TYPE_EPREUVE
--------------------------------------------------------

  CREATE TABLE "TDF_TYPE_EPREUVE" 
   (	"TEP_CODE" CHAR(2), 
	"LIBELLE" VARCHAR2(40)
   ) ;
--------------------------------------------------------
--  DDL for Table TDF_USER
--------------------------------------------------------

  CREATE TABLE "TDF_USER" 
   (	"N_USER" NUMBER(6,0), 
	"PSEUDO" NVARCHAR2(25), 
	"MOT_DE_PASSE" NVARCHAR2(255), 
	"EMAIL" VARCHAR2(100), 
	"AUTH_KEY" VARCHAR2(32), 
	"MOT_DE_PASSE_RESET" NVARCHAR2(255), 
	"DATE_INSCRIPTION" DATE DEFAULT (SYSDATE), 
	"DATE_MAJ" DATE DEFAULT (SYSDATE)
   ) ;
--------------------------------------------------------
--  DDL for View VT_ABANDON
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_ABANDON" ("ANNEE", "N_ETAPE", "N_COMP", "N_COUREUR", "C_TYPEABAN", "COMMENTAIRE") AS 
  select     annee,    n_etape,    n_comp,    n_coureur,    c_typeaban, commentaire from    tdf_abandon
;
--------------------------------------------------------
--  DDL for View VT_ANNEE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_ANNEE" ("ANNEE", "JOUR_REPOS") AS 
  select     annee,    jour_repos         from    tdf_annee
;
--------------------------------------------------------
--  DDL for View VT_APP_NATION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_APP_NATION" ("N_COUREUR", "CODE_CIO", "ANNEE_DEBUT", "ANNEE_FIN") AS 
  select     n_coureur,    code_cio,    annee_debut,    annee_fin  from    tdf_app_nation
;
--------------------------------------------------------
--  DDL for View VT_CATEGORIE_EPREUVE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_CATEGORIE_EPREUVE" ("CAT_CODE", "TEP_CODE", "LIBELLE") AS 
  select     cat_code,    tep_code,    libelle from    tdf_categorie_epreuve
;
--------------------------------------------------------
--  DDL for View VT_CLASSEMENTS_GENERAUX
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_CLASSEMENTS_GENERAUX" ("ANNEE", "RANG_ARRIVEE", "N_COUREUR", "DOSSARD", "NOM", "PRENOM", "CODE_PAYS", "EQUIPE", "TEMPS") AS 
  select     annee,    rang_arrivee,    n_coureur,    dossard,    nom,    prenom,    code_pays,    equipe,    temps from    tdf_classements_generaux
;
--------------------------------------------------------
--  DDL for View VT_COMMENTAIRE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_COMMENTAIRE" ("ANNEE", "COMMENTAIRE") AS 
  select     annee,    commentaire from    tdf_commentaire
;
--------------------------------------------------------
--  DDL for View VT_COUREUR
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_COUREUR" ("N_COUREUR", "NOM", "PRENOM", "ANNEE_NAISSANCE", "ANNEE_PREM") AS 
  select     n_coureur,    nom,    prenom,    annee_naissance,    annee_prem  from    tdf_coureur
;
--------------------------------------------------------
--  DDL for View VT_DIRECTEUR
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_DIRECTEUR" ("N_DIRECTEUR", "NOM", "PRENOM") AS 
  select     n_directeur,    nom,    prenom  from    tdf_directeur
;
--------------------------------------------------------
--  DDL for View VT_EQUIPE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_EQUIPE" ("N_EQUIPE", "ANNEE_CREATION", "ANNEE_DISPARITION") AS 
  select    n_equipe,    annee_creation,    annee_disparition from    tdf_equipe
;
--------------------------------------------------------
--  DDL for View VT_EQU_SUCCEDE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_EQU_SUCCEDE" ("N_EQUIPE", "N_EQ_SUCCESSEUR") AS 
  select     n_equipe,    n_eq_successeur from     tdf_equ_succede
;
--------------------------------------------------------
--  DDL for View VT_ETAPE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_ETAPE" ("ANNEE", "N_ETAPE", "N_COMP", "VILLE_D", "VILLE_A", "DISTANCE", "MOYENNE", "CODE_CIO_D", "CODE_CIO_A", "DATETAPE", "CAT_CODE") AS 
  select    annee,    n_etape,    n_comp,    ville_d,    ville_a,    distance,    moyenne,    code_cio_d,    code_cio_a,    datetape,    cat_code  from    tdf_etape
;
--------------------------------------------------------
--  DDL for View VT_NATION
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_NATION" ("CODE_CIO", "CODE_ISO", "NOM", "ANNEE_CREATION", "ANNEE_DISPARITION") AS 
  select    code_cio,    code_iso,    nom,    annee_creation,    annee_disparition  from    tdf_nation
;
--------------------------------------------------------
--  DDL for View VT_NAT_SUCCEDE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_NAT_SUCCEDE" ("CODE_CIO", "NAT_SUCCESSEUR") AS 
  select    code_cio,    nat_successeur  from    tdf_nat_succede
;
--------------------------------------------------------
--  DDL for View VT_ORDREQUI
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_ORDREQUI" ("ANNEE", "N_EQUIPE", "N_SPONSOR", "NUMERO_ORDRE", "SCORE", "TYPE_CLASSEMENT") AS 
  select    annee,    n_equipe,    n_sponsor,    numero_ordre,    score,    type_classement  from    tdf_ordrequi
;
--------------------------------------------------------
--  DDL for View VT_PARTI_COUREUR
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_PARTI_COUREUR" ("ANNEE", "N_COUREUR", "N_EQUIPE", "N_SPONSOR", "N_DOSSARD", "JEUNE", "VALIDE") AS 
  select     annee,    n_coureur,    n_equipe,    n_sponsor,    n_dossard,    jeune,            valide from    tdf_parti_coureur
;
--------------------------------------------------------
--  DDL for View VT_PARTI_EQUIPE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_PARTI_EQUIPE" ("ANNEE", "N_EQUIPE", "N_SPONSOR", "N_PRE_DIRECTEUR", "N_CO_DIRECTEUR") AS 
  select     annee,    n_equipe,    n_sponsor,    n_pre_directeur,    n_co_directeur  from    tdf_parti_equipe
;
--------------------------------------------------------
--  DDL for View VT_SPONSOR
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_SPONSOR" ("N_EQUIPE", "N_SPONSOR", "NOM", "NA_SPONSOR", "CODE_CIO", "ANNEE_SPONSOR") AS 
  select    n_equipe,    n_sponsor,    nom,    na_sponsor,    code_cio,    annee_sponsor  from     tdf_sponsor
;
--------------------------------------------------------
--  DDL for View VT_TEMPS
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_TEMPS" ("ANNEE", "N_COUREUR", "N_ETAPE", "N_COMP", "HEURE", "MINUTE", "SECONDE", "TOTAL_SECONDE", "RANG_ARRIVEE", "RANG_INITIAL", "TEMPS_CME") AS 
  select    annee,    n_coureur,    n_etape,    n_comp,    heure,    minute,    seconde,    total_seconde,    rang_arrivee,    rang_initial,    temps_cme  from    tdf_temps
;
--------------------------------------------------------
--  DDL for View VT_TEMPS_DIFFERENCE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_TEMPS_DIFFERENCE" ("ANNEE", "N_COUREUR", "DIFFERENCE") AS 
  select    annee,    n_coureur,    difference  from    tdf_temps_difference
;
--------------------------------------------------------
--  DDL for View VT_TYPEABAN
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_TYPEABAN" ("C_TYPEABAN", "LIBELLE", "COMMENTAIRE") AS 
  select    c_typeaban,    libelle,            commentaire from    tdf_typeaban
;
--------------------------------------------------------
--  DDL for View VT_TYPE_EPREUVE
--------------------------------------------------------

  CREATE OR REPLACE VIEW "VT_TYPE_EPREUVE" ("TEP_CODE", "LIBELLE") AS 
  select    tep_code,    libelle from    tdf_type_epreuve
;