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

header("content-type:text/html; charset=utf-8");
$link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");

$commandText = <<<SqlQuery
select productID, ProductName, sellerID, UnitPrice, UnitsInStock
from coffee.products
SqlQuery;

$result = mysqli_query($link, $commandText);

?>

<!-- right delete btn -->
<?php 
  $deleteItem;
 foreach($_POST as $i=>$j){
  echo $i;
  $deleteItem = $i;
  echo $deleteItem;
 }
echo $deleteItem;
if($deleteItem != 'logout'){
$deleteCommandText= <<<SqlQuery
DELETE FROM coffee.products WHERE productID='$deleteItem';
SqlQuery;
mysqli_query($link, $deleteCommandText);

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

<form method='post'>
  <input type="submit" value="刪除勾選" class="btn btn-danger mb-3">
  <input type="submit" value="新增資料" class="btn btn-primary ml-3 mb-3">
</form>

<form method='post'>
  <table class="table table-striped ">
    <thead class="thead-light">
      <tr>
        <th>check</th>
        <th>productID</th>
        <th>ProductName</th>
        <th>sellerID</th>
        <th>UnitPrice</th>
        <th>UnitsInStock</th>
        <th></th>
      </tr>
    </thead>

    <tbody>

    <?php while ($row = mysqli_fetch_assoc($result)): ?>
		  <tr>
        <td>
         <input type="checkbox" value=""  class="btn btn-danger mb-3">
        </td>
          <td><?php echo $row["productID"] ?></td>
          <td><?php echo $row["ProductName"] ?></td>
          <td><?php echo $row["sellerID"] ?></td>
          <td><?php echo $row["UnitPrice"] ?></td>
          <td><?php echo $row["UnitsInStock"] ?></td>
         <td>
           <input type="submit" value="刪除" name="<?php echo $row["productID"] ?>" class="btn btn-danger mb-3">
           <input type="submit" value="編輯" class="btn btn-primary mb-3">
        </tr>
    	  <?php endwhile?>
      </tbody>

    </table>
    </form>

  </div>

<?php include 'footer.php';?>

</body>