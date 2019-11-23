<?php
	$connData = Array();
	parse_str(str_replace(";", "&", getenv("MYSQLCONNSTR_localdb")), $connData);
	print_r($connData);
	


	// Create connection
	$conn = new mysqli($connData["Data_Source"], $connData["User_Id"], $connData["Password"]);

	// Check connection
	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}
	echo "Connected successfully";
?>