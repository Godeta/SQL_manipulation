-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                     (19/2/2018 11:19:21)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR1
--      Projet : car_loc
--      Auteur : Eric
--      Date de dernière modification : 19/2/2018 11:18:16
-- -----------------------------------------------------------------------------

DROP TABLE CL_PAYS CASCADE CONSTRAINTS;
DROP TABLE CL_TOURISME CASCADE CONSTRAINTS;
DROP TABLE CL_HEURES_OUVERTURES CASCADE CONSTRAINTS;
DROP TABLE CL_CLIENT CASCADE CONSTRAINTS;
DROP TABLE CL_OCCASIONNEL CASCADE CONSTRAINTS;
DROP TABLE CL_DEMANDE CASCADE CONSTRAINTS;
DROP TABLE CL_CAT_VEHICULE CASCADE CONSTRAINTS;
DROP TABLE CL_AGENCE CASCADE CONSTRAINTS;
DROP TABLE CL_FIDELISE CASCADE CONSTRAINTS;
DROP TABLE CL_UTILITAIRE CASCADE CONSTRAINTS;
DROP TABLE CL_PROXIMITE CASCADE CONSTRAINTS;
DROP TABLE CL_OUVRIR CASCADE CONSTRAINTS;
DROP TABLE CL_GAGNER CASCADE CONSTRAINTS;

CREATE TABLE CL_PAYS
(
    PAY_CODE VARCHAR2(3)  NOT NULL,
    PAY_LIBELLE VARCHAR2(50)  NULL,
    CONSTRAINT PK_CL_PAYS PRIMARY KEY (PAY_CODE)  
);

CREATE TABLE CL_TOURISME
(
    CAT_NUM NUMBER(3)  NOT NULL,
    TOU_CLIMATISATION NUMBER(1)  NULL,
    TOU_NBPORTES NUMBER(1)  NULL,
    TOU_NBPASSAGERS NUMBER(1)  NULL,
    TOU_NBBAGAGES NUMBER(1)  NULL,
    CONSTRAINT PK_CL_TOURISME PRIMARY KEY (CAT_NUM)  
);

CREATE TABLE CL_HEURES_OUVERTURES
(
    HO_NJOUR NUMBER(1)  NOT NULL,
    HO_LIBELLE CHAR(10)  NULL,
    CONSTRAINT PK_CL_HEURES_OUVERTURES PRIMARY KEY (HO_NJOUR)  
);

CREATE TABLE CL_CLIENT
(
    CLI_NUM NUMBER(4)  NOT NULL,
    PAY_CODE VARCHAR2(3)  NOT NULL,
    CLI_CIVILITE VARCHAR2(5)  NULL,
    CLI_NOM VARCHAR2(25)  NULL,
    CLI_PRENOM VARCHAR2(25)  NULL,
    CLI_ADRESSE VARCHAR2(60)  NULL,
    CLI_CPOSTAL VARCHAR2(6)  NULL,
    CLI_VILLE VARCHAR2(25)  NULL,
    CLI_TELEPHONE VARCHAR2(16)  NULL,
    CLI_COURRIEL VARCHAR2(25)  NULL,
    CONSTRAINT PK_CL_CLIENT PRIMARY KEY (PAY_CODE, CLI_NUM)  
);

CREATE  INDEX I_FK_CL_CLIENT_CL_PAYS
     ON CL_CLIENT (PAY_CODE ASC)
;

CREATE TABLE CL_OCCASIONNEL
(
    CLI_NUM NUMBER(4)  NOT NULL,
    PAY_CODE VARCHAR2(3)  NOT NULL,
    OCA_TYPE_REGLEMENT VARCHAR2(32)  NULL,
    CONSTRAINT PK_CL_OCCASIONNEL PRIMARY KEY (PAY_CODE, CLI_NUM)  
);

CREATE TABLE CL_DEMANDE
(
    DEM_NUMRESA NUMBER(5)  NOT NULL,
    CLI_NUM NUMBER(4)  NOT NULL,
    PAY_CODE VARCHAR2(3)  NOT NULL,
    CAT_NUM NUMBER(3)  NOT NULL,
    AGE_NUM_RENDRE NUMBER(3)  NOT NULL,
    AGE_NUM_EMPRUNTER NUMBER(3)  NOT NULL,
    DEM_DEMPRUNT DATE  NULL,
    DEM_DRETOUR DATE  NULL,
    CONSTRAINT PK_CL_DEMANDE PRIMARY KEY (DEM_NUMRESA)  
);

