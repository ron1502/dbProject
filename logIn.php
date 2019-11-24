<?php
	$connData = Array();
	parse_str(str_replace(";", "&", getenv("MYSQLCONNSTR_localdb")), $connData);
	print_r($connData);
	
	// Create connection
	$db = new mysqli($connData["Data_Source"], $connData["User_Id"], $connData["Password"]);
	
	if ($db->connect_error) {
		die("Connection failed: " . $db->connect_error);
	}
	
	$db->select_db('localdb');
	
	if(isset($_POST["funct"])){
		switch($_POST["funct"]){
			case "logIn":
				echo "Login user";
				echo logInUser();
				break;
			case "signIn":
				echo "SignIn user";
				echo signInUser();
				break;
		}
	}
	
	
	function logInUser(){
		$id = null;
		$logInQuery = "logIn(". $_POST["email"] . "," . $_POST["passworrd"]. ");";
		$logInQuery .= "SELECT @accID AS accountID";
	
		$db->multi_query($logInQuery);
		echo "Selecting from database";
		$id = $db->store_result()->fetch_object()->accountID;
		return $id;
	}
	
	function signInUser(){
		$id = null;
		return $id;
	}
	
?>