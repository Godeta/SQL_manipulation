-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                      Oracle Version 10g
--                     (13/4/2019 18:42:57)
-- -----------------------------------------------------------------------------
--      Nom de la base : MLR1_2019
--      Projet : essai
--      Auteur : Eric
--      Date de dernière modification : 13/4/2019 18:42:35
-- -----------------------------------------------------------------------------

DROP TABLE SFA_OUVRAGE CASCADE CONSTRAINTS;
DROP TABLE SFA_AUTEUR CASCADE CONSTRAINTS;
DROP TABLE SFA_MUSEE CASCADE CONSTRAINTS;
DROP TABLE SFA_VILLE CASCADE CONSTRAINTS;
DROP TABLE SFA_OBJET CASCADE CONSTRAINTS;
DROP TABLE SFA_ANCIENNE_VILLE CASCADE CONSTRAINTS;
DROP TABLE SFA_EDITEUR CASCADE CONSTRAINTS;
DROP TABLE SFA_SITE CASCADE CONSTRAINTS;
DROP TABLE SFA_REFERENCE CASCADE CONSTRAINTS;
DROP TABLE SFA_COLLABORATION CASCADE CONSTRAINTS;
DROP TABLE SFA_SUJET CASCADE CONSTRAINTS;

CREATE TABLE SFA_OUVRAGE
(
    OUV_NUM NUMBER(3)  NOT NULL,
    EDI_NUM NUMBER(3)  NOT NULL,
    OUV_TITRE VARCHAR2(64)  NULL,
    OUV_DATE_EDITION DATE  NULL,
    OUV_NB_PAGES NUMBER(4)  NULL,
    CONSTRAINT PK_SFA_OUVRAGE PRIMARY KEY (OUV_NUM)  
);


CREATE  INDEX I_FK_SFA_OUVRAGE_SFA_EDITEUR
     ON SFA_OUVRAGE (EDI_NUM ASC);

CREATE TABLE SFA_AUTEUR
(
    AUT_NUM NUMBER(3)  NOT NULL,
    AUT_NOM VARCHAR2(64)  NULL,
    CONSTRAINT PK_SFA_AUTEUR PRIMARY KEY (AUT_NUM)  
);

CREATE TABLE SFA_MUSEE
(
    MUS_CODE NUMBER(3)  NOT NULL,
    VIL_CODE NUMBER(4)  NOT NULL,
    MUS_NOM VARCHAR2(64)  NULL,
    CONSTRAINT PK_SFA_MUSEE PRIMARY KEY (MUS_CODE)  
);

CREATE  INDEX I_FK_SFA_MUSEE_SFA_VILLE
     ON SFA_MUSEE (VIL_CODE ASC);

CREATE TABLE SFA_VILLE
(
    VIL_CODE NUMBER(4)  NOT NULL,
    VIL_NOM_ACTUEL VARCHAR2(32)  NULL,
    CONSTRAINT PK_SFA_VILLE PRIMARY KEY (VIL_CODE)  
);

CREATE TABLE SFA_OBJET
(
    OBJ_NUM NUMBER(3)  NOT NULL,
    SIT_CODE NUMBER(3)  NOT NULL,
    VIL_CODE NUMBER(4)  NOT NULL,
    MUS_CODE NUMBER(3)  NOT NULL,
    OBJ_DESIGNATION VARCHAR2(64)  NULL,
    OBJ_TYPE VARCHAR2(32)  NULL,
    OBJ_ANNEE NUMBER(4)  NULL,
    CONSTRAINT PK_SFA_OBJET PRIMARY KEY (OBJ_NUM)  
);

CREATE  INDEX I_FK_SFA_OBJET_SFA_SITE
     ON SFA_OBJET (VIL_CODE ASC, SIT_CODE ASC);

CREATE  INDEX I_FK_SFA_OBJET_SFA_MUSEE
     ON SFA_OBJET (MUS_CODE ASC);

CREATE TABLE SFA_ANCIENNE_VILLE
(
    VIL_CODE NUMBER(4)  NOT NULL,
    ANC_NUM NUMBER(2)  NOT NULL,
    ANC_NOM VARCHAR2(64)  NULL,
    ANC_DATE_DEBUT DATE  NULL,
    ANC_DATE_FIN DATE  NULL,
    CONSTRAINT PK_SFA_ANCIENNE_VILLE PRIMARY KEY (VIL_CODE, ANC_NUM)  
);

CREATE  INDEX I_FK_SFA_ANCIENNE_VILLE_SFA_VI
     ON SFA_ANCIENNE_VILLE (VIL_CODE ASC);