CREATE  INDEX I_FK_CL_DEMANDE_CL_CLIENT
     ON CL_DEMANDE (PAY_CODE ASC, CLI_NUM ASC);

CREATE  INDEX I_FK_CL_DEMANDE_CL_CAT_VEHICUL
     ON CL_DEMANDE (CAT_NUM ASC);

CREATE  INDEX I_FK_CL_DEMANDE_CL_AGENCE
     ON CL_DEMANDE (AGE_NUM_RENDRE ASC);

CREATE  INDEX I_FK_CL_DEMANDE_CL_AGENCE2
     ON CL_DEMANDE (AGE_NUM_EMPRUNTER ASC);

CREATE TABLE CL_CAT_VEHICULE
(
    CAT_NUM NUMBER(3)  NOT NULL,
    CAT_LIBELLE CHAR(32)  NULL,
    CAT_PHOTO VARCHAR2(1000)  NULL,
    CAT_PRIXJOUR NUMBER(10,2)  NULL,
    CONSTRAINT PK_CL_CAT_VEHICULE PRIMARY KEY (CAT_NUM)  
);

CREATE TABLE CL_AGENCE
(
    AGE_NUM NUMBER(3)  NOT NULL,
    PAY_CODE VARCHAR2(3)  NOT NULL,
    AGE_VILLE VARCHAR2(32)  NULL,
    AGE_ADRESSE VARCHAR2(32)  NULL,
    AGE_CPOSTAL VARCHAR2(16)  NULL,
    AGE_TELEPHONE VARCHAR2(16)  NULL,
    CONSTRAINT PK_CL_AGENCE PRIMARY KEY (AGE_NUM)  
);

CREATE  INDEX I_FK_CL_AGENCE_CL_PAYS
     ON CL_AGENCE (PAY_CODE ASC);

CREATE TABLE CL_FIDELISE
(
    CLI_NUM NUMBER(4)  NOT NULL,
    PAY_CODE VARCHAR2(3)  NOT NULL,
    FID_DNAISSANCE DATE  NULL,
    FID_NPERMIS VARCHAR2(32)  NULL,
    FID_DPERMIS DATE  NULL,
    FID_NUMCB VARCHAR2(32)  NULL,
    FID_DEXPCB DATE  NULL,
    FID_NBPOINTS NUMBER(6)  NULL,
    CONSTRAINT PK_CL_FIDELISE PRIMARY KEY (PAY_CODE, CLI_NUM)  
);

CREATE TABLE CL_UTILITAIRE
(
    CAT_NUM NUMBER(3)  NOT NULL,
    UTI_VOLUME NUMBER(10,2)  NULL,
    UTI_CHARGEUTILE NUMBER(10,2)  NULL,
    UTI_LONGUEUR NUMBER(10,2)  NULL,
    UTI_LARGEUR NUMBER(10,2)  NULL,
    UTI_HAUTEUR NUMBER(10,2)  NULL,
    CONSTRAINT PK_CL_UTILITAIRE PRIMARY KEY (CAT_NUM)  
);

CREATE TABLE CL_PROXIMITE
(
    AGE_NUM_2 NUMBER(3)  NOT NULL,
    AGE_NUM_1 NUMBER(3)  NOT NULL,
    CONSTRAINT PK_CL_PROXIMITE PRIMARY KEY (AGE_NUM_2, AGE_NUM_1)  
);

CREATE  INDEX I_FK_CL_PROXIMITE_CL_AGENCE
     ON CL_PROXIMITE (AGE_NUM_2 ASC);

CREATE  INDEX I_FK_CL_PROXIMITE_CL_AGENCE1
     ON CL_PROXIMITE (AGE_NUM_1 ASC);

CREATE TABLE CL_OUVRIR
(
    HO_NJOUR NUMBER(1)  NOT NULL,
    AGE_NUM NUMBER(3)  NOT NULL,
    OUV_HOUVERTURE DATE  NULL,
    OUV_HFERMETURE DATE  NULL,
    CONSTRAINT PK_CL_OUVRIR PRIMARY KEY (HO_NJOUR, AGE_NUM)  
);

