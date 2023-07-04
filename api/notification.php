<?php
include 'connection.php';
$sql = mysqli_query($con, "SELECT * FROM notification");
$list= array();
if ($sql->num_rows>0){
    while ($row = mysqli_fetch_assoc($sql)){
        $myarray['message'] = 'message';
        $myarray['date'] =$row['date'];
        $myarray['time'] =$row['time'];
        $myarray['message'] =$row['message'];
        
        array_push($list,$myarray);
    }
}
else{
    $myarray['message']= 'failed';
}
echo json_encode($list);