<?php
	$servername = "localhost";
	$username = "customer";
	$password = "N@r@nj@n4r4nj4";
	$dbName = "localdb";
	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbName);

	// Check connection
	if ($conn->connect_error) {
		$conn->close();
		die("Connection failed: " . $conn->connect_error);
	}
	
	echo "Connected successfully";
	$email = $_POST["email"];
	echo "We got the name:" . $email;
	$conn->close();
?>