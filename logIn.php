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
			case "signUp":
				echo signUpUser($db);
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
			return -2;
		}
	}
	
	function signUpUser($db){
		$signUpQuery = "CALL newUser('". $_POST["email"] ."', '". $_POST["custName"] ."', " .
					   "'" . $_POST["phoneNum"] . "', " . $_POST["zipcode"] . ", '" . $_POST["street"] . "', " .
					   "'". $_POST["city"] ."', '". $_POST["state"] . "', '" . $_POST["password"] . "', @error, @accID);";
		$signUpQuery .= "SELECT @error AS errorMsg, @accID AS accID;";
		if($db->multi_query($signUpQuery)){
			$db->next_result(); //Skiping the call process
			$result = $db->store_result()->fetch_object();
			if($result->errorMsg == "E") return -1;
			else return $result->accID;
		}
		return -2;
	}
	

?>