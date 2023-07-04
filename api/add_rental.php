<?php
include 'connection.php';
$name=$_POST['name'];
$price=$_POST['price'];
$vehicle=$_POST['vehicle_type'];
$gear=$_POST['type_of_gear'];
$color=$_POST['color_of_vehicle'];
$seat=$_POST['seats_of_vehicle'];
$fuel=$_POST['fuel_of_vehicle'];
$location=$_POST['location'];


 $rc=$_FILES['rc']['name'];

    if(!empty($rc)){
        $filearray=pathinfo($_FILES['rc']['name']);

        $file1=rand();
        $file_ext=$filearray['extension'];


        $filenew = $file1 . "." .$file_ext;
        $moved =  move_uploaded_file($_FILES['rc']['tmp_name'], "./image/" . $filenew);
       
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
 //echo "<script>alert('try again');</script>";
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

//
    $filenew3= $file4 . "." .$file_ext3;
    move_uploaded_file($_FILES['pic']['tmp_name'], "image/" . $filenew3);
    // $response =  ' uploaded';
}
else
{
////echo "<script>alert('try again');</script>";
}
$sql = mysqli_query($con, "INSERT INTO add_rental_vehicles(name,price,vehicle_type,type_of_gear,color_of_vehicle,seats_of_vehicle,fuel_of_vehicle,location,RC,insurance,driving_licence,upload_photo)VALUES('$name','$price','$vehicle','$gear','$color','$seat','$fuel','$location','$filenew','$filenew1','$filenew2','$filenew3')");

if ($sql)
{
   
    $myarray['message'] = 'successfully added';
    // $myarray['res'] = $response;

} else {
    $myarray['message'] = 'failed';
    // $myarray['res'] = $response;
}
echo json_encode($myarray);
?>