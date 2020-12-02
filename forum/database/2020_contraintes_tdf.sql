-- les contraintes de la base
select 
'alter table '||table_name||' drop constraint '||constraint_name||';'
from all_constraints where table_name like 'TDF%' and owner = 'C##PATRICE';

select 
'drop index '|| index_name ||';'
from all_indexes where table_name like 'TDF%' and table_owner = 'C##PATRICE';

-- clés primaires
ALTER TABLE TDF_ABANDON ADD CONSTRAINT PK_TDF_ABANDON PRIMARY KEY (N_COUREUR, ANNEE);
ALTER TABLE TDF_ANNEE ADD CONSTRAINT PK_TDF_ANNEE PRIMARY KEY (ANNEE);
ALTER TABLE TDF_COUREUR ADD CONSTRAINT PK_TDF_COUREUR PRIMARY KEY (N_COUREUR);
ALTER TABLE TDF_DIRECTEUR ADD CONSTRAINT FK_TDF_DIRECTEUR PRIMARY KEY (N_DIRECTEUR);
ALTER TABLE tdf_etape ADD CONSTRAINT PK_tdf_etape PRIMARY KEY (ANNEE, n_etape, N_COMP);
ALTER TABLE TDF_EQUIPE ADD CONSTRAINT PK_TDF_EQUIPE PRIMARY KEY (N_EQUIPE);
ALTER TABLE tdf_parti_equipe  ADD CONSTRAINT PK_parti_equipe PRIMARY KEY (ANNEE, N_EQUIPE, N_SPONSOR);
ALTER TABLE TDF_ORDREQUI ADD CONSTRAINT PK_TDF_ORDREQUI PRIMARY KEY (ANNEE, N_EQUIPE, N_SPONSOR,TYPE_CLASSEMENT);
ALTER TABLE tdf_parti_coureur ADD CONSTRAINT PK_tdf_parti_coureur PRIMARY KEY (ANNEE, N_COUREUR);
ALTER TABLE TDF_nation ADD CONSTRAINT PK_TDF_nation PRIMARY KEY (code_cio);
ALTER TABLE TDF_SPONSOR ADD CONSTRAINT PK_TDF_SPONSOR PRIMARY KEY (N_EQUIPE, N_SPONSOR);
ALTER TABLE TDF_EQU_SUCCEDE ADD CONSTRAINT PK_TDF_EQU_SUCCEDE PRIMARY KEY (N_EQUIPE, N_EQ_SUCCESSEUR);
ALTER TABLE TDF_TEMPS ADD CONSTRAINT PK_TDF_TEMPS PRIMARY KEY (N_COUREUR, ANNEE, n_etape, N_COMP);
ALTER TABLE TDF_TEMPS_DIFFERENCE ADD CONSTRAINT PK_TDF_TEMPS_DIFFERENCE PRIMARY KEY (N_COUREUR, ANNEE);
ALTER TABLE TDF_TYPEABAN ADD CONSTRAINT PK_TDF_TYPEABAN PRIMARY KEY (C_TYPEABAN);
ALTER TABLE TDF_nat_succede ADD CONSTRAINT PK_tdf_nat_succede PRIMARY KEY (code_cio);
ALTER TABLE tdf_app_nation ADD CONSTRAINT PK_tdf_app_nation PRIMARY KEY (n_coureur, code_cio);
ALTER TABLE tdf_user ADD CONSTRAINT PK_tdf_user PRIMARY KEY (n_user);

-- clés étrangères
ALTER TABLE TDF_ABANDON ADD CONSTRAINT FK_TDF_ABANDOn_etape FOREIGN KEY (ANNEE, n_etape, N_COMP)
  REFERENCES tdf_etape (ANNEE, n_etape, N_COMP);
ALTER TABLE TDF_ABANDON ADD CONSTRAINT FK_TDF_ABANDON_ANNEE FOREIGN KEY (ANNEE)
  REFERENCES TDF_ANNEE (ANNEE);
ALTER TABLE TDF_ABANDON ADD CONSTRAINT FK_TDF_ABANDON_TYPEABAN FOREIGN KEY (C_TYPEABAN)
	  REFERENCES TDF_TYPEABAN (C_TYPEABAN);
ALTER TABLE TDF_ABANDON ADD CONSTRAINT FK_TDF_ABANDON_COUREUR FOREIGN KEY (N_COUREUR)
	  REFERENCES TDF_COUREUR (N_COUREUR);

ALTER TABLE TDF_app_nation ADD CONSTRAINT FK_TDF_APP_NATION_COUREUR FOREIGN KEY (N_COUREUR)
	  REFERENCES TDF_COUREUR(N_COUREUR);	  
ALTER TABLE TDF_app_nation ADD CONSTRAINT FK_TDF_APP_NATION_NATION FOREIGN KEY (CODE_CIO)
	  REFERENCES TDF_NATION (CODE_CIO);	  


    
    