CREATE  INDEX I_FK_CL_OUVRIR_CL_HEURES_OUVER
     ON CL_OUVRIR (HO_NJOUR ASC);

CREATE  INDEX I_FK_CL_OUVRIR_CL_AGENCE
     ON CL_OUVRIR (AGE_NUM ASC);

CREATE TABLE CL_GAGNER
(
    BON_NBJOURS NUMBER(4)  NOT NULL,
    CAT_NUM NUMBER(3)  NOT NULL,
    GAG_NBPOINTS NUMBER(6)  NULL,
    CONSTRAINT PK_CL_GAGNER PRIMARY KEY (BON_NBJOURS, CAT_NUM)  
);

CREATE  INDEX I_FK_CL_GAGNER_CL_BONIFICATION
     ON CL_GAGNER (BON_NBJOURS ASC);

CREATE  INDEX I_FK_CL_GAGNER_CL_CAT_VEHICULE
     ON CL_GAGNER (CAT_NUM ASC);

ALTER TABLE CL_TOURISME ADD (
     CONSTRAINT FK_CL_TOURISME_CL_CAT_VEHICULE
          FOREIGN KEY (CAT_NUM)
               REFERENCES CL_CAT_VEHICULE (CAT_NUM));

ALTER TABLE CL_CLIENT ADD (
     CONSTRAINT FK_CL_CLIENT_CL_PAYS
          FOREIGN KEY (PAY_CODE)
               REFERENCES CL_PAYS (PAY_CODE));

ALTER TABLE CL_OCCASIONNEL ADD (
     CONSTRAINT FK_CL_OCCASIONNEL_CL_CLIENT
          FOREIGN KEY (PAY_CODE, CLI_NUM)
               REFERENCES CL_CLIENT (PAY_CODE, CLI_NUM));

ALTER TABLE CL_DEMANDE ADD (
     CONSTRAINT FK_CL_DEMANDE_CL_CLIENT
          FOREIGN KEY (PAY_CODE, CLI_NUM)
               REFERENCES CL_CLIENT (PAY_CODE, CLI_NUM));

ALTER TABLE CL_DEMANDE ADD (
     CONSTRAINT FK_CL_DEMANDE_CL_CAT_VEHICULE
          FOREIGN KEY (CAT_NUM)
               REFERENCES CL_CAT_VEHICULE (CAT_NUM));

ALTER TABLE CL_DEMANDE ADD (
     CONSTRAINT FK_CL_DEMANDE_CL_AGENCE
          FOREIGN KEY (AGE_NUM_RENDRE)
               REFERENCES CL_AGENCE (AGE_NUM));

ALTER TABLE CL_DEMANDE ADD (
     CONSTRAINT FK_CL_DEMANDE_CL_AGENCE2
          FOREIGN KEY (AGE_NUM_EMPRUNTER)
               REFERENCES CL_AGENCE (AGE_NUM));

ALTER TABLE CL_AGENCE ADD (
     CONSTRAINT FK_CL_AGENCE_CL_PAYS
          FOREIGN KEY (PAY_CODE)
               REFERENCES CL_PAYS (PAY_CODE));

ALTER TABLE CL_FIDELISE ADD (
     CONSTRAINT FK_CL_FIDELISE_CL_CLIENT
          FOREIGN KEY (PAY_CODE, CLI_NUM)
               REFERENCES CL_CLIENT (PAY_CODE, CLI_NUM));

ALTER TABLE CL_UTILITAIRE ADD (
     CONSTRAINT FK_CL_UTILITAIRE_CL_CAT_VEHICU
          FOREIGN KEY (CAT_NUM)
               REFERENCES CL_CAT_VEHICULE (CAT_NUM));

ALTER TABLE CL_PROXIMITE ADD (
     CONSTRAINT FK_CL_PROXIMITE_CL_AGENCE
          FOREIGN KEY (AGE_NUM_2)
               REFERENCES CL_AGENCE (AGE_NUM));

