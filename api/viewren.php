<?php

include 'connection.php';
 $id=$_POST['id'];
$sql = mysqli_query($con, "SELECT * FROM add_rental_vehicles where vehicle_type ='car'and rental_id ='$id'");
$list= array();
if ($sql->num_rows>0){
    while ($row = mysqli_fetch_assoc($sql)){
        
        $myarray['message']= 'message';
        $myarray['rental_id']=$row['rental_id'];
      
        $myarray['type_of_gear']=$row['type_of_gear'];
        $myarray['color_of_vehicle']=$row['color_of_vehicle'];
        $myarray['seats_of_vehicle']=$row['seats_of_vehicle'];
        $myarray['fuel_of_vehicle']=$row['fuel_of_vehicle'];
       
        array_push($list,$myarray);
    }
}
else{
    $myarray['message']= 'failed';
    array_push($list,$myarray);
}
echo json_encode($list);
?>