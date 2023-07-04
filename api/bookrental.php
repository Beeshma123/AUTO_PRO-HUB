<?php
include 'connection.php';

$name=$_POST['name'];
$phone_no=$_POST['phone_no'];
$address=$_POST['address'];

$date=$_POST['date'];
$last_date=$_POST['last_date'];
$select_proof=$_POST['select_proof'];
$payment=$_POST['payment'];
$filenew3 = '';
$vehicleid=$_POST['id'];
$pic=$_FILES['pic']['name'];

if($pic !=""){
    $filearray3=pathinfo($_FILES['pic']['name']);

    $file4=rand();
    $file_ext3=$filearray3['extension'];

//
    $filenew3= $file4 . "." .$file_ext3;
    move_uploaded_file($_FILES['pic']['tmp_name'], "image/" . $filenew3);
    // $response =  ' uploaded';
}
$sql = "INSERT INTO `rental_booking`( `name`, `phone_no`, `address`, `date`, `last_date`,  `select_proof`, `file`, `veh_id`) VALUES ('$name','$phone_no','$address','$date]','$last_date','$select_proof','$filenew3','$vehicleid')";

$sql = mysqli_query($con, $sql);

if ($sql)
{
   
    $myarray['message'] = 'successfully added';

} else {
    $myarray['message'] = 'failed';
}
echo json_encode($myarray);
?>