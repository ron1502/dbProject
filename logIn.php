<?php
	$connData = Array();
	parse_str(str_replace(";", "&", getenv("MYSQLCONNSTR_localdb")), $connData);
	print_r($connData);
	
	// Create connection
	$db = new mysqli($connData["Data_Source"], $connData["User_Id"], $connData["Password"]);
	
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}
	
	if(isset($_POST["funct"])){
		switch($_POST["funct"]){
			case "logIn":
				logInUser();
				break;
			case "signIn":
				signInUser();
				break;
		}
	}
	
	$db->select_db('localdb');
	
	function logInUser($email, $passworrd){
		$id = null;
		$logInQuery = "logIn(". $_POST["email"] . "," . $_POST["passworrd"]. ");";
		$logInQuery .= "SELECT @accID AS accountID";
	
		$db->multi_query($logInQuery);
	
		$id = $db->store_result()->fetch_object()->accountID;
		return $id;
	}
	
	function signInUser(){
		$id = null;
		return $id;
	}
	
?>