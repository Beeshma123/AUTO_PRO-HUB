<?php
include 'connection.php';
$sql = mysqli_query($con, "SELECT * FROM payment");
$list= array();
if ($sql->num_rows>0){
    while ($row = mysqli_fetch_assoc($sql)){
        $myarray['name'] = 'name';
        $myarray['amount'] =$row['amount'];
        $myarray['date'] =$row['date'];
        $myarray['time'] =$row['time'];
        $myarray['name'] =$row['name'];
        
        array_push($list,$myarray);
    }
}
else{
    $myarray['message']= 'failed';
}
echo json_encode($list);