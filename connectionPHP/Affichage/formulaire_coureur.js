	

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
	
	function FormValidation(){
		//First Name Validation 
			var fn=document.getElementById('nouvNom').value;
			if(fn == ""){
				alert('Veuillez entrer un nom');
				document.getElementById('nouvNom').style.borderColor = "red";
				return false;
			}else{
				document.getElementById('nouvNom').style.borderColor = "green";
			}
			if (document.getElementById("nouvPrenom").value =="") {
				alert("Veuillez entrer un prénom");
				document.getElementById('nouvPrenom').style.borderColor = "red";
				return false;
			}else{
				document.getElementById('nouvPrenom').style.borderColor = "green";
			}
			document.getElementById('nouvNom').style.borderColor = "red";
				return false;
		}
