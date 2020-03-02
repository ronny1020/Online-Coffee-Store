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
$link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");

//========== ADD: ADJUST COLUMN. ==========//
// get page
if (isset($_GET["page"])) {
    $page = $_GET["page"];
} else {
    $page = 1;
}
//number of rows
if (isset($_POST["row_num_submit"])) {
    $_SESSION["member_row_num"] = $_POST["row_num"];
    header('Location: sellers.php');
} else if (isset($_SESSION["member_row_num"])) {
} else {
//初始欄數=50
    $_SESSION["member_row_num"] = 50;
}
$rowNum = $_SESSION["member_row_num"];

//總欄數:
$total_num_rows = mysqli_num_rows(mysqli_query($link, "select customerID from coffee.customers;"));
//最後一頁的頁數為:
$lastPage = floor($total_num_rows / $rowNum) + 1;
$tableOffSet = $rowNum * ($page - 1);
$showDataStartFrom = $tableOffSet + 1;
$showDataEndTo = $tableOffSet + $rowNum;
if ($showDataEndTo > $total_num_rows) {
    $showDataEndTo = $total_num_rows;
}
;
$previousPage = $page - 1;
$nextPage = $page + 1;

//===== ENDED HERE. =====//

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
if (isset($_POST["modal-submit"])){
    $sid = $_POST['sid'];
    $nam = $_POST['nam'];
    $acc = $_POST['acc'];
    $pwd = $_POST['pwd'];
    $adr = $_POST['adr'];
    $phone = $_POST['phone'];
    $insertCommandText = <<<SqlQuery
    INSERT INTO coffee.sellers VALUES ('$sid','$nam','$acc','$pwd','$adr','$phone')
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
            <input type="button" value="新增資料" name="edit" class="btn btn-primary ml-3 mb-3" data-toggle="modal" data-target="#exampleModal">
            <div class='float-right'>
                    <span class="mr-5">
                    <!-- show where you are -->
                    <?php echo "您在第 $page 頁，顯示資料為 $showDataStartFrom - $showDataEndTo 筆(共 $total_num_rows 筆資料)" ?>
                    </span>
                    <label for="row_num_select">請選擇顯示行數:</label>
                    <select id="row_num_select" name="row_num">
                        <option value="10" <?php if ($rowNum == 10) {echo "selected";}?>>10 </option>
                        <option value="20" <?php if ($rowNum == 20) {echo "selected";}?>>20 </option>
                        <option value="50" <?php if ($rowNum == 50) {echo "selected";}?>>50 </option>
                        <option value="100" <?php if ($rowNum == 100) {echo "selected";}?>>100</option>
                    </select>
                    <input type="submit" value="確定" name="row_num_submit" class="btn btn-primary ml-3 mb-3">
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
        </div>
    </form>

<!--頁尾頁碼&按鈕顯示:-->
    <div class="d-flex justify-content-center align-items-center flex-column  m-5">
        <!-- page select -->
        <div class="m-3">
            <a class='m-2 btn btn-info' href='sellers.php?page=1'>第一頁</a>
            <a class='m-2 btn btn-info' href='sellers.php?page=<?php echo ($page <= 1) ? "1" : $previousPage; ?>'>上一頁</a>
            <a class='m-2 btn btn-info' href='sellers.php?page=<?php echo ($page >= $lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
            <a class='m-2 btn btn-info' href='sellers.php?page=<?php echo $lastPage; ?>'>最尾頁</a>
        </div>
    <div>
<?php
for ($i = 1; $i <= 3 && $i <= $lastPage; $i++) {
    echo " <a class='m-2' href='sellers.php?page=$i'>$i</a>";
}
if ($page <= 6) {
    for ($i = 4; $i <= ($page + 2) && $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='sellers.php?page=$i'>$i</a>";
    }
} else {
    echo "<span>......</span>";
    for ($i = ($page - 2); $i <= ($page + 2) && $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='sellers.php?page=$i'>$i</a>";
    }
}
if ($lastPage - $page <= 5) {
    for ($i = ($page + 3); $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='sellers.php?page=$i'>$i</a>";
    }
} else {
    echo "<span>......</span>";
    for ($i = ($lastPage - 2); $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='sellers.php?page=$i'>$i</a>";
    }
}
?>
<!--頁尾頁碼&按鈕結束-->
    </div>

<!-- Dummy frame. -->
<iframe name="thisframe"></iframe>
<!-- Modal -->

    <!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    <form method="POST" action="">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">新增 / 編輯</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <tr>
            <th>sellerID:<input type="text" name='sid'>
            </th>
            <hr>
            <th>sName: <input type="text" name='nam'></th>
            <hr>
            <th>sAccount: <input type="text" name='acc'>
            </th>
            <hr>
            <th>sPassword: <input type="text" name='pwd'>
            </th>
            <hr>
            <th>sAddress: <input type="text" name='adr'>
            </th>
            <hr>
            <th>sPhone: <input type="text" name='phone'></th>
        </tr>
      </div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-primary" name="modal-submit" value="submit" />
        <button type="button" class="btn btn-danger"  data-dismiss="modal">colse</button>
      </div>
      </form>
    </div>
  </div>
</div>
</div>
</div>
<!-- End your code here. -->
<?php include '../parts/footer.php';?>

</body>