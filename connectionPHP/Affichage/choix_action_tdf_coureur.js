// ajax pour envoyer des données à la page php
//table coureurs
function chargerDonneeCoureur(nom, prenom, annee_nai, annee_pre, numC, pays) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '../AffichagePHP/affichageCoureurs.php/?nom=' +nom + '&table=coureur'+
    '&prenom=' + prenom + '&annee_nai=' +annee_nai + '&annee_pre=' + annee_pre + '&numC=' + numC + '&nation='+ pays);

    var Lire = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById('resultat').innerHTML = '<span>' + xhr.responseText + '</span>';
        }
    }
    xhr.addEventListener("readystatechange", Lire, false);
    xhr.send(null);
}
//table equipes
function chargerDonneeEquipe(numE, nomE, annee_crea_eq, annee_disp_eq) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '../AffichagePHP/affichageCoureurs.php/?numE=' +
        numE + '&nomE=' + nomE + '&annee_crea_eq=' +annee_crea_eq + '&annee_disp_eq=' + annee_disp_eq + '&table=equipe');

    var Lire = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById('resultat').innerHTML = '<span>' + xhr.responseText + '</span>';
        }
    }
    xhr.addEventListener("readystatechange", Lire, false);
    xhr.send(null);
}
//table etapes
function chargerDonneeEtape(n_etape, nomEt,  pays, annee, dist, cat) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '../AffichagePHP/affichageCoureurs.php/?n_etape=' +
        n_etape + '&nomEt=' + nomEt + '&pays=' +pays + '&annee=' + annee + '&dist=' + dist +  '&cat=' + cat +  '&table=etape');

    var Lire = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById('resultat').innerHTML = '<span>' + xhr.responseText + '</span>';
        }
    }
    xhr.addEventListener("readystatechange", Lire, false);
    xhr.send(null);
}
//table sponsors
function chargerDonneeSponsor(numS, numE2, anneeS) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '../AffichagePHP/affichageCoureurs.php/?numS=' +
        numS + '&numE2=' + numE2 + '&anneeS=' +anneeS + '&table=sponsor');

    var Lire = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById('resultat').innerHTML = '<span>' + xhr.responseText + '</span>';
        }
    }
    xhr.addEventListener("readystatechange", Lire, false);
    xhr.send(null);
}

//le choix de la table
var table = document.getElementById('table');

//élements de coureur
var nom = document.getElementById('NOM');
var prenom = document.getElementById('PRENOM');
var annee_nai = document.getElementById('ANNEE_NAISSANCE');
var annee_pre = document.getElementById('ANNEE_PREM');
var numC = document.getElementById('NUMERO');
var pays = document.getElementById('pays');

// élements de étape
var n_etape = document.getElementById('n_etape');
var nomEt = document.getElementById('nom_etape');
var pays2 = document.getElementById('pays2');
var annee_eta = document.getElementById('annee_etape');
var distance = document.getElementById('dist_etape');
var cat = document.getElementById('catET');

//élements de équipe
var numE = document.getElementById('n_equipe');
var nomE = document.getElementById('nom_equipe');
var annee_crea_eq = document.getElementById('annee_crea_eq');
var annee_disp_eq = document.getElementById('annee_disp_eq');

//élements de sponsor
var numE2 = document.getElementById('n_equipe2');
var numS = document.getElementById('n_sponsor');
var anneeS = document.getElementById('annee_sponsor');


var maFonction1 = function () {
    chargerDonneeCoureur(nom.value, prenom.value,annee_nai.value,annee_pre.value, numC.value,pays.value);
};
var chargeEquipe = function () {
    chargerDonneeEquipe(numE.value,nomE.value,annee_crea_eq.value,annee_disp_eq.value);
};
var chargeEtape = function () {
    chargerDonneeEtape(n_etape.value, nomEt.value,  pays2.value, annee_eta.value, distance.value, cat.value);
};
var chargeSponsor = function () {
    chargerDonneeSponsor(numS.value,numE2.value,anneeS.value);
};

//affichage des formulaires
function displayHS() {
    document.getElementById('Formulaire_coureur').style.display = 'none'; //cache l'élement
    document.getElementById('Formulaire_equipe').style.display = 'none'; 
    document.getElementById('Formulaire_etape').style.display = 'none'; 
    document.getElementById('Formulaire_sponsor').style.display = 'none'; 
    document.getElementById('coureurIMG').style.display = 'none'; 
    document.getElementById('etapeIMG').style.display = 'none'; 
    document.getElementById('equipeIMG').style.display = 'none'; 
    document.getElementById('sponsorIMG').style.display = 'none'; 
    if(table.value == "Coureur") {
    document.getElementById('Formulaire_coureur').style.display = 'block';  //affiche l'élement
    document.getElementById('coureurIMG').style.display = 'block'; 
    }
    else if (table.value == "Equipe"){
        document.getElementById('Formulaire_equipe').style.display = 'block'; 
        document.getElementById('equipeIMG').style.display = 'block'; 
    }
    else if (table.value == "Etape") {
        document.getElementById('etapeIMG').style.display = 'block'; 
        document.getElementById('Formulaire_etape').style.display = 'block'; 
    }
    else if (table.value == "Sponsor") {
        document.getElementById('sponsorIMG').style.display = 'block'; 
        document.getElementById('Formulaire_sponsor').style.display = 'block'; 
    }
}

//évènements et actions
//choix de la table
table.addEventListener("change",displayHS,false);
//formulaire coureur
nom.addEventListener("keyup", maFonction1, false);
numC.addEventListener("keyup", maFonction1, false);
prenom.addEventListener("keyup", maFonction1, false);
annee_nai.addEventListener("keyup", maFonction1, false);
annee_pre.addEventListener("keyup", maFonction1, false);
pays.addEventListener("change", maFonction1, false);
//formulaire equipe
numE.addEventListener("keyup", chargeEquipe, false);
nomE.addEventListener("keyup", chargeEquipe, false);
annee_crea_eq.addEventListener("keyup", chargeEquipe, false);
annee_disp_eq.addEventListener("keyup", chargeEquipe, false);
// formulaire etapes
n_etape.addEventListener("keyup", chargeEtape, false);
nomEt.addEventListener("keyup", chargeEtape, false);
pays2.addEventListener("change", chargeEtape, false);
annee_eta.addEventListener("keyup", chargeEtape, false);
distance.addEventListener("keyup", chargeEtape, false);
cat.addEventListener("keyup", chargeEtape, false);
// formulaire sponsor
numE2.addEventListener("keyup", chargeSponsor, false);
numS.addEventListener("keyup", chargeSponsor, false);
anneeS.addEventListener("keyup", chargeSponsor, false);
//affichage
displayHS();