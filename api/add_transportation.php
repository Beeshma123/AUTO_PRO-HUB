<?php
include 'connection.php';

$vehicle=$_POST['vehicle'];
$seat=$_POST['seat'];
$seat=$_POST['price'];
$location=$_POST['location'];
$rc=$_FILES['rc']['name'];

    if($rc !=""){
        $filearray=pathinfo($_FILES['rc']['name']);

        $file1=rand();
        $file_ext=$filearray['extension'];


        $filenew = $file1 . "." .$file_ext;
        move_uploaded_file($_FILES['rc']['tmp_name'], "image/" . $filenew);
        // $response =  ' uploaded';
    }
 else
 {
   // echo "<script>alert('try again');</script>";
 }
 $insurance=$_FILES['insurance']['name'];
 if($insurance !=""){
     $filearray1=pathinfo($_FILES['insurance']['name']);

     $file2=rand();
     $file_ext1=$filearray1['extension'];


     $filenew1 = $file2 . "." .$file_ext1;
     move_uploaded_file($_FILES['insurance']['tmp_name'], "image/" . $filenew1);
     // $response =  ' uploaded';
 }
else
{
//// echo "<script>alert('try again');</script>";
}



$licence=$_FILES['licence']['name'];
if($licence !=""){
    $filearray2=pathinfo($_FILES['licence']['name']);

    $file3=rand();
    $file_ext2=$filearray2['extension'];


    $filenew2 = $file3 . "." .$file_ext2;
    move_uploaded_file($_FILES['licence']['tmp_name'], "image/" . $filenew2);
    // $response =  ' uploaded';
}
else
{
//echo "<script>alert('try again');</script>";
}
$pic=$_FILES['pic']['name'];
if($pic !=""){
    $filearray3=pathinfo($_FILES['pic']['name']);

    $file4=rand();
    $file_ext3=$filearray3['extension'];


    $filenew3= $file4 . "." .$file_ext3;
    move_uploaded_file($_FILES['pic']['tmp_name'], "image/" . $filenew3);
    // $response =  ' uploaded';
}
else
{
//echo "<script>alert('try again');</script>";
}
$sql = "INSERT INTO `add_transportation_vehicle`( `vehicle`, `price`, `seats`, `location`, `RC`, `insurance`, `dl`, `upload_photo`) VALUES ('$vehicle','$price','$seat','$location','$filenew','$filenew1','$filenew2','$filenew3')";


$sql = mysqli_query($con, $sql) ;

if ($sql)
{
   
    $myarray['message'] = 'added';

} else {
    $myarray['message'] = 'failed';
}
echo json_encode($myarray);
?>