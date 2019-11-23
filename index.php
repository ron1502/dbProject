<?php

	$name = $_POST["name"];
	echo "We got the name:" + $name;

?>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Modern Business - Start Bootstrap Template</title>
  
  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/modern-business.css" rel="stylesheet">
	
	<script type="text/javascript">
		function logIn(){
			var emailFiled = document.getElementById("email");
			var passwordField = document.getElementById("password");
			// Check for correct fiels
			var userData = "email=" + emailFiled.value + "&password=" + passwordField.value;
			
			var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
				 document.getElementById("demo").innerHTML = this.responseText;
				 window.alert(this.responseText);
				}
			  };
			  xhttp.open("POST", "index.php", true);
			  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  xhttp.send(userData);
		}
	</script>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-4 col-sm-2">
			</div>
			<div id="logIn">
			<div class="col card mb-4">
			  <h5 class="card-header">User Login</h5>
			  <div class="card-body">
				<div class="row">
				  <div>
					<input type="text" class="mb-4 form-control"  placeholder="Email" id="email">
				  </div>
				  <div>
					<input type="text" class="mb-4 form-control" placeholder="Password" id="password">
				  </div>
				  <div>
					  <span class="input-group-btn" >
						<button  class=" mb-4  btn btn-secondary" type="button" onclick="logIn()">Log in</button>
					  </span>
				 </div>
				</div>
			  </div>
			</div>
			<div class="col-lg-4 col-sm-2">
			</div>
			</div>
		</div>
	</div>


</body>