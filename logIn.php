<?php
	require "dbConnection.php";
	$db = getDBConnection();
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
	

?>