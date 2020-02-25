<?php
session_start();

//Prevents direct connection.
if ($_COOKIE['username'] == '') {
    header('Location: index.php');
    //echo "<script type='text/javascript'>alert('請先登入！');</script>";
}

// $_SESSION["username"] = "seller";

//logout function
if (isset($_POST["logout"])) {
    setcookie("username", "", time() - 3600);
    unset($_SESSION['AorS']);
    header('Location: index.php');
}

?>
<!DOCTYPE html>
<title>管理後台</title>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- include Bootstrap 4: cdn-->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC|Noto+Serif+TC&display=swap" rel="stylesheet">

    <!-- I edited these stuffs.-->
    <link rel="stylesheet" type="text/css" href="demostyle.css">
    <script src="demoutil.js"></script>
</head>

<body>
    <?php include 'sidebar.php';?>
    <?php include 'head.php';?>

<!-- Start your code here -->
<div class ="main p-5">
<form>
<input type="submit" value="刪除" class="btn btn-danger mb-3">
</form>
  <table class="table table-striped ">
    <thead class="thead-light">
      <tr>
        <th>Firstname</th>
        <th>Lastname</th>
        <th>Email</th>
        <th>Email</th>
        <th>Email</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John</td>
        <td>Doe</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
      </tr>
      <tr>
        <td>Mary</td>
        <td>Moe</td>
        <td>mary@example.com</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
      </tr>
      <tr>
        <td>July</td>
        <td>Dooley</td>
        <td>july@example.com</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
        <td>john@example.com</td>
      </tr>
    </tbody>
  </table>
 
</div>

<?php include 'footer.php';?>

</body>