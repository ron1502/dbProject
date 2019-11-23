<?php
	$connData = Array();
	parse_str(str_replace(";", "&", getenv("MYSQLCONNSTR_localdb")), $connData);
	print_r($connData);
?>