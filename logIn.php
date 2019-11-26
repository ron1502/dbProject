<?php
	$db = getTestDBConnection();
	/*
	$_POST["email"] = "richard@gmail.com";
	$_POST["password"] = "dfas452";
	$_POST["funct"] = "logIn";
	*/
	if(isset($_POST["funct"])){
		switch($_POST["funct"]){
			case "logIn":
				echo logInUser($db);
				break;
			case "signIn":
				echo signInUser($db);
				break;
		}
	}
	$db->close();
	
	function logInUser($db){
		$logInQuery = "CALL logIn('". $_POST["email"] . "','" . $_POST["password"] ."', @accID);";
		$logInQuery .= "SELECT @accID AS accountID;";
		if($db->multi_query($logInQuery )){
			$db->next_result(); //Obtaining result from CALL
			$accID = $db->store_result()->fetch_object()->accountID;
			if($accID == null) return -1;
			else{
				return $accID;
			}
		} else{
			echo "We ran into problems\n";
			return -1;
		}
	}
	
	function signInUser($db){
		$id = null;
		return $id;
	}
	
	function getDBConnection(){
		$connData = Array();
		parse_str(str_replace(";", "&", getenv("MYSQLCONNSTR_localdb")), $connData);

		$db = new mysqli($connData["Data_Source"], $connData["User_Id"], $connData["Password"], "localdb");

		if($db->connect_error) {
			die("Connection failed: " . $db->connect_error);
		}
		return $db;
	}
	
	
	function getTestDBConnection(){
		$db = new mysqli("localhost", "root", "", "localdb");
		if($db->connect_error) {
			die("Connection failed: " . $db->connect_error);
		}
		return $db;
	}
	
?>