ALTER TABLE tdf_etape ADD CONSTRAINT FK_tdf_etape_nation_D FOREIGN KEY (code_cio_D)
	  REFERENCES TDF_nation (code_cio);
ALTER TABLE tdf_etape ADD CONSTRAINT FK_tdf_etape_nation_A FOREIGN KEY (code_cio_A)
	  REFERENCES TDF_nation (code_cio);
ALTER TABLE tdf_etape ADD CONSTRAINT FK_tdf_etape_ANNEE FOREIGN KEY (ANNEE)
	  REFERENCES TDF_ANNEE (ANNEE);
    
    
ALTER TABLE tdf_parti_equipe ADD CONSTRAINT FK_tdf_parti_equipe_annee FOREIGN KEY (ANNEE)
	  REFERENCES TDF_ANNEE (ANNEE);
ALTER TABLE tdf_parti_equipe ADD CONSTRAINT FK_tdf_parti_equipe_PRE FOREIGN KEY (N_PRE_DIRECTEUR)
	  REFERENCES TDF_DIRECTEUR (N_DIRECTEUR);
ALTER TABLE tdf_parti_equipe ADD CONSTRAINT FK_tdf_parti_equipe_CO FOREIGN KEY (N_CO_DIRECTEUR)
	  REFERENCES TDF_DIRECTEUR (N_DIRECTEUR);
ALTER TABLE tdf_parti_equipe ADD CONSTRAINT FK_tdf_parti_equipe_sponsor FOREIGN KEY (N_EQUIPE, N_SPONSOR)
	  REFERENCES TDF_SPONSOR (N_EQUIPE, N_SPONSOR);
    
    
ALTER TABLE TDF_ORDREQUI ADD CONSTRAINT FK_TDF_ORDREQUI_ANNEE FOREIGN KEY (ANNEE)
	  REFERENCES TDF_ANNEE (ANNEE);
ALTER TABLE TDF_ORDREQUI ADD CONSTRAINT FK_TDF_ORDREQUI_SPONDOR FOREIGN KEY (N_EQUIPE, N_SPONSOR)
	  REFERENCES TDF_SPONSOR (N_EQUIPE, N_SPONSOR);
ALTER TABLE tdf_parti_coureur ADD CONSTRAINT FK_tdf_parti_coureur_annee FOREIGN KEY (ANNEE)
	  REFERENCES TDF_ANNEE (ANNEE);
ALTER TABLE tdf_parti_coureur ADD CONSTRAINT FK_tdf_parti_coureur_sponsor FOREIGN KEY (N_EQUIPE, N_SPONSOR)
	  REFERENCES TDF_SPONSOR (N_EQUIPE, N_SPONSOR);
ALTER TABLE tdf_parti_coureur ADD CONSTRAINT FK_tdf_parti_coureur_coureur FOREIGN KEY (N_COUREUR)
	  REFERENCES TDF_COUREUR (N_COUREUR);
    
ALTER TABLE TDF_SPONSOR ADD CONSTRAINT FK_TDF_SPONSOR_nation FOREIGN KEY (code_cio)
	  REFERENCES TDF_nation (code_cio);
ALTER TABLE TDF_SPONSOR ADD CONSTRAINT FK_TDF_SPONSOR_EQUIPE FOREIGN KEY (N_EQUIPE)
	  REFERENCES TDF_EQUIPE (N_EQUIPE);
ALTER TABLE TDF_EQU_SUCCEDE ADD CONSTRAINT FK_TDF_EQU_SUCCEDE_EQUIPE FOREIGN KEY (N_EQUIPE)
	  REFERENCES TDF_EQUIPE (N_EQUIPE) ENABLE;
ALTER TABLE TDF_EQU_SUCCEDE ADD CONSTRAINT FK_TDF_EQU_SUCCEDE_EQUIPE_SUC FOREIGN KEY (N_EQ_SUCCESSEUR)
	  REFERENCES TDF_EQUIPE (N_EQUIPE) ENABLE;
ALTER TABLE TDF_TEMPS ADD CONSTRAINT FK_TDF_TEMPS_EPREUVE FOREIGN KEY (ANNEE, n_etape, N_COMP)
	  REFERENCES tdf_etape (ANNEE, n_etape, N_COMP);
    
ALTER TABLE TDF_TEMPS ADD CONSTRAINT FK_TDF_TEMPS_COUREUR FOREIGN KEY (N_COUREUR)
	  REFERENCES TDF_COUREUR (N_COUREUR);
ALTER TABLE TDF_TEMPS ADD CONSTRAINT FK_TDF_TEMPS_ANNEE FOREIGN KEY (ANNEE)
	  REFERENCES TDF_ANNEE (ANNEE);
ALTER TABLE TDF_TEMPS_DIFFERENCE ADD CONSTRAINT FK_TDF_TEMPS_DIFFERENCE_ANNEE FOREIGN KEY (ANNEE)
	  REFERENCES TDF_ANNEE (ANNEE) ENABLE;
ALTER TABLE TDF_TEMPS_DIFFERENCE ADD CONSTRAINT FK_TDF_TEMPS_DIFFERENCE_COUR FOREIGN KEY (N_COUREUR)
	  REFERENCES TDF_COUREUR (N_COUREUR) ENABLE;
ALTER TABLE TDF_nat_succede ADD CONSTRAINT FK_TDF_nat_succede_nat FOREIGN KEY (code_cio)
	  REFERENCES TDF_nation (code_cio) ENABLE;	  
ALTER TABLE TDF_nat_succede ADD CONSTRAINT FK_TDF_nat_succede_nat_suc FOREIGN KEY (nat_successeur)
	  REFERENCES TDF_nation (code_cio) ENABLE;	 
    
-- autres contraintes
ALTER TABLE TDF_ABANDON ADD CONSTRAINT aba_c_typeaban_not_null check (c_typeaban is not null);
ALTER TABLE TDF_ANNEE ADD CONSTRAINT ann_jour_repos_not_null check (jour_repos is not null);
ALTER TABLE TDF_COUREUR ADD CONSTRAINT cou_nom_not_null check (nom is not null);
ALTER TABLE TDF_COUREUR ADD CONSTRAINT cou_prenom_not_null check (prenom is not null);
ALTER TABLE TDF_COUREUR add constraint u_tdf_coureur unique (nom, prenom);
ALTER TABLE TDF_DIRECTEUR ADD CONSTRAINT dir_nom_not_null check (nom is not null);
ALTER TABLE TDF_DIRECTEUR ADD CONSTRAINT dir_prenom_not_null check (prenom is not null);
ALTER TABLE TDF_DIRECTEUR add constraint u_tdf_directeur unique (nom, prenom);
ALTER TABLE TDF_EQU_SUCCEDE add constraint SUC_SUCCESSEUR_NOT_NULL check (n_eq_successeur is not null);

ALTER TABLE tdf_etape ADD CONSTRAINT epr_code_cio_d_not_null check (code_cio_d is not null);
ALTER TABLE tdf_etape ADD CONSTRAINT epr_code_cio_a_not_null check (code_cio_a is not null);
ALTER TABLE tdf_etape ADD CONSTRAINT epr_ville_d_not_null check (ville_d is not null);
ALTER TABLE tdf_etape ADD CONSTRAINT epr_ville_a_not_null check (ville_a is not null);
ALTER TABLE tdf_etape ADD CONSTRAINT epr_jour_not_null check (datetape is not null);
ALTER TABLE tdf_etape ADD CONSTRAINT epr_cat_code_not_null check (cat_code is not null);
alter table tdf_etape add constraint epr_cat_code check (cat_code in ('ETA','PRO','CMI','CME','PRE'));

alter table TDF_nation add constraint pay_nom_not_null check (nom is not null);

alter table tdf_parti_equipe add constraint pae_pre_directeur_not_null check (n_pre_directeur is not null);
alter table tdf_parti_equipe add constraint pae_directeurs_differents check (n_pre_directeur <> n_co_directeur );
alter table tdf_parti_coureur add constraint pac_n_dossard_not_null check (n_dossard is not null);

alter table TDF_SPONSOR add constraint spo_code_cio_not_null check (code_cio is not null);
alter table TDF_SPONSOR add constraint spo_nom_not_null check (nom is not null);

alter table TDF_TEMPS add constraint tem_heure_not_null check (heure is not null);
alter table TDF_TEMPS add constraint tem_minute_not_null check (minute is not null);
alter table TDF_TEMPS add constraint tem_seconde_not_null check (seconde is not null);
alter table TDF_TEMPS add constraint tem_total_seconde_not_null check (total_seconde is not null);
alter table TDF_TEMPS add constraint tem_rang_arrivee_not_null check (rang_arrivee is not null);

alter table TDF_TEMPS_DIFFERENCE add constraint ted_difference_not_null check (difference is not null);

alter table TDF_TYPEABAN add constraint ted_libelle_not_null check (libelle is not null);

alter table TDF_USER add constraint use_auth_key_not_null check (AUTH_KEY IS NOT NULL);
alter table TDF_USER add constraint email_not_null check (email IS NOT NULL);
alter table TDF_USER add constraint use_mot_de_passe_not_null check (MOT_DE_PASSE IS NOT NULL);
alter table TDF_USER add constraint use_pseudo_not_null  check (PSEUDO IS NOT NULL);
alter table TDF_USER add constraint use_n_user_not_null  check (n_user IS NOT NULL);

alter table TDF_USER add constraint TDF_USER_PSEUDO_UK  unique(PSEUDO);
alter table TDF_USER add constraint TDF_USER_EMAIL_UK  unique (EMAIL);

