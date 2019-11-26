<?php
	require "dbConnection.php";
	
	$db = getDBConnection();
	//Testing Process
		$_POST["bookOP"] = "getSomeBooks";
		$_POST["bookQuant"] = 10;
	
	
	if(isset($_POST["bookOP"])){
		switch($_POST["bookOP"]){
			case "getSomeBooks":
				echo getSomeBooks($_POST["bookQuant"], $db);
		}
	}

	function getSomeBooks($quantity, $db){
		$request = "SELECT B.title, B.autName, B.price, B.ISBN  FROM Book B " .
						"WHERE B.stock > 0 LIMIT $quantity";
		if($qResult = $db->query($request)){
			$jsonResult = "[";
			for($i = 0; $i < $qResult->num_rows; $i++){
					$book = $qResult->fetch_assoc();		
					$jsonResult .= ",{".
										'"autName" : "' . $book["autName"] .'", '.
										'"title" : "' . $book["title"] . '", '.
										'"price" : ' . $book["price"] . ", ".
										'"ISBN" : "' . $book["ISBN"] . '"'.
									"}";
			}
			$jsonResult[1] = " "; //Deleting extra comma at the begining of array of objects
			$jsonResult .= "]";
			return $jsonResult;
		}
	}

?>