-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                     (16/4/2018 17:34:59)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR3
--      Projet : seg
--      Auteur : IUT DE CAEN
--      Date de dernière modification : 16/4/2018 17:25:09
-- -----------------------------------------------------------------------------

DROP TABLE SEG_POMPAGE CASCADE CONSTRAINTS;
DROP TABLE SEG_MOIS CASCADE CONSTRAINTS;
DROP TABLE SEG_CAPTAGE CASCADE CONSTRAINTS;
DROP TABLE SEG_FORAGE CASCADE CONSTRAINTS;
DROP TABLE SEG_TECHNICIEN CASCADE CONSTRAINTS;
DROP TABLE SEG_ANALYSE CASCADE CONSTRAINTS;
DROP TABLE SEG_ENTERRE CASCADE CONSTRAINTS;
DROP TABLE SEG_SUBSTANCE CASCADE CONSTRAINTS;
DROP TABLE SEG_AERIEN CASCADE CONSTRAINTS;
DROP TABLE SEG_RESERVOIR CASCADE CONSTRAINTS;
DROP TABLE SEG_CONTENIR CASCADE CONSTRAINTS;
DROP TABLE SEG_ALIMENTER_SECOURS CASCADE CONSTRAINTS;
DROP TABLE SEG_POSSEDE CASCADE CONSTRAINTS;

CREATE TABLE SEG_POMPAGE
(
    CAP_CODE varchar2(5)  NOT NULL,
    POM_NATURE VARCHAR2(20)  NULL,
    CONSTRAINT PK_SEG_POMPAGE PRIMARY KEY (CAP_CODE)  
);

CREATE TABLE SEG_MOIS
(
    MOI_NUMERO NUMBER(2)  NOT NULL,
    MOI_LIBELLE VARCHAR2(32)  NULL,
    CONSTRAINT PK_SEG_MOIS PRIMARY KEY (MOI_NUMERO)  
);

CREATE TABLE SEG_CAPTAGE
(
    CAP_CODE varchar2(5)  NOT NULL,
    CAP_NOM VARCHAR2(32)  NULL,
    CAP_DEBIT_MAX NUMBER(5,2)  NULL,
    CONSTRAINT PK_SEG_CAPTAGE PRIMARY KEY (CAP_CODE)  
);

CREATE TABLE SEG_FORAGE
(
    CAP_CODE varchar2(5)  NOT NULL,
    FOR_PROFONDEUR NUMBER(3)  NULL,
    FOR_DIAMETRE NUMBER(3)  NULL,
    CONSTRAINT PK_SEG_FORAGE PRIMARY KEY (CAP_CODE)  
);

CREATE TABLE SEG_TECHNICIEN
(
    TEC_MATRICULE varchar2(4)  NOT NULL,
    TEC_NOM VARCHAR2(32)  NULL,
    TEC_PRENOM VARCHAR2(32)  NULL,
    TEC_TELEPHONE varchar2(14)  NULL,
    CONSTRAINT PK_SEG_TECHNICIEN PRIMARY KEY (TEC_MATRICULE)  
);

CREATE TABLE SEG_ANALYSE
(
    ANA_ID NUMBER(3)  NOT NULL,
    RES_CODE varchar2(5)  NOT NULL,
    CAP_CODE varchar2(5)  NOT NULL,
    ANA_DATE DATE  NULL,
    ANA_ESCHERICHIA_COLI NUMBER(5,2)  NULL,
    ANA_ENTEROCOQUE NUMBER(5,2)  NULL,
    CONSTRAINT PK_SEG_ANALYSE PRIMARY KEY (RES_CODE, ANA_ID)  
);

CREATE  INDEX I_FK_SEG_ANALYSE_SEG_RESERVOIR
     ON SEG_ANALYSE (RES_CODE ASC)


CREATE  INDEX I_FK_SEG_ANALYSE_SEG_CAPTAGE
     ON SEG_ANALYSE (CAP_CODE ASC);

CREATE TABLE SEG_ENTERRE
(
    RES_CODE varchar2(5)  NOT NULL,
    ENT_DEBIT varchar2(32)  NULL,
    CONSTRAINT PK_SEG_ENTERRE PRIMARY KEY (RES_CODE)  
);

CREATE TABLE SEG_SUBSTANCE
(
    SUB_CODE VARCHAR2(32)  NOT NULL,
    SUB_NOM VARCHAR2(32)  NULL,
    SUB_VALMAX NUMBER(8,4)  NULL,
    CONSTRAINT PK_SEG_SUBSTANCE PRIMARY KEY (SUB_CODE)  
);

