<?php
include 'connection.php';
$type  = $_POST['type'];
$first  = $_POST['first_name'];
$last  = $_POST['Last_name'];
$street  = $_POST['street_address'];
$city = $_POST['city'];
$Pin = $_POST['pin'];
$state= $_POST['state'];
$Phone = $_POST['Phone_number'];
$Email = $_POST['Email'];
$Password = $_POST['Password'];
mysqli_query($con,"insert into login(Email,Password,type)values('$Email','$Password','$type')");

 $log = mysqli_insert_id($con);
 
$sql = mysqli_query($con, "INSERT INTO register(login_id,first_name, Last_Name,street_address,city,pin,state,Phone_number,Email,Password)VALUES('$log','$first','$last','$street','$city','$Pin','$state','$Phone','$Email','$Password')");

if ($sql)
{

    $myarray['message'] = 'added';

} else {
    $myarray['message'] = 'failed';
}
echo json_encode($myarray);
?>