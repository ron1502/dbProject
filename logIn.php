<?php
$connectionString =  getenv("MYSQLCONNSTR_localdb");

	echo $connectionString;
	
	echo "Connected successfully";
	$email = $_POST["email"];
	echo "We got the name:" . $email;
	$conn->close();
?>