<?php

include 'connection.php';

$Email = $_POST['email'];
$Password = $_POST['password'];

$sql = mysqli_query($con, "SELECT * FROM login WHERE email='$Email' AND password='$Password'");

if($sql->num_rows > 0)
{
    while ($row = mysqli_fetch_assoc($sql))
    {
      $myarray['message'] = 'User Successfully LoggedIn';

      $myarray['log_id'] = $row['log_id'];
      $myarray['type'] = $row['type'];

    }     
}  
else 
{
    $myarray['message'] = 'Failed to LogIn';
}
echo json_encode($myarray);
?>