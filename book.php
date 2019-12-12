<?php
	require "dbConnection.php";
	
	$db = getDBConnection();
	//Testing Process
	
	
	if(isset($_POST["bookOP"])){
		switch($_POST["bookOP"]){
			case "getSomeBooks":
				echo getSomeBooks($_POST["bookQuant"], $db);
				break;
			case "searchBook":
				echo searchBooks($db);
				break;
		}
	}
	
	function bDataToJson($qResult){
		if($qResult->num_rows == 0) return "";
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
		$jsonResult[1] = " ";
		$jsonResult .= "]";
		return $jsonResult;
	}
	
	function getSomeBooks($quantity, $db){
		$request = "SELECT B.title, B.autName, B.price, B.ISBN  FROM Book B " .
						"WHERE B.stock > 0 LIMIT $quantity";
		if($qResult = $db->query($request)){
 //Deleting extra comma at the begining of array of objects
			return bDataToJson($qResult);
		}
	}
	

	function appendQuery($field, &$where){
		if(strlen($_POST[$field]) > 0){
			if(strlen($where) > 0 ){
				$where .= " and ";
			}
			$where .= "$field='" . $_POST[$field] . "'";
		}
	}
	
	function searchBooks($db){
		$where = "";
		$query = "";
		appendQuery("title", $where);
		appendQuery("autName", $where);
		appendQuery("publisher", $where);
		if(strlen($where) > 0){
			$where .= " and ";
		}
		$query = "SELECT title, autName, price, ISBN FROM Book WHERE $where  stock > 0;";
		if($result = $db->query($query)){
			return bDataToJson($result);
		}

	}

?>