<?php
include 'connection.php';

$name=$_POST['name'];
$phone_no=$_POST['phone_no'];
$address=$_POST['address'];
$from=$_POST['from'];
$destination=$_POST['destination'];
$date=$_POST['date'];
$time=$_POST['time'];
$vehicle=$_POST['vehicle'];
$payment=$_POST['payment'];
$sql = mysqli_query($con, "INSERT INTO `transportation_booking`( `name`, `phone_no`, `address`, `from`, `destination`, `date`, `time`, `vehicle`, `payment`) VALUES ('$name','$phone_no','$address','$from','$destination','$date','$time','$vehicle','$payment')");

if ($sql)
{
   
    $myarray['message'] = 'successfully added';

} else {
    $myarray['message'] = 'failed';
}
echo json_encode($myarray);
?>