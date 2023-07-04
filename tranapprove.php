<?php
include 'connection.php';
$id = $_GET['id'];
mysqli_query($con,"update add_transportation_vehicle set status='1' where transportation_id ='$id'");
header("location:approve transportation.php");
?>