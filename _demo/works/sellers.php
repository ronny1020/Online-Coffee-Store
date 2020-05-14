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
    $_SESSION["seller_row_num"] = $_POST["row_num"];
    header('Location: sellers.php');
} else if (isset($_SESSION["seller_row_num"])) {
} else {
//初始欄數=50
    $_SESSION["seller_row_num"] = 50;
}
$rowNum = $_SESSION["seller_row_num"];

//總欄數:
$total_num_rows = mysqli_num_rows(mysqli_query($link, "select sellerID from coffee.sellers;"));
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
        $deleteCommandText = "
        DELETE FROM coffee.sellers WHERE sellerID IN ('$deleteItem')
        ";
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
    $deleteSelectedCommandText = "
  DELETE FROM coffee.sellers WHERE sellerID IN ($selectedList)
  ";
    mysqli_query($link, $deleteSelectedCommandText);
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}

// insert new data
if (isset($_POST["modal-submit"])){
    $sid = $_POST['sid'];
    $nam = $_POST['nam'];
    $acc = $_POST['acc'];
    $pwd = password_hash($_POST['pwd'], PASSWORD_BCRYPT);
    $adr = $_POST['adr'];
    $phone = $_POST['phone'];
    $mail = $_POST['mail'];
    $country = $_POST['country'];
    $insertCommandText = "
    INSERT INTO coffee.sellers VALUES ('$sid','$nam','$acc','$pwd','$adr','$phone','$mail','$country')
    ";
    mysqli_query($link, $insertCommandText);
}

// edit data
if (isset($_POST['edModal-submit'])){
    $sid = $_POST['sid'];
    $nam = $_POST['nam'];
    $acc = $_POST['acc'];
    $pwd = $_POST['pwd'];
    $adr = $_POST['adr'];
    $phone = $_POST['phone'];
    $mail = $_POST['mail'];
    $country = $_POST['country'];
    $editCommandText = "
    UPDATE coffee.sellers SET sellerID='$sid', sName='$nam', sAccount='$acc',sPassword='$pwd', 
    sAddress='$adr', sPhone='$phone', sMail='$mail', sCountry='$country' 
    where sellerID = '$sid'
    ";
    mysqli_query($link, $editCommandText);
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
    <script>
        function displayModal(...params) {
            sid.value = params[0]; //id
            nam.value = params[1]; //name
            acc.value = params[2]; //account
            //pwd.value = params[3]; //password
            adr.value = params[3]; //address
            phone.value = params[4]; //phone
            mail.value = params[5];
            country.value = params[6];
        }
        function selectAll(){
            let check_active = document.querySelectorAll("input[type='checkbox']");
            for (let i of check_active) i.checked = allCheckBox.checked;
        }
    </script>
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
            <input type="button" value="新增資料" name="newInsert" class="btn btn-primary ml-3 mb-3" data-toggle="modal" data-target="#insertModal">
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
            <thead class="bg-color-gold">
                <tr>
                    <th><input class="checkmark" style="position:relative;" type="checkbox" id="allCheckBox" onclick="selectAll()" /><label>全選</label></th>
                    <th>sellerID</th>
                    <th>廠商名稱</th>
                    <th>帳號</th>
                    <!-- <th>密碼</th> -->
                    <th>地址</th>
                    <th>電話</th>
                    <th>email</th>
                    <th>國家/地區</th>
                    <th>編輯</th>
                </tr>
            </thead>
            <tbody>
                <?php
    // write table
    $commandText = "
        select sellerID, sName, sAccount, sPassword, sAddress, sPhone, sMail, sCountry
        from coffee.sellers LIMIT $rowNum OFFSET $tableOffSet
        ";
    $result = mysqli_query($link, $commandText);
    while ($row = mysqli_fetch_assoc($result)): $temp = "'"; ?>
                <tr class="dataSQL"><!-- <label class="form-check-label"> -->
                        <td><input class="checkmark" style="position:relative;" type="checkbox" name="<?php echo "selected".$row["sellerID"]; ?>"></td>
                        <td><?php echo $row["sellerID"]; $temp = $temp.$row["sellerID"]."','"; ?></td>
                        <td><?php echo $row["sName"]; $temp = $temp.$row["sName"]."','"; ?></td>
                        <td><?php echo $row["sAccount"]; $temp = $temp.$row["sAccount"]."','"; ?></td>
                        <!-- <td><?php //echo $row['sPassword']; $temp; $temp = $temp.$row['sPassword']."','"; ?></td> -->
                        <td><?php echo $row["sAddress"]; $temp = $temp.$row["sAddress"]."','"; ?></td>
                        <td><?php echo $row["sPhone"];; $temp = $temp.$row["sPhone"]."','"; ?></td>
                        <td><?php echo $row["sMail"]; $temp = $temp.$row["sMail"]."','"; ?></td>
                        <td><?php echo $row["sCountry"]; $temp = $temp.$row["sCountry"]."'"; ?></td>
                        <td><input type="submit" value="刪除" name="<?php echo "delete".$row["sellerID"] ?>"
                                class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                            <input type="button" value="編輯" name="<?php echo "edit".$row["sellerID"] ?>" 
                                data-toggle="modal" data-target="#editModal"
                                class="btn btn-primary mb-3" onclick="displayModal(<?php echo $temp;?>)">
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

<!-- Modal insert  -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel_insert" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    <form method="POST" action="">
      <div class="modal-header">
        <h5 class="modal-title" id="ModalLabel_insert">新增</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <tr>
            <th>sellerID:<input type="text" name='sid'></th>
            <hr>
            <th>廠商名稱: <input type="text" name='nam'></th>
            <hr>
            <th>帳號: <input type="text" name='acc'></th>
            <hr>
            <th>密碼: <input type="text" name='pwd'></th>
            <hr>
            <th>地址: <input type="text" name='adr'></th>
            <hr>
            <th>電話: <input type="text" name='phone'></th>
            <hr>
            <th>email: <input type="text" name="mail"></th>
            <hr>
            <th>國家/地區: <input type="text" name="country"></th>
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

<!-- Modal edit -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel_edit" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    <form method="POST" action="">
      <div class="modal-header">
        <h5 class="modal-title" id="ModalLabel_edit">編輯</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <tr>
            <th>sellerID:<input type="text" name='sid' id="sid" readonly></th>
            <hr>
            <th>廠商名稱: <input type="text" name='nam' id="nam"></th>
            <hr>
            <th>帳號: <input type="text" name='acc' id="acc"></th>
            <hr>
            <!-- <th>sPassword: <input type="text" name='pwd' id="pwd"></th>
            <hr> -->
            <th>地址: <input type="text" name='adr' id="adr"></th>
            <hr>
            <th>電話: <input type="text" name='phone' id="phone"></th>
            <hr>
            <th>email: <input type="text" name='mail' id='mail'></th>
            <hr>
            <th>國家/地區: <input type="text" name='country' id='country'></th>
        </tr>
      </div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-primary" name="edModal-submit" value="submit" />
        <button type="button" class="btn btn-danger"  data-dismiss="modal">close</button>
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