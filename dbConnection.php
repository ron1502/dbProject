<?php

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