CREATE TABLE SEG_AERIEN
(
    RES_CODE varchar2(5)  NOT NULL,
    AER_HAUTEUR_MIN NUMBER(3)  NULL,
    AER_HAUTEUR_MAX NUMBER(3)  NULL,
    AER_TEMPS_REMPLISSAGE NUMBER(2)  NULL,
    AER_PRESSION NUMBER(3)  NULL,
    CONSTRAINT PK_SEG_AERIEN PRIMARY KEY (RES_CODE)  
);

CREATE TABLE SEG_RESERVOIR
(
    RES_CODE varchar2(5)  NOT NULL,
    CAP_CODE varchar2(5)  NOT NULL,
    RES_NOM VARCHAR2(32)  NULL,
    RES_CAPACITE_MAX NUMBER(6,2)  NULL,
    CONSTRAINT PK_SEG_RESERVOIR PRIMARY KEY (RES_CODE)  
);

CREATE  INDEX I_FK_SEG_RESERVOIR_SEG_CAPTAGE
     ON SEG_RESERVOIR (CAP_CODE ASC)
;

CREATE TABLE SEG_CONTENIR
(
    ANA_ID NUMBER(3)  NOT NULL,
    RES_CODE varchar2(5)  NOT NULL,
    SUB_CODE VARCHAR2(32)  NOT NULL,
    CON_QUANTITE NUMBER(8,2)  NULL,
    CONSTRAINT PK_SEG_CONTENIR PRIMARY KEY (RES_CODE, ANA_ID, SUB_CODE)  
);

CREATE  INDEX I_FK_SEG_CONTENIR_SEG_ANALYSE
     ON SEG_CONTENIR (RES_CODE ASC, ANA_ID ASC);

CREATE  INDEX I_FK_SEG_CONTENIR_SEG_SUBSTANC
     ON SEG_CONTENIR (SUB_CODE ASC);

CREATE TABLE SEG_ALIMENTER_SECOURS
(
    RES_CODE varchar2(5)  NOT NULL,
    CAP_CODE varchar2(5)  NOT NULL,
    TEC_MATRICULE varchar2(4)  NOT NULL,
    ALS_REMARQUE VARCHAR2(64)  NULL,
    CONSTRAINT PK_SEG_ALIMENTER_SECOURS PRIMARY KEY (RES_CODE, CAP_CODE)  
);

CREATE  INDEX I_FK_SEG_ALIMENTER_SECOURS_SEG
     ON SEG_ALIMENTER_SECOURS (RES_CODE ASC);

CREATE  INDEX I_FK_SEG_ALIMENTER_SECOURS_SE1
     ON SEG_ALIMENTER_SECOURS (CAP_CODE ASC);

CREATE  INDEX I_FK_SEG_ALIMENTER_SECOURS_SE2
     ON SEG_ALIMENTER_SECOURS (TEC_MATRICULE ASC);

CREATE TABLE SEG_POSSEDE
(
    MOI_NUMERO NUMBER(2)  NOT NULL,
    CAP_CODE varchar2(5)  NOT NULL,
    POS_DEBIT_MOYEN NUMBER(5,2)  NULL,
    CONSTRAINT PK_SEG_POSSEDE PRIMARY KEY (MOI_NUMERO, CAP_CODE)  
);

CREATE  INDEX I_FK_SEG_POSSEDE_SEG_MOIS
     ON SEG_POSSEDE (MOI_NUMERO ASC);

CREATE  INDEX I_FK_SEG_POSSEDE_SEG_CAPTAGE
     ON SEG_POSSEDE (CAP_CODE ASC);