CREATE TABLE SFA_EDITEUR
(
    EDI_NUM NUMBER(3)  NOT NULL,
    EDI_RAIS_SOC VARCHAR2(64)  NULL,
    CONSTRAINT PK_SFA_EDITEUR PRIMARY KEY (EDI_NUM)  
);

CREATE TABLE SFA_SITE
(
    VIL_CODE NUMBER(4)  NOT NULL,
    SIT_CODE NUMBER(3)  NOT NULL,
    SIT_DESIGNATION VARCHAR2(64)  NULL,
    SIT_CIVILISATION VARCHAR2(64)  NULL,
    CONSTRAINT PK_SFA_SITE PRIMARY KEY (VIL_CODE, SIT_CODE)  
);

CREATE  INDEX I_FK_SFA_SITE_SFA_VILLE
     ON SFA_SITE (VIL_CODE ASC);

CREATE TABLE SFA_REFERENCE
(
    OUV_NUM NUMBER(3)  NOT NULL,
    OBJ_NUM NUMBER(3)  NOT NULL,
    CONSTRAINT PK_SFA_REFERENCE PRIMARY KEY (OUV_NUM, OBJ_NUM)  
);

CREATE  INDEX I_FK_SFA_REFERENCE_SFA_OUVRAGE
     ON SFA_REFERENCE (OUV_NUM ASC);

CREATE  INDEX I_FK_SFA_REFERENCE_SFA_OBJET
     ON SFA_REFERENCE (OBJ_NUM ASC);

CREATE TABLE SFA_COLLABORATION
(
    AUT_NUM NUMBER(3)  NOT NULL,
    OUV_NUM NUMBER(3)  NOT NULL,
    CONSTRAINT PK_SFA_COLLABORATION PRIMARY KEY (AUT_NUM, OUV_NUM)  
);

CREATE  INDEX I_FK_SFA_COLLABORATION_SFA_AUT
     ON SFA_COLLABORATION (AUT_NUM ASC);

CREATE  INDEX I_FK_SFA_COLLABORATION_SFA_OUV
     ON SFA_COLLABORATION (OUV_NUM ASC);

CREATE TABLE SFA_SUJET
(
    OUV_NUM NUMBER(3)  NOT NULL,
    VIL_CODE NUMBER(4)  NOT NULL,
    SIT_CODE NUMBER(3)  NOT NULL,
    CONSTRAINT PK_SFA_SUJET PRIMARY KEY (OUV_NUM, VIL_CODE, SIT_CODE)  
);

CREATE  INDEX I_FK_SFA_SUJET_SFA_OUVRAGE
     ON SFA_SUJET (OUV_NUM ASC);

CREATE  INDEX I_FK_SFA_SUJET_SFA_SITE
     ON SFA_SUJET (VIL_CODE ASC, SIT_CODE ASC);

ALTER TABLE SFA_OUVRAGE ADD (
     CONSTRAINT FK_SFA_OUVRAGE_SFA_EDITEUR
          FOREIGN KEY (EDI_NUM)
               REFERENCES SFA_EDITEUR (EDI_NUM));

ALTER TABLE SFA_MUSEE ADD (
     CONSTRAINT FK_SFA_MUSEE_SFA_VILLE
          FOREIGN KEY (VIL_CODE)
               REFERENCES SFA_VILLE (VIL_CODE));

ALTER TABLE SFA_OBJET ADD (
     CONSTRAINT FK_SFA_OBJET_SFA_SITE
          FOREIGN KEY (VIL_CODE, SIT_CODE)
               REFERENCES SFA_SITE (VIL_CODE, SIT_CODE));

ALTER TABLE SFA_OBJET ADD (
     CONSTRAINT FK_SFA_OBJET_SFA_MUSEE
          FOREIGN KEY (MUS_CODE)
               REFERENCES SFA_MUSEE (MUS_CODE));

ALTER TABLE SFA_ANCIENNE_VILLE ADD (
     CONSTRAINT FK_SFA_ANCIENNE_VILLE_SFA_VILL
          FOREIGN KEY (VIL_CODE)
               REFERENCES SFA_VILLE (VIL_CODE));

ALTER TABLE SFA_SITE ADD (
     CONSTRAINT FK_SFA_SITE_SFA_VILLE
          FOREIGN KEY (VIL_CODE)
               REFERENCES SFA_VILLE (VIL_CODE));

ALTER TABLE SFA_REFERENCE ADD (
     CONSTRAINT FK_SFA_REFERENCE_SFA_OUVRAGE
          FOREIGN KEY (OUV_NUM)
               REFERENCES SFA_OUVRAGE (OUV_NUM));

