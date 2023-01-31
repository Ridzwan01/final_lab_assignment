<?php 

	if (!isset($_POST)) {
		$response = array('status'=>'failed', 'data'=>null);
		sendJsonResponse($response);
		die();
	}

	include_once("dbconnect.php");

	$result_per_page = 5;
	$pageno = (int)$_POST['pageno'];
	$search = $_POST['search'];

	$page_first_result = ($pageno - 1) * $result_per_page;

	$sql = "SELECT * FROM `tbl_homestay`";
	
	$result = $conn->query($sql);
	$number_of_result = $result->num_rows;
	$number_of_page = ceil($number_of_result / $result_per_page);
	$sql = $sql . " LIMIT $page_first_result , $result_per_page";
	$result = $conn->query($sql);

	if($result->num_rows > 0){
		$product["product"] = array();
		while ($row = $result->fetch_assoc())
		{
			$productlist = array();
			$productlist['id'] = $row['homestay_id'];
			$productlist['name'] = $row['homestay_name'];
			$productlist['desc'] = $row['homestay_desc'];
			$productlist['price'] = $row['homestay_price'];
			$productlist['guest'] = $row['homestay_guest'];
			$productlist['address'] = $row['homestay_address'];
			$productlist['state'] = $row['homestay_state'];
			$productlist['local'] = $row['homestay_local'];		
			array_push($product['product'], $productlist);
		}
			$response = array('status'=>'success', 'data'=>$product);
		sendjsonResponse($response);
	}else{
		$response = array('status'=>'failed', 'data'=>null);
		sendjsonResponse($response);
	}

	function sendjsonResponse($sendArray) 
	{
		header('Content-Type: application/json');
		echo json_encode($sendArray);    
	}

?>