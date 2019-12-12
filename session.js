		

checkSession();


function checkSession(){
	var accID = window.localStorage.getItem("accountID");
	if(accID != null){
		document.getElementById("loggedInMenu").style.display = "block";
		document.getElementById("logInProc").style.display = "none";
	}else{
		document.getElementById("loggedInMenu").style.display = "none";
		document.getElementById("logInProc").style.display = "block";
	}
}

function logOut(){
	window.localStorage.removeItem("accountID");
	checkSession();
}
		