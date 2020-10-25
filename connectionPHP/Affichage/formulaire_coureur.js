	

	function testerValid()	  
	{
		if (Formulaire_coureur.nouvNom.value == "" || Formulaire_coureur.nouvPrenom.value == "")
		  return false;
		else
		  return true;
	}
	
	
	function testerValidModif()	  
	{
		if (Formulaire_coureur.changNomA.value == "" || Formulaire_coureur.changNomN.value == "")
		  return false;
		else
		  return true;
	}
	

	function testerValidSup()	  
	{
		if ((Formulaire_coureur.suppNom.value == "" || Formulaire_coureur.suppPrenom.value == "") && Formulaire_coureur.numC.value == "")
		  return false;
		else
		  return true;
	}
	
	
	