ALTER TABLE SEG_POMPAGE ADD (
     CONSTRAINT FK_SEG_POMPAGE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_FORAGE ADD (
     CONSTRAINT FK_SEG_FORAGE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_ANALYSE ADD (
     CONSTRAINT FK_SEG_ANALYSE_SEG_RESERVOIR
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_ANALYSE ADD (
     CONSTRAINT FK_SEG_ANALYSE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_ENTERRE ADD (
     CONSTRAINT FK_SEG_ENTERRE_SEG_RESERVOIR
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_AERIEN ADD (
     CONSTRAINT FK_SEG_AERIEN_SEG_RESERVOIR
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_RESERVOIR ADD (
     CONSTRAINT FK_SEG_RESERVOIR_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_CONTENIR ADD (
     CONSTRAINT FK_SEG_CONTENIR_SEG_ANALYSE
          FOREIGN KEY (RES_CODE, ANA_ID)
               REFERENCES SEG_ANALYSE (RES_CODE, ANA_ID));

ALTER TABLE SEG_CONTENIR ADD (
     CONSTRAINT FK_SEG_CONTENIR_SEG_SUBSTANCE
          FOREIGN KEY (SUB_CODE)
               REFERENCES SEG_SUBSTANCE (SUB_CODE));

ALTER TABLE SEG_ALIMENTER_SECOURS ADD (
     CONSTRAINT FK_SEG_ALIMENTER_SECOURS_SEG_R
          FOREIGN KEY (RES_CODE)
               REFERENCES SEG_RESERVOIR (RES_CODE));

ALTER TABLE SEG_ALIMENTER_SECOURS ADD (
     CONSTRAINT FK_SEG_ALIMENTER_SECOURS_SEG_C
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));

ALTER TABLE SEG_ALIMENTER_SECOURS ADD (
     CONSTRAINT FK_SEG_ALIMENTER_SECOURS_SEG_T
          FOREIGN KEY (TEC_MATRICULE)
               REFERENCES SEG_TECHNICIEN (TEC_MATRICULE));

ALTER TABLE SEG_POSSEDE ADD (
     CONSTRAINT FK_SEG_POSSEDE_SEG_MOIS
          FOREIGN KEY (MOI_NUMERO)
               REFERENCES SEG_MOIS (MOI_NUMERO));

ALTER TABLE SEG_POSSEDE ADD (
     CONSTRAINT FK_SEG_POSSEDE_SEG_CAPTAGE
          FOREIGN KEY (CAP_CODE)
               REFERENCES SEG_CAPTAGE (CAP_CODE));


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------

insert into seg_mois values (1,'JANVIER');
insert into seg_mois values (2,'FEVRIER');
insert into seg_mois values (3,'MARS');
insert into seg_mois values (4,'AVRIL');
insert into seg_mois values (5,'MAI');
insert into seg_mois values (6,'JUIN');
insert into seg_mois values (7,'JUILLET');
insert into seg_mois values (8,'AOUT');
insert into seg_mois values (9,'SEPTEMBRE');
insert into seg_mois values (10,'OCTOBRE');
insert into seg_mois values (11,'NOVEMBRE');
insert into seg_mois values (12,'DECEMBRE');

insert into seg_captage values('C01','forage de la petite gargouille',260);
insert into seg_captage values('C02','forage du rocher suchere',320);
insert into seg_captage values('C03','le trou du talus',400);
insert into seg_captage values('C04','la grotte aux loups',200);
insert into seg_captage values('C05','forage du bois des pins',280);
insert into seg_captage values('C06','lac de la forge',150);
insert into seg_captage values('C07','le bout du bout',170);
insert into seg_captage values('C08','la care de creu',165);
insert into seg_captage values('C09','la rémonde',105);
insert into seg_captage values('C10','rimogène',125);
insert into seg_captage values('C11','la rue du C3',500);

insert into seg_forage values('C01',150,15);
insert into seg_forage values('C02',220,25);
insert into seg_forage values('C03',450,28);
insert into seg_forage values('C04',171,9);
insert into seg_forage values('C05',350,5);
insert into seg_forage values('C11',610,12);

insert into seg_pompage values('C06','lac');
insert into seg_pompage values('C07','fleuve');
insert into seg_pompage values('C08','lac');
insert into seg_pompage values('C09','rivière');
insert into seg_pompage values('C10','lac');

insert into seg_possede values (1,'C01',125);
insert into seg_possede values (2,'C01',129);
insert into seg_possede values (3,'C01',140);
insert into seg_possede values (4,'C01',110);
insert into seg_possede values (5,'C01',105);
insert into seg_possede values (6,'C01',75);
insert into seg_possede values (7,'C01',60);
insert into seg_possede values (8,'C01',50);
insert into seg_possede values (9,'C01',73);
insert into seg_possede values (10,'C01',99);
insert into seg_possede values (11,'C01',118);
insert into seg_possede values (12,'C01',126);
insert into seg_possede values (1,'C02',110);
insert into seg_possede values (2,'C02',124);
insert into seg_possede values (3,'C02',135);
insert into seg_possede values (1,'C11',300);
insert into seg_possede values (2,'C11',350);
insert into seg_possede values (3,'C11',450);
insert into seg_possede values (4,'C11',320);
insert into seg_possede values (5,'C11',300);
insert into seg_possede values (6,'C11',120);
insert into seg_possede values (7,'C11',80);

insert into seg_technicien values ('T01','LEFORT','Patrice','06 22 33 44 55');
insert into seg_technicien values ('T02','PALA','Mehdi','06 22 33 44 56');
insert into seg_technicien values ('T03','LADOUR','Vivianne','06 22 33 44 56');
insert into seg_technicien values ('T04','LEFORT','Patrice','06 22 33 44 57');
insert into seg_technicien values ('T05','LEGRAND','Bernard','06 22 33 44 58');
insert into seg_technicien values ('T06','LEPETIT','Jean-Pierre','06 66 66 66 66');
insert into seg_technicien values ('T07','TROJ','Fabien','06 66 66 66 66');
insert into seg_technicien values ('T08','SUTURB','Philippe','06 22 33 44 59');
insert into seg_technicien values ('T09','XOUTORT','Didier','06 22 33 44 60');
insert into seg_technicien values ('T10','RAHL','Richard','06 22 33 44 61');
insert into seg_technicien values ('T15','RAHL','Darken','06 22 11 10 08');
insert into seg_technicien values ('T16','MUDA','Robert','06 99 88 77 66');
insert into seg_technicien values ('T18','HAIBON','Sylvain','06 33 44 58 66');

insert into seg_reservoir values ('R01','C05','dôme du loup',5000);
insert into seg_reservoir values ('R02','C09','sauge en gévaudan',4500);
insert into seg_reservoir values ('R03','C05','la ferme aux loutres',3500);
insert into seg_reservoir values ('R04','C02','la cave',8000);
insert into seg_reservoir values ('R05','C03','le champ de buisson',6000);
insert into seg_reservoir values ('R08','C10','Le puits du fioul',2000);
insert into seg_reservoir values ('R10','C11','la fontaine à eau',500);

insert into seg_aerien values ('R01',3 ,25,5,26);
insert into seg_aerien values ('R05',10,35,7,25);
insert into seg_aerien values ('R08',11,36,8,20);

insert into seg_enterre values ('R02',49);
insert into seg_enterre values ('R03',53);
insert into seg_enterre values ('R04',60);
insert into seg_enterre values ('R10',95);

insert into seg_alimenter_secours values ('R01','C08','T10','ne pas déclencher la procédure d''urgence');
insert into seg_alimenter_secours values ('R01','C10','T09','activer le relai de pompage');
insert into seg_alimenter_secours values ('R02','C08','T02','prévenir le centre de contrôle');
insert into seg_alimenter_secours values ('R02','C07','T10','diminuer le débit d''un tiers');
insert into seg_alimenter_secours values ('R03','C02','T10','enclencher la double alimentation');
insert into seg_alimenter_secours values ('R03','C03','T03','baisser le grpupe de surpression');
insert into seg_alimenter_secours values ('R03','C08','T04','ne pas activer le relai de pompage');

insert into seg_analyse values (1,'R01','C05','12/05/2017',0,0);
insert into seg_analyse values (2,'R01','C05','17/05/2017',0,0);

insert into seg_analyse values (1,'R02','C09','10/04/2018',0,0);
insert into seg_analyse values (2,'R02','C09','01/05/2018',1,0);
insert into seg_analyse values (3,'R02','C09','02/05/2018',0,0);
insert into seg_analyse values (1,'R03','C05','02/03/2017',0,0);
insert into seg_analyse values (2,'R03','C05','02/03/2010',0,0);
insert into seg_analyse values (3,'R03','C05','02/03/2010',0,0);
insert into seg_analyse values (4,'R03','C05','02/03/2010',0,0);

insert into seg_substance values (33,'arsenic',10);
insert into seg_substance values (82,'plomb',25);
insert into seg_substance values (48,'cadmium',5);
insert into seg_substance values (80,'mercure',10);
insert into seg_substance values (89,'gibolin',33);

insert into seg_contenir values (1,'R01',33,5);
insert into seg_contenir values (1,'R01',82,20);
insert into seg_contenir values (1,'R01',48,6);
insert into seg_contenir values (1,'R01',80,3);
insert into seg_contenir values (2,'R01',33,4);
insert into seg_contenir values (2,'R01',82,12);
insert into seg_contenir values (2,'R01',48,3);

insert into seg_contenir values (1,'R02',33,4);
insert into seg_contenir values (1,'R02',82,12);

insert into seg_contenir values (1,'R03',48,3);
insert into seg_contenir values (1,'R03',80,4);
insert into seg_contenir values (2,'R03',33,3);
insert into seg_contenir values (3,'R03',82,19);
insert into seg_contenir values (3,'R03',48,4);
insert into seg_contenir values (4,'R03',80,12);
insert into seg_contenir values (4,'R03',33,8);

commit;

/*
DROP TABLE SEG_CONTENIR CASCADE CONSTRAINTS;
DROP TABLE SEG_SUBSTANCE CASCADE CONSTRAINTS;
*/


SELECT * FROM SEG_MOIS ;
SELECT * FROM SEG_POSSEDE ;
SELECT * FROM SEG_CONTENIR ;
SELECT * FROM SEG_CAPTAGE ;
SELECT * FROM SEG_SUBSTANCE ;
SELECT * FROM SEG_POMPAGE ;
SELECT * FROM SEG_FORAGE ;
SELECT * FROM SEG_RESERVOIR ;
SELECT * FROM SEG_TECHNICIEN ;
SELECT * FROM SEG_ENTERRE ;
SELECT * FROM SEG_AERIEN ;
SELECT * FROM SEG_ALIMENTER_SECOURS ;
SELECT * FROM SEG_ANALYSE ;




