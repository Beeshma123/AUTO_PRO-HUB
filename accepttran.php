<?php
include 'connection.php';
$data = mysqli_query($con,"select * from add_transportation_vehicle where status='1'");
?>


<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>vehicle booking Admin - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">
    

    <!-- Page Wrapper -->
    <div id="wrapper">
<?php
include 'Sidebar.php'
?>

        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <?php
                include 'header.php';
                ?>
                <!-- End of Topbar -->
                <main id="main" class="main">

        <!-- partial -->
        <div class="main-panel">
        <div class="content-wrapper">
        <div class="row">
              <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Accept transportation vehicles</h4>
                   <!-- <p class="card-description"> Add class <code>.table</code>
                    </p> -->
                    <table class="table">
                      <thead>
                        <tr>
                        <th>type of vehicle</th>
                          <th>price</th>
                          <th>location</th>
                          <th>RC</th>
                          <th>Insurance</th>
                          <th>Driving licence</th>
                          <th>Vehicles photo</th>
                        </tr>
                      </thead>
                      <tbody>
                      <?php
                        while($row = mysqli_fetch_assoc($data)){
                      ?>
                        <tr>
                        
                          <td><?php echo $row['vehicle']?></td>
                          <td><?php echo $row['price']?></td>
                          <td><?php echo $row['location']?></td>
                          <td><a href="image/<?php echo $row['RC']?>" download><?php echo $row['RC']?></a></td>
                          <td><a href="image/<?php echo $row['insurance']?>" download><?php echo $row['insurance']?></a></td>
                          <td><a href="image/<?php echo $row['dl']?>" download><?php echo $row['dl']?></a></td>
                          <td><a href="image/<?php echo $row['upload_photo']?>" download><?php echo $row['upload_photo']?></a></td>
                          
                          
                          
                
                          <!-- <td> <a href="accept.php?id=<?php echo $row['transportation_id'] ?>" type="button" class="btn btn-inverse-success">Accept</a></td>
                          <td> <a href="reject.php?id=<?php echo $row['transportation_id'] ?>" type="button" class="btn btn-inverse-success">Reject</a></td> -->
                          </tr>
                          <?php 
                             }
                          ?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
                      </div>
          </div>
          <!-- partial -->
        </div>
                            </div>
                            </div>
        <!-- main-panel ends -->
      </div>
      <!-- page-body-wrapper ends -->
    </div> 
    <!-- container-scroller -->
    <!-- plugins:js -->
    <script src="assets/vendors/js/vendor.bundle.base.js"></script>
    <!-- endinject -->
    <!-- Plugin js for this page -->
    <script src="assets/vendors/chart.js/Chart.min.js"></script>
    <script src="assets/vendors/jquery-circle-progress/js/circle-progress.min.js"></script>
    <script src="assets/js/jquery.cookie.js" type="text/javascript"></script>
    <!-- End plugin js for this page -->
    <!-- inject:js -->
    <script src="assets/js/off-canvas.js"></script>
    <script src="assets/js/hoverable-collapse.js"></script>
    <script src="assets/js/misc.js"></script>
    <!-- endinject -->
    <!-- Custom js for this page -->
    <script src="assets/js/dashboard.js"></script>
    <!-- End custom js for this page -->
  </body>
</html>