ALTER TABLE CL_PROXIMITE ADD (
     CONSTRAINT FK_CL_PROXIMITE_CL_AGENCE1
          FOREIGN KEY (AGE_NUM_1)
               REFERENCES CL_AGENCE (AGE_NUM));

ALTER TABLE CL_OUVRIR ADD (
     CONSTRAINT FK_CL_OUVRIR_CL_HEURES_OUVERTU
          FOREIGN KEY (HO_NJOUR)
               REFERENCES CL_HEURES_OUVERTURES (HO_NJOUR));

ALTER TABLE CL_OUVRIR ADD (
     CONSTRAINT FK_CL_OUVRIR_CL_AGENCE
          FOREIGN KEY (AGE_NUM)
               REFERENCES CL_AGENCE (AGE_NUM));


ALTER TABLE CL_GAGNER ADD (
     CONSTRAINT FK_CL_GAGNER_CL_CAT_VEHICULE
          FOREIGN KEY (CAT_NUM)
               REFERENCES CL_CAT_VEHICULE (CAT_NUM));

-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------
insert into cl_pays values ('ERI','ERYTHREE');
insert into cl_pays values ('FRA','FRANCE');
insert into cl_pays values ('GBR','ROYAUME UNI');
insert into cl_pays values ('GER','ALLEMAGNE');
insert into cl_pays values ('AUT','AUTRICHE');
insert into cl_pays values ('BEL','BELGIQUE');
insert into cl_pays values ('CAN','CANADA');
insert into cl_pays values ('KEN','KENYA');

insert into CL_AGENCE values (1,'FRA','NANTES','GARE SNCF ACCES SUD',44000,'+033 240 000 000');
insert into CL_AGENCE values (3,'FRA','LA BAULE','GARE SNCF',44500,'+033 240 000 001');
insert into CL_AGENCE values (4,'FRA','SAINT NAZAIRE','GARE SNCF',44600,'+033 240 000 002');
insert into CL_AGENCE values (5,'FRA','CAEN','GARE SNCF',14000,'+033 231 000 002');
insert into CL_AGENCE values (6,'FRA','IFS','TERMINUS TRAM',14123,'+033 231 000 003');
insert into CL_AGENCE values (7,'FRA','CARPIQUET','AEROPORT',14650,'+033 231 000 004');
insert into CL_AGENCE values (8,'FRA','PARIS','GARE DU NORD',75000,'+810 879 479');
insert into CL_AGENCE values (9,'FRA','PARIS','GARE DE L''EST',75000,'+810 879 479');
insert into CL_AGENCE values (10,'FRA','PARIS','GARE MONTPARNASSE',75000,'+810 879 479');
insert into CL_AGENCE values (11,'FRA','PARIS','GARE SAINT LAZARE',75008,'+810 879 479');
insert into CL_AGENCE values (12,'GBR','LONDON','AIRPORT',1,'XX');
insert into CL_AGENCE values (13,'GBR','LONDON','TRAIN',1,'XX');
insert into CL_AGENCE values (14,'GBR','PORTHMOUTH','FERRY',1,'XX');

insert into cl_heures_ouvertures VALUES (1,'lundi');
insert into cl_heures_ouvertures VALUES (2,'mardi');
insert into cl_heures_ouvertures VALUES (3,'mercredi');
insert into cl_heures_ouvertures VALUES (4,'jeudi');
insert into cl_heures_ouvertures VALUES (5,'vendredi');
insert into cl_heures_ouvertures VALUES (6,'samedi');
insert into cl_heures_ouvertures VALUES (7,'dimanche');

