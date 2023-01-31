<?php 
    if(!isset($_POST)){
        echo "failed";
    }

    include_once("dbconnect.php");
    $name          = $_POST['name'];
    $desc           = $_POST['desc'];
    $price       	= $_POST['price'];
    $guest       = $_POST['guest'];
    $address        = $_POST['address'];
	$state        = $_POST['state'];
	$local        = $_POST['local'];
	$image        = $_POST['image'];
	
    $sql    = "INSERT INTO `tbl_homestay`(`homestay_name`, `homestay_desc`, `homestay_price`, `homestay_guest`, `homestay_address`, `homestay_state`, `homestay_local`) 
						VALUES ('$name','$desc','$price','$guest','$address','$state','$local')";
    
    if ($conn->query($sql)) {
		$decoded_string = base64_decode($image);
		$filename = mysqli_insert_id($conn);
		$path = '../assets/productimages/'.$filename.'.png';
		file_put_contents($path, $decoded_string);
			
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