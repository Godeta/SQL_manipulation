	

	function testerValid()	  
	{
		if (Formulaire_coureur.nom.value == "" || Formulaire_coureur.prenom.value == "")
		  return false;
		else
		  return true;
	}
	
	
	function testerValidModif()	  
	{
		if (Formulaire_coureur.numCoureurM.value == "")
		  return false;
		else
		  return true;
	}
	
	
	function testerValidSup()	  
	{
		if (Formulaire_coureur.numCoureurS.value == "")
		  return false;
		else
		  return true;
	}
	
