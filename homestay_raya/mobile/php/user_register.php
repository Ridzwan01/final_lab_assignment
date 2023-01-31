<?php 
    if(!isset($_POST)){
        echo "failed";
    }

    include_once("dbconnect.php");
    $email          = $_POST['email'];
    $name           = $_POST['name'];
    $phone       	= $_POST['phone'];
    $password       = sha1($_POST['password']);
    $address        = $_POST['address'];
    $sqlregister    = "INSERT INTO `tbl_user`(`user_email`, `user_name`, `user_phnumber`, `user_pass`, `user_address`) 
                       VALUES ('$email','$name','$phone','$password','$address')";
    
    if ($conn->query($sqlregister)) {
      $response = array('status' => 'success', 'data' => null);
	  sendJsonResponse($response);
    }else{
      $response = array('status' => 'failed', 'data' => null);
	  sendJsonResponse($response);
    }

    function sendJsonResponse($sentArray){
        header('Content-Type: application/json');
        echo json_encode($sentArray);
    }
?>