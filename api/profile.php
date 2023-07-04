<?php
include 'connection.php';
$id=$_POST['id'];
$sql = mysqli_query($con, "SELECT * FROM register where reg_id='$id'");
$list= array();
if ($sql->num_rows>0){
    while ($row = mysqli_fetch_assoc($sql)){
        $myarray['message'] = 'message';
        $myarray['first_name'] =$row['first_name'];
        $myarray['street_address'] =$row['street_address'];
        $myarray['city'] =$row['city'];
        $myarray['state'] =$row['state'];
        $myarray['Phone_number'] =$row['Phone_number'];
        $myarray['Email'] =$row['Email'];
        
        array_push($list,$myarray);
    }
}
else{
    $myarray['message']= 'failed';
}
echo json_encode($list);