ALTER TABLE SFA_REFERENCE ADD (
     CONSTRAINT FK_SFA_REFERENCE_SFA_OBJET
          FOREIGN KEY (OBJ_NUM)
               REFERENCES SFA_OBJET (OBJ_NUM));

ALTER TABLE SFA_COLLABORATION ADD (
     CONSTRAINT FK_SFA_COLLABORATION_SFA_AUTEU
          FOREIGN KEY (AUT_NUM)
               REFERENCES SFA_AUTEUR (AUT_NUM));

ALTER TABLE SFA_COLLABORATION ADD (
     CONSTRAINT FK_SFA_COLLABORATION_SFA_OUVRA
          FOREIGN KEY (OUV_NUM)
               REFERENCES SFA_OUVRAGE (OUV_NUM));

ALTER TABLE SFA_SUJET ADD (
     CONSTRAINT FK_SFA_SUJET_SFA_OUVRAGE
          FOREIGN KEY (OUV_NUM)
               REFERENCES SFA_OUVRAGE (OUV_NUM));

ALTER TABLE SFA_SUJET ADD (
     CONSTRAINT FK_SFA_SUJET_SFA_SITE
          FOREIGN KEY (VIL_CODE, SIT_CODE)
               REFERENCES SFA_SITE (VIL_CODE, SIT_CODE));


insert into sfa_auteur VALUES (1 ,'Voisenat');
insert into sfa_auteur VALUES (2 ,'Delamer');
insert into sfa_auteur VALUES (3 ,'Fagan');
insert into sfa_auteur VALUES (4 ,'Stiegler');
insert into sfa_auteur VALUES (5 ,'Barnes');
insert into sfa_auteur VALUES (6 ,'Demoule');
insert into sfa_auteur VALUES (7 ,'Pohribny');
insert into sfa_auteur VALUES (10,'TroisLoukoum');
insert into sfa_auteur VALUES (15,'Supormoi');
insert into sfa_auteur VALUES (25,'Tayou');
insert into sfa_auteur VALUES (28,'Rahan');

insert into sfa_editeur VALUES (1 ,'Flammarion');
insert into sfa_editeur VALUES (2 ,'Maison Des Sciences De L''Homme');
insert into sfa_editeur VALUES (3 ,'Grasset');
insert into sfa_editeur VALUES (5 ,'Rouge Et Or ');
insert into sfa_editeur VALUES (6 ,'La Decouverte');
insert into sfa_editeur VALUES (7 ,'Robert Laffont');
insert into sfa_editeur VALUES (8 ,'La Martiniere');
insert into sfa_editeur VALUES (15,'Bibliotèque Rose');
insert into sfa_editeur VALUES (37,'Top_Minitel');

insert into sfa_ouvrage VALUES (1 ,2,'Imaginaires Archeologiques','06/03/2009',1221);
insert into sfa_ouvrage VALUES (2 ,6,'L''Avenir Du Passe','15/04/2008',65);
insert into sfa_ouvrage VALUES (3 ,8,'Decouvertes ; Les Derniers Tresors','01/05/2008',354);
insert into sfa_ouvrage VALUES (4 ,5,'Archeologie','10/08/2007',620);
insert into sfa_ouvrage VALUES (5 ,6,'Le temps n''emporte pas les dents','16/04/2009',80);
insert into sfa_ouvrage VALUES (6 ,3,'Vertige des vestiges','10/09/2009',128);
insert into sfa_ouvrage VALUES (7 ,3,'La momification','01/04/2007',64);
insert into sfa_ouvrage VALUES (8 ,3,'La Magie Des Mégalithes',null,100);  
insert into sfa_ouvrage VALUES (25,15,'Allez plus loin avec Access','15/12/2014',1);  
insert into sfa_ouvrage VALUES (29,37,'Soyez performant avec Access','16/01/1980',50);  
insert into sfa_ouvrage VALUES (34,37,'Turbo Pascal','01/05/1982',950);  
insert into sfa_ouvrage VALUES (36,37,'La révolution télématique','01/02/1979',1055);  
insert into sfa_ouvrage VALUES (49,15,'Access 0.0.1','10/04/2019',10);  

