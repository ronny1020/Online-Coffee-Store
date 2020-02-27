<?php
session_start();

//Prevents direct connection.
if ($_SESSION['username'] == '' || $_SESSION['AorS'] != 0) {
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

//connect to SQL
header("content-type:text/html; charset=utf-8");
$link = @mysqli_connect("localhost", "root", "root") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");

// right delete btn
foreach ($_POST as $i => $j) {
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = <<<SqlQuery
        DELETE FROM coffee.sellers WHERE sellerID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandText);
        header('location: sellers.php');
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
  DELETE FROM coffee.sellers WHERE sellerID IN ($selectedList)
  SqlQuery;
    mysqli_query($link, $deleteSelectedCommandText);
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}
// insert new data
if (isset($_POST["testsubmit"])){
    $insertData = $_POST["insert"];
    $insertCommandText = <<<SqlQuery
    INSERT INTO coffee.sellers VALUES ('$insertData','11','22','33','44','55')
    SqlQuery;
    mysqli_query($link, $insertCommandText);
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
<!-- Start your code here. -->
<div class="main p-5">

    <form method='post' class="card p-3">
        <div>
            <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')"
                class="btn btn-danger mb-3">
            <input type="button" value="新增資料" class="btn btn-primary ml-3 mb-3" data-toggle="modal" data-target="#exampleModal">
        </div>

        <table class="table table-striped ">
            <thead class="thead-light">
                <tr>
                    <th>check</th>
                    <th>sellerID</th>
                    <th>sName</th>
                    <th>sAccount</th>
                    <th>sPassword</th>
                    <th>sAddress</th>
                    <th>sPhone</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php
    // write table
    $commandText = <<<SqlQuery
        select sellerID, sName, sAccount, sPassword, sAddress, sPhone
        from coffee.sellers
        SqlQuery;
    
    $result = mysqli_query($link, $commandText);
    while ($row = mysqli_fetch_assoc($result)): ?>

                <tr>
                    <!-- <label class="form-check-label"> -->
                        <td>
                            <input type="checkbox" name="<?php echo "selected" . $row["sellerID"] ?>"
                                class="btn btn-danger mb-3">
                        </td>
                        <td><?php echo $row["sellerID"] ?></td>
                        <td><?php echo $row["sName"] ?></td>
                        <td><?php echo $row["sAccount"] ?></td>
                        <td><?php echo $row["sPassword"] ?></td>
                        <td><?php echo $row["sAddress"] ?></td>
                        <td><?php echo $row["sPhone"] ?></td>
                        <td>
                            <input type="submit" value="刪除" name="<?php echo "delete".$row["sellerID"] ?>"
                                class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                            <!-- <input type="submit" value="編輯" name="<?php echo "edit".$row["sellerID"] ?>"
                            class="btn btn-primary mb-3"> -->
                </tr>
                <?php endwhile?>
            </tbody>
        </table>
        
    </form>

            <!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">新增 / 編輯</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form method="POST" action="">
            <input type="text" name="insert" />
            <input type="submit" name="testsubmit" />
        <form> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

</div>

<!-- End your code here. -->
<!-- <?php include '../parts/footer.php';?> -->

</body>