insert into cl_ouvrir values (1,1, to_date('07:00','HH24:MI'),to_date('22:00','HH24:MI'));
insert into cl_ouvrir values (2,1, to_date('07:00','HH24:MI'),to_date('22:00','HH24:MI'));
insert into cl_ouvrir values (3,1, to_date('07:00','HH24:MI'),to_date('22:00','HH24:MI'));
insert into cl_ouvrir values (4,1, to_date('07:00','HH24:MI'),to_date('22:00','HH24:MI'));
insert into cl_ouvrir values (5,1, to_date('07:00','HH24:MI'),to_date('22:00','HH24:MI'));
insert into cl_ouvrir values (6,1, to_date('08:30','HH24:MI'),to_date('20:00','HH24:MI'));
insert into cl_ouvrir values (1,8, to_date('07:00','HH24:MI'),to_date('23:00','HH24:MI'));
insert into cl_ouvrir values (2,8, to_date('07:00','HH24:MI'),to_date('23:00','HH24:MI'));
insert into cl_ouvrir values (3,8, to_date('07:00','HH24:MI'),to_date('23:00','HH24:MI'));
insert into cl_ouvrir values (4,8, to_date('07:00','HH24:MI'),to_date('23:00','HH24:MI'));
insert into cl_ouvrir values (5,8, to_date('07:00','HH24:MI'),to_date('23:00','HH24:MI'));
insert into cl_ouvrir values (6,8, to_date('08:00','HH24:MI'),to_date('23:00','HH24:MI'));
insert into cl_ouvrir values (7,8, to_date('10:30','HH24:MI'),to_date('20:00','HH24:MI'));
insert into cl_ouvrir values (1,3, to_date('08:00','HH24:MI'),to_date('20:00','HH24:MI'));
insert into cl_ouvrir values (2,3, to_date('08:00','HH24:MI'),to_date('20:00','HH24:MI'));
insert into cl_ouvrir values (3,3, to_date('08:00','HH24:MI'),to_date('20:00','HH24:MI'));

insert into cl_proximite values (1,3);
insert into cl_proximite values (1,4);
insert into cl_proximite values (3,4);
insert into cl_proximite values (5,6);
insert into cl_proximite values (5,7);
insert into cl_proximite values (6,7);
insert into cl_proximite values (8,9);
insert into cl_proximite values (8,10);
insert into cl_proximite values (8,11);
insert into cl_proximite values (9,10);
insert into cl_proximite values (9,11);
insert into cl_proximite values (10,11);
insert into cl_proximite values (12,13);

insert into cl_cat_vehicule values (1,'Catégorie A',null,50);
insert into cl_cat_vehicule values (2,'Catégorie A',null,60);
insert into cl_cat_vehicule values (3,'Catégorie A',null,70);
insert into cl_cat_vehicule values (4,'Catégorie B',null,90);
insert into cl_cat_vehicule values (5,'Catégorie B',null,110);
insert into cl_cat_vehicule values (6,'Catégorie K',null,120);
insert into cl_cat_vehicule values (7,'Catégorie L',null,180);

insert into cl_tourisme values (1,0,3,4,2);
insert into cl_tourisme values (2,0,5,5,2);
insert into cl_tourisme values (3,1,5,5,3);
insert into cl_tourisme values (4,1,5,5,3);
insert into cl_tourisme values (5,1,5,5,4);

insert into cl_utilitaire values (6,3.13,0.59,4.23,1.67,1.81);
insert into cl_utilitaire values (7,5.80,1.12,5.45,1.90,2.25);

insert into cl_client  values (4,'FRA','Mme','MARIE','Veronique','3 rue Bleriot',14000,'Caen',null,'v.marie@gmal.com');
insert into cl_client  values (5,'FRA','Mr','LE BOURGEOIS','Bernard','2 rue cardinal Lavigerie',14300,'Caen','0033 231 112 118','nanard@orage.fr');
insert into cl_client  values (5,'GBR','Mr','SMITH','Tom','63 Oracle Road',null,'London',null,'tom.smith43@free.uk');
insert into cl_client  values (7,'FRA','Mme','MARIE','Josiane','6 avenue Philipe B.',14123,'Ifs','0033 621 112 112','j.marie@frie.fr');
insert into cl_client  values (8,'FRA','Mr','DURAND','Paul','5 allée des tomates',14123,'Ifs','0033 231 202 020','paul.durand@wanadoo.fr');
insert into cl_client  values (9,'FRA','Mr','POULEQ','Patrick','4 boullevard Platini',44000,'Nantes','0033 612 202 021',null);
insert into cl_client  values (10,'FRA','Mme','NEIGE','Blanche','5 rue du Bois',44000,'Nantes','0033 612 202 022',null);
insert into cl_client  values (11,'KEN','Mr','LEPETIT','Juan-Yvos','Tribu des panthères',null,'Kisumu',null,'jylepetit@wanadogou.ke');
insert into cl_client  values (7,'GBR','Mme','SUPORMOI','Sylvia','allée du labo',null,'Wimbledon',null,null);
insert into cl_client  values (16,'FRA','Mr','LITON','Samir','15 rue de provence',14123,'Ifs','0033 123 888 456','samirliton@orage.fr');
insert into cl_client  values (18,'FRA','Mme','JORT','Etama','5 impasse de RT',14123,'Ifs','0033 623 524 456','etamajort@frie.fr');
insert into cl_client  values (20,'FRA','Mme','DURAND','Simone','5 allée des tomates',14123,'Ifs','0033 729 113 115','simone.durand@gmal.com');