insert into sfa_collaboration VALUES (1,1);
insert into sfa_collaboration VALUES (4,2);
insert into sfa_collaboration VALUES (6,2);
insert into sfa_collaboration VALUES (3,3);
insert into sfa_collaboration VALUES (5,4);
insert into sfa_collaboration VALUES (2,5);
insert into sfa_collaboration VALUES (7,6);
insert into sfa_collaboration VALUES (7,7);
insert into sfa_collaboration VALUES (1,7);
insert into sfa_collaboration VALUES (7,8);
insert into sfa_collaboration VALUES (15,25);
insert into sfa_collaboration VALUES (25,25);
insert into sfa_collaboration VALUES (10,29);
insert into sfa_collaboration VALUES (25,34);
insert into sfa_collaboration VALUES (28,36);
insert into sfa_collaboration VALUES (25,49);

insert into sfa_ville VALUES (1,'Paris');
insert into sfa_ville VALUES (2,'Marseille');
insert into sfa_ville VALUES (3,'Lyon');
insert into sfa_ville VALUES (4,'Bordeaux');
insert into sfa_ville VALUES (5,'Londres');
insert into sfa_ville VALUES (6,'Lisbonne');
insert into sfa_ville VALUES (7,'Saint-Petersbourg');
insert into sfa_ville VALUES (10,'Istanbul'); -- byzance
insert into sfa_ville VALUES (11,'Caen');
insert into sfa_ville VALUES (12,'Rouen');
insert into sfa_ville VALUES (13,'Lisieux');

insert into sfa_ancienne_ville VALUES (1 ,1,'Lutece'   ,null,'01/01/0310');
insert into sfa_ancienne_ville VALUES (2 ,1,'Massalia' ,to_date('01/01/-0600','dd/mm/syyyy'),null);
insert into sfa_ancienne_ville VALUES (3 ,1,'Lugdunum' ,to_date('01/01/-0043','dd/mm/syyyy'),null );
insert into sfa_ancienne_ville VALUES (4 ,1,'Burdigala',to_date('01/01/-0500','dd/mm/syyyy'),to_date('01/01/350','dd/mm/syyyy'));
insert into sfa_ancienne_ville VALUES (5 ,1,'Londinium','01/01/0043',null);
insert into sfa_ancienne_ville VALUES (6 ,1,'Olissipo',to_date('01/01/-1200','dd/mm/syyyy'),null);
insert into sfa_ancienne_ville VALUES (7 ,1,'Saint-Petersbourg','01/01/1301','01/01/1914');
insert into sfa_ancienne_ville VALUES (7 ,2,'Petrograd','01/01/1914','01/01/1924');
insert into sfa_ancienne_ville VALUES (7 ,3,'Leningrad','01/01/1914','01/01/1991');
insert into sfa_ancienne_ville VALUES (10,1,'Byzance',to_date('01/01/-700','dd/mm/syyyy'),'11/05/330');
insert into sfa_ancienne_ville VALUES (10,2,'Constantinople','11/05/330','01/01/1930');
insert into sfa_ancienne_ville VALUES (11,1,'Cadon','01/01/1021','31/12/1025');
insert into sfa_ancienne_ville VALUES (11,2,'Cathim','01/01/1026','31/12/1032');
insert into sfa_ancienne_ville VALUES (11,3,'Cadun','01/01/1033','01/01/1037');
insert into sfa_ancienne_ville VALUES (11,4,'Cadomi','01/01/1037','31/12/1060');
insert into sfa_ancienne_ville VALUES (11,5,'Cadomo','01/01/1063','31/12/1069');
insert into sfa_ancienne_ville VALUES (11,6,'Cadum','01/01/1070','31/12/1299');
insert into sfa_ancienne_ville VALUES (12,1,'Rothom','01/01/779','01/01/1130');
insert into sfa_ancienne_ville VALUES (13,1,'Noviomagus Lexoviorum','01/01/350',null);

insert into sfa_musee VALUES (1   ,1,'Le Louvre');
insert into sfa_musee VALUES (2   ,1,'Musée du Quai Branly');
insert into sfa_musee VALUES (51  ,2,'Musée d''archéologie méditerranéenne');
insert into sfa_musee VALUES (79  ,5,'Institute of Archaeology Collections');
insert into sfa_musee VALUES (96  ,6,'Calouste-Gulbenkian');
insert into sfa_musee VALUES (101 ,10,'Arkeoloji Müzesi');
insert into sfa_musee VALUES (102 ,10,'Ayasofya');
insert into sfa_musee VALUES (199 ,11,'Musee des Beaux-Arts');
insert into sfa_musee VALUES (200 ,11,'Mémorial');
insert into sfa_musee VALUES (201 ,11,'Musée du logiciel');
insert into sfa_musee VALUES (220 ,13,'Musée du Carmel');

