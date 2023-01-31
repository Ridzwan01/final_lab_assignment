<?php 
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "homestay_raya";


	$conn = new mysqli($servername, $username, $password, $dbname);
	if ($conn->connect_error) {
		die("connection failed: " . $conn->connect_error);
	}
?>