insert into cl_fidelise  values (4 ,'FRA','12/04/1968','12345' ,'30/03/1987','4978330010000325','01/04/2011',100);
insert into cl_fidelise  values (5 ,'FRA','6/05/1978','12346'  ,'30/12/1997','4978330010000326','01/04/2011',20);
insert into cl_fidelise  values (10,'FRA','12/04/1954','12348' ,'10/03/1980','4978330010000328','01/02/2010',100);
insert into cl_fidelise  values (18,'FRA','02/06/1989','82345' ,'02/06/2007','4978330010000345','01/11/2009',100);
insert into cl_fidelise  values (7 ,'GBR','02/06/1976','823534','02/08/1992','1234530078900345','15/05/2011',80);
insert into cl_fidelise  values (16,'FRA','02/06/1979','782345','05/01/2018','0123588217478787','10/01/2018',2);

insert into cl_occasionnel  values (5,'GBR','CB');
insert into cl_occasionnel  values (7,'FRA','CHEQUE');
insert into cl_occasionnel  values (8,'FRA','VIREMENT');
insert into cl_occasionnel  values (11,'KEN','OR');

insert into cl_demande  values (65 ,4 ,'FRA',1,1 ,1 ,'02/05/2015','02/05/2015');
insert into cl_demande  values (66 ,5 ,'FRA',1,4 ,4 ,'03/05/2015','03/05/2015');
insert into cl_demande  values (98 ,5 ,'GBR',2,5 ,6 ,'03/05/2016','03/05/2016');
insert into cl_demande  values (194,8 ,'FRA',3,1 ,1 ,'02/01/2017','06/01/2017');
insert into cl_demande  values (305,9 ,'FRA',6,5 ,5 ,'07/05/2017','09/05/2017');
insert into cl_demande  values (324,9 ,'FRA',6,5 ,5 ,'14/05/2017','18/05/2017');
insert into cl_demande  values (405,10,'FRA',7,6 ,8 ,'15/07/2017','06/08/2017');
insert into cl_demande  values (505,11,'KEN',7,11,7 ,'01/09/2017','30/12/2017');
insert into cl_demande  values (604,4 ,'FRA',4,1 ,3 ,'01/09/2017','10/09/2017');
insert into cl_demande  values (708,7 ,'GBR',5,4 ,4 ,'20/11/2017','22/11/2017');
insert into cl_demande  values (759,18,'FRA',2,3 ,3 ,'04/01/2018','04/01/2018');
insert into cl_demande  values (761,16,'FRA',3,7 ,7 ,'09/01/2018','09/01/2018');
insert into cl_demande  values (789,7 ,'GBR',6,12,14,'1/04/2018','25/04/2018');
insert into cl_demande  values (805,18,'FRA',7,12,13,'4/03/2018','13/03/2018');
insert into cl_demande  values (835,7 ,'GBR',3,1 ,1 ,'16/05/2018','18/05/2018');
insert into cl_demande  values (845,16,'FRA',6,1 ,3 ,'1/06/2018','13/06/2018');

--insert into cl_demande  values (77,9,3,7,7,'09/08/2009','09/08/2012');

insert into cl_gagner  values (1,1,5);
insert into cl_gagner  values (5,1,15);
insert into cl_gagner  values (8,1,30);
insert into cl_gagner  values (15,1,70);
insert into cl_gagner  values (1,2,10);
insert into cl_gagner  values (5,2,25);
insert into cl_gagner  values (8,2,50);
insert into cl_gagner  values (15,2,120);

commit;