insert into sfa_site VALUES (1,1,'Fouilles du prince','Gauloise');
insert into sfa_site VALUES (1,2,'Villanova','Romaine');
insert into sfa_site VALUES (1,6,'Ruines du carmo','Grèque');
insert into sfa_site VALUES (1,10,'Les berges du Bosphore','Perse');
insert into sfa_site VALUES (2,1,'Les voies romaines','Romaine');
insert into sfa_site VALUES (2,6,'La vieille ville','Gauloise');
insert into sfa_site VALUES (4,1,'La tour de granite','Perse');
insert into sfa_site VALUES (5,1,'Clos d''enfer','Grèque');
insert into sfa_site VALUES (11,1,'Le campus3','Viking');
insert into sfa_site VALUES (11,2,'La prairie','Viking');
insert into sfa_site VALUES (11,3,'L''impasse','Homo programus');
insert into sfa_site VALUES (11,4,'La campus2','Homo programus');

insert into sfa_sujet VALUES (1,1,1);
insert into sfa_sujet VALUES (1,2,1);
insert into sfa_sujet VALUES (1,1,6);
insert into sfa_sujet VALUES (2,1,1);
insert into sfa_sujet VALUES (3,1,2);
insert into sfa_sujet VALUES (4,2,6);
insert into sfa_sujet VALUES (4,1,10);
insert into sfa_sujet VALUES (5,1,6);
insert into sfa_sujet VALUES (25,11,3);
insert into sfa_sujet VALUES (25,11,4);
insert into sfa_sujet VALUES (29,11,2);
insert into sfa_sujet VALUES (34,11,3);
insert into sfa_sujet VALUES (36,11,3);
insert into sfa_sujet VALUES (49,11,2);

insert into sfa_objet VALUES (1  ,1,1,1,'Coupe de la vérité','frise',-100);
insert into sfa_objet VALUES (2  ,1,1,2,'Venus de Milo','statue',-130);
insert into sfa_objet VALUES (3  ,6,1,51,'venus de Bill','statue',850);
insert into sfa_objet VALUES (9  ,1,2,1,'Vase de Soisson','vase',-1000);
insert into sfa_objet VALUES (12 ,1,2,79,'la guerre des sages','statue',800);
insert into sfa_objet VALUES (18 ,6,2,102,'la guerre des boutons','statue',860);
insert into sfa_objet VALUES (24 ,1,5,199,'coupe de la liberté','coupe',200);
insert into sfa_objet VALUES (43 ,2,11,201,'le bol de Robert','céramique',520);
insert into sfa_objet VALUES (100,1,1,1,'coupe du monde','coupe',1998);
insert into sfa_objet VALUES (101,4,11,220,'coupe de glace','coupe',206);
insert into sfa_objet VALUES (108,2,11,220,'le pèlerinage','frise',260);
insert into sfa_objet VALUES (109,1,11,199,'le triomphe de Simone','frise',770);
insert into sfa_objet VALUES (123,1,11,200,'La tour Tayou','bâtiment',1998);
insert into sfa_objet VALUES (146,1,4,96,'le cendrier d''Auguste','céramique',1920);
insert into sfa_objet VALUES (201,4,11,201,'La jonture en VB','idiogramme',1986);
insert into sfa_objet VALUES (208,1,5,201,'le lanceur de DVD','statue',1999);
insert into sfa_objet VALUES (225,3,11,201,'le lance requête','outil',2016);
insert into sfa_objet VALUES (228,3,11,201,'Correcteur Microsoft','idiogramme',2019);

insert into sfa_reference VALUES (1,1);
insert into sfa_reference VALUES (1,2);
insert into sfa_reference VALUES (2,3);
insert into sfa_reference VALUES (3,9);
insert into sfa_reference VALUES (4,12);
insert into sfa_reference VALUES (5,18);
insert into sfa_reference VALUES (6,24);
insert into sfa_reference VALUES (7,43);
insert into sfa_reference VALUES (8,100);
insert into sfa_reference VALUES (25,108);
insert into sfa_reference VALUES (29,109);
insert into sfa_reference VALUES (34,123);
insert into sfa_reference VALUES (34,146);
insert into sfa_reference VALUES (49,201);
insert into sfa_reference VALUES (25,208);
insert into sfa_reference VALUES (29,225);
insert into sfa_reference VALUES (34,228);

commit;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/SYYYY';
select * from sfa_ancienne_ville;
select * from sfa_auteur;
select * from sfa_collaboration;
select * from sfa_editeur;
select * from sfa_musee;
select * from sfa_objet;
select * from sfa_ouvrage;
select * from sfa_reference;
select * from sfa_site;
select * from sfa_sujet;
select * from sfa_ville;
