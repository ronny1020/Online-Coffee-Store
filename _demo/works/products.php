<?php
session_start();

//Prevents direct connection.
if ($_SESSION['username'] == '' || $_SESSION['AorS'] != 1) {
    header('Location: ../index.php');
    //echo "<script type='text/javascript'>alert('請先登入！');</script>";
}

//Logout:
//清空SESSION
if (isset($_POST["logout"])) {

    $_SESSION['username'] = '';
    $_SESSION['AorS'] = '';
    header('Location: ../index.php');
}

// get page
if (isset($_GET["page"])) {
    $page = $_GET["page"];
} else {
    $page = 1;
}
//number of rows

if (isset($_POST["row_num_submit"])) {
    $_SESSION["products_row_num"] = $_POST["row_num"];
} else if (isset($_SESSION["products_row_num"])) {
} else {
    $_SESSION["products_row_num"] = 50;
}
$rowNum = $_SESSION["products_row_num"];



//connect to SQL
header("content-type:text/html; charset=utf-8");
$link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");

// right delete btn
foreach ($_POST as $i => $j) {
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = <<<SqlQuery
        DELETE FROM coffee.products WHERE productID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandText);
        header('location:' . $_SERVER['REQUEST_URI'] . '');
    }
}

// delete selected items
if (isset($_POST["deleteSelected"])) {
    $selectedList = "!";

    foreach ($_POST as $i => $j) {
        if (substr($i, 0, 8) == "selected") {
            $selectedItem = ltrim($i, "selected");
            $selectedList = $selectedList . ",'" . $selectedItem . "'";
        }
    }
    $selectedList = ltrim($selectedList, "!,");
    $deleteSelectedCommandText = <<<SqlQuery
  DELETE FROM coffee.products WHERE productID IN ($selectedList)
  SqlQuery;
    mysqli_query($link, $deleteSelectedCommandText);
    header('location:' . $_SERVER['REQUEST_URI'] . '');
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
    <link rel="stylesheet" type="text/css" href="../demostyle.css">
    <script src="../demoutil.js"></script>
</head>

<body>
    <?php include '../parts/sidebar.php';?>
    <?php include '../parts/head.php';?>

    <!-- Start your code here -->
    <div class="main p-5">

        <form method='post' class="card p-3">
            <div>
                <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')"
                    class="btn btn-danger mb-3">
                <input type="submit" value="新增資料" class="btn btn-primary ml-3 mb-3">

                <div class='float-right'>
                    <label for="row_num_select">請選擇顯示行數:</label>
                    <select id="row_num_select" name="row_num">
                        <option value="10" <?php if ($rowNum == 10) {echo "selected";}?>>10 </option>
                        <option value="20" <?php if ($rowNum == 20) {echo "selected";}?>>20 </option>
                        <option value="50" <?php if ($rowNum == 50) {echo "selected";}?>>50 </option>
                        <option value="100" <?php if ($rowNum == 100) {echo "selected";}?>>100</option>
                    </select>
                    <input type="submit" value="確定" name="row_num_submit" class="btn btn-primary ml-3 mb-3">
                </div>
            </div>

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

                    <?php
// write table
$tableOffSet = $rowNum * $page;
$commandText = <<<SqlQuery
                    select productID, ProductName, sellerID, UnitPrice, UnitsInStock from coffee.products ORDER BY productID LIMIT $rowNum OFFSET $tableOffSet
                    SqlQuery;
$result = mysqli_query($link, $commandText);

while ($row = mysqli_fetch_assoc($result)):

?>

                    <tr>
                        <td>
                            <input type="checkbox" name="<?php echo "selected" . $row["productID"] ?>"
                                class="btn btn-danger mb-3">
                        </td>
                        <td><?php echo $row["productID"] ?></td>
                        <td><?php echo $row["ProductName"] ?></td>
                        <td><?php echo $row["sellerID"] ?></td>
                        <td><?php echo $row["UnitPrice"] ?></td>
                        <td><?php echo $row["UnitsInStock"] ?>
                        <td class="p-0">
                            <input type="submit" value="刪除" name="<?php echo "delete" . $row["productID"] ?>"
                                class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                            <input type="submit" value="編輯" class="btn btn-primary mb-3">
                        </td>
                    </tr>
                    <?php endwhile?>
                </tbody>

            </table>
        </form>


        <div class="d-flex justify-content-center m-5">
        <!-- page select -->
        <?php

        $total_num_rows = mysqli_num_rows(mysqli_query($link,"select productID from coffee.products;"));
        $lastPage=floor($total_num_rows/$rowNum);
        if($lastPage<9999999){
            for($i=1 ; $i<=$lastPage ; $i++ ){
                echo " <a class='m-1' href='products.php?page=$i'>$i</a>";
            }
        }
        ?>
    
        </div>

    </div>

    <!-- End your code here. -->
    <?php include '../parts/footer.php';?>

</body>