<?php
include 'connection.php';
$data = mysqli_query($con,"select * from add_rental_vehicles where status='0'");
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
                    <h4 class="card-title">Total Request</h4>
                   <!-- <p class="card-description"> Add class <code>.table</code>
                    </p> -->
                    <table class="table">
                      <thead>
                        <tr>
                          <th>name</th>
                          <th>price</th>
                          <th>type of vehicle</th>
                          <th>type_of_gear</th>
                          <th>color_of_vehicle</th>
                          <th>seats_of_vehicle</th>
                          <th >fuel_of_vehicle</th>
                          <th >location</th>
                        </tr>
                      </thead>
                      <tbody>
                      <?php
                        while($row = mysqli_fetch_assoc($data)){
                      ?>
                        <tr>
                          <td><?php echo $row['name']?></td>
                          <td> <?php echo $row['price']?></td>
                          <td><?php echo $row['vehicle_type']?></td>
                          <td><?php echo $row['type_of_gear']?></td>
                          <td><?php echo $row['color_of_vehicle']?></td>
                          <td><?php echo $row['seats_of_vehicle']?></td>
                          <td><?php echo $row['fuel_of_vehicle']?></td>
                          <td><?php echo $row['location']?></td>
                          
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