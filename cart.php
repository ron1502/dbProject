<?php
	require "dbConnection.php";
	
	$db = getDBConnection();
	if(isset($_POST["cartOp"])){
		switch($_POST["cartOp"]){
			case "GET":
				echo getUserCarts($db);
				break;
		}	
	}
	
	function getUserCarts($db){
		$query = "SELECT * FROM ShoppingCartManage WHERE accID=" . $_POST["accID"] .";";
		if($result = $db->query($query)){
			if($result->num_rows == 0) return "";
			$jsonResult = "[";
			for($i = 0; $i < $result->num_rows; $i++){
					$book = $result->fetch_assoc();		
					$jsonResult .= ",{".
										'"cName" : "' . $book["cName"] .'", '.
										'"cartID" : "' . $book["cartID"] . '"'.
									"}";
			}
			$jsonResult[1] = " ";
			$jsonResult .= "]";	
			return $jsonResult;
		}
		
	}
?>