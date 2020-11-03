<?php
session_start();

include_once '../classesPHP/classe_infos.php';
include_once '../generique/chaine.php';
include_once '../generique/fonc_oracle.php';
include_once '../generique/util_chap11.php';

$infos=new Infos();

include_once '../Affichage/infosGenerales.htm';