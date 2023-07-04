<?php
include 'connection.php';
$id = $_GET['id'];
mysqli_query($con,"update add_rental_vehicles set status='1' where rental_id ='$id'");
header("location:approve rental.php");
?>