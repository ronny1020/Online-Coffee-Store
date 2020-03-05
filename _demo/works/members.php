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
    // session_destroy();
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
    header('Location: members.php');
} else if (isset($_SESSION["member_row_num"])) {
} else {
//初始欄數=50
    $_SESSION["member_row_num"] = 50;
}
$rowNum = $_SESSION["member_row_num"];

//總欄數:
$total_num_rows = mysqli_num_rows(mysqli_query($link, "select customerID from coffee.customers;"));
//最後一頁的頁數為:
$lastPage = ceil($total_num_rows / $rowNum);
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

//2 Buttons work here.
foreach ($_POST as $i => $j) {
    //Right delete button:
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = <<<SqlQuery
        DELETE FROM coffee.customers WHERE customerID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandText);
        header('location:' . $_SERVER['REQUEST_URI'] . '');
    }
}

//ADD NEW DATA TO FORM! :
if (isset($_POST['modal_submit'])) {
    $tmp_cid = $_POST['cid'];
    $tmp_nam = $_POST['nam'];
    $tmp_acc = $_POST['acc'];
    $tmp_eml = $_POST['eml'];
    $tmp_sex = $_POST['sex'];
    $tmp_bid = $_POST['bid'];
    $tmp_adr = $_POST['adr'];
    $tmp_mob = $_POST['mob'];
    $tmp_pwd = password_hash($_POST['pwd'], PASSWORD_BCRYPT);
    $insertCommandText = <<<SqlQuery
    insert into coffee.customers VALUES ('$tmp_cid','$tmp_nam','$tmp_acc','$tmp_eml','$tmp_pwd','$tmp_sex','$tmp_bid','$tmp_adr','$tmp_mob')
    SqlQuery;
    mysqli_query($link, $insertCommandText);
}

//EDIT INNER DATA FROM FROM!
//整行砍掉再重丟
if (isset($_POST['modal_submit_e'])) {
    $tmp_cid_e = $_POST['cid_e'];
    $tmp_nam_e = $_POST['nam_e'];
    $tmp_acc_e = $_POST['acc_e'];
    $tmp_eml_e = $_POST['eml_e'];
    $tmp_sex_e = $_POST['sex_e'];
    $tmp_bid_e = $_POST['bid_e'];
    $tmp_adr_e = $_POST['adr_e'];
    $tmp_mob_e = $_POST['mob_e'];
    // echo $tmp_sex_e . $tmp_bid_e;
    //刪除舊資料
    $insertCommandText = <<<SqlQuery
    UPDATE `coffee`.`customers` SET 
    `cName` = '$tmp_nam_e', 
    `cAccount` = '$tmp_acc_e',
    `cEmail` = '$tmp_eml_e', 
    `cSex` = '$tmp_sex_e',
    `cBirthDate` = '$tmp_bid_e',
    `cAddress` = '$tmp_adr_e',
    `cMobile` = '$tmp_mob_e'
    WHERE customerID IN ('$tmp_cid_e');
    SqlQuery;
    mysqli_query($link, $insertCommandText);
}

// delete selected items:
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
    DELETE FROM coffee.customers WHERE customerID IN ($selectedList)
    SqlQuery;
    mysqli_query($link, $deleteSelectedCommandText);
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}

// Export selected items.
if (isset($_POST["exportSelected"])) {

    $selectedList = "('";
    foreach ($_POST as $i => $j) {
        if (substr($i, 0, 8) == "selected") {
            $selectedItem = ltrim($i, "selected");
            $selectedList .= $selectedItem . "','";
        }
    }
    $selectedList = rtrim($selectedList, ",");
    $selectedList .= "')";

    //防呆 一個都沒勾的話:
    if ($selectedList == "('')") {
        // echo "<script>alert('Please select at least 1 column.');</script>";
        header('location:' . $_SERVER['REQUEST_URI'] . '');
    }
    //多一空欄位 '' 但不影響功能
    // echo $selectedList;
    $exportComment = <<<SqlQuery
    select customerID, cName, cAccount, cEmail, cSex, cBirthDate, cAddress, cMobile from coffee.customers
    WHERE customerID IN $selectedList ORDER BY customerID
    SqlQuery;

    $exportResult = mysqli_query($link, $exportComment);
    // if($exportResult === FALSE){
    //     // echo $exportResult;
    //     // exit;
    // }
    // else{
    $columns_total = mysqli_num_fields($exportResult);
    $exportResult_exist = mysqli_num_rows($exportResult) > 0;
    if ($exportResult_exist) {
        // Get The Field Name
        $output = "";
        for ($i = 0; $i < $columns_total; $i++) {
            $heading = mysqli_fetch_field_direct($exportResult, $i);
            $output .= '"' . $heading->name . '",';
        }
        $output .= "\n";

        // Get Records from the table
        while ($row = mysqli_fetch_assoc($exportResult)) {
            $output .= '"' . $row["customerID"] . '",';
            $output .= '"' . $row["cName"] . '",';
            $output .= '"' . $row["cAccount"] . '",';
            $output .= '"' . $row["cEmail"] . '",';
            $output .= '"' . $row["cSex"] . '",';
            $output .= '"' . $row["cBirthDate"] . '",';
            $output .= '"' . $row["cAddress"] . '",';
            $output .= '"' . $row["cMobile"] . '",';
            $output .= "\n";
        }

        $filename = "MemberList" . date('Y-m-d H:i:s') . ".csv";
        header('Content-Encoding: UTF-8');
        header("Content-Type: text/csv; charset=UTF-8");
        header('Content-Disposition: attachment; filename=' . $filename);
        echo "\xEF\xBB\xBF";
        echo $output;

    }
    exit;
}
// }

//========== 欄位排序調整: ==========//
//Adjusted by 2 SESSION:
// 1. ASCorDESC: 決定升序抑或降序
// if ASC triggered:

if (isset($_POST["customerID_ASC"]) ||
    isset($_POST["cName_ASC"]) ||
    isset($_POST["cSex_ASC"]) ||
    isset($_POST["cBirthDate_ASC"])) {
    $_SESSION["ASCorDESC"] = "ASC";

//elseif DESC triggered:
} else if (
    isset($_POST["customerID_DESC"]) ||
    isset($_POST["cName_DESC"]) ||
    isset($_POST["cSex_DESC"]) ||
    isset($_POST["cBirthDate_DESC"])) {
    $_SESSION["ASCorDESC"] = "DESC";
} else if (isset($_SESSION["ASCorDESC"])) {
} else { // Default of ASCorDESC: ASC(升序)
    $_SESSION["ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["ASCorDESC"];

// 2. ORDERBY: 決定以何物排序
if (isset($_POST["customerID_ASC"]) || isset($_POST["customerID_DESC"])) {
    $_SESSION["cu_orderby"] = "customerID";
} else if (isset($_POST["cName_ASC"]) || isset($_POST["cName_DESC"])) {
    $_SESSION["cu_orderby"] = "cName";
} else if (isset($_POST["cSex"]) || isset($_POST["cSex_DESC"])) {
    $_SESSION["cu_orderby"] = "cSex";
} else if (isset($_POST["cBirthDate_ASC"]) || isset($_POST["cBirthDate_DESC"])) {
    $_SESSION["cu_orderby"] = "cBirthDate";
} else if (isset($_SESSION["cu_orderby"])) {
} else { // Default of orderby: cramID
    $_SESSION["cu_orderby"] = "customerID";
}
$orderby = $_SESSION["cu_orderby"];

//======= 排序調整: END HERE. =======//

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
        <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')"class="btn btn-danger mb-3">
        <input type="submit" value="匯出勾選" class="btn btn-info ml-3 mb-3" name="exportSelected">
        <!--Modal toggled here.-->
        <input type="button" value="新增資料" name="edit" class="btn btn-primary ml-3 mb-3"
               data-toggle="modal" data-target="#myModal">
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
                    </span>
                </div>

    <!--======= Main table標題⬇: =======-->
    <table class="table table-striped ">
    <thead class="bg-color-silk">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" onclick="selectAllCheckbox()" class='checkmark' style='position: relative;'>
                            <label for="selectAll">全選</label>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0 ">
                                <p class="m-1">customerID</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="customerID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="customerID_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cName</p>
                                <div class="DESC-ASC ml-2">
                                <input type="submit" class="d-block btn btn-DESC" value="▲" name="cName_DESC">
                                <input type="submit" class="d-block btn btn-ASC" value="▼" name="cName_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cAccount</p>
                            </div>

                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cEmail</p>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cSex</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="cSex_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="cSex_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cBirthDate</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="cBirthDate_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="cBirthDate_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cAddress</p>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cMobile</p>
                            </div>
                        </th>

                        <th>
                        </th>
                </thead>
        <tbody>
<!--======= Main table標題⬆: =======-->
<?php
// write table
// $commandText: $str
// 受所允許之總欄數調控
$commandText = <<<SqlQuery
select customerID, cName, cAccount, cEmail, cSex, cBirthDate, cAddress, cMobile
from coffee.customers ORDER BY $orderby $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet
SqlQuery;

$result = mysqli_query($link, $commandText);
while ($row = mysqli_fetch_assoc($result)): ?>

<tr>
                        <td>
                        <input type="checkbox" name="<?php echo "selected" . $row["customerID"] ?>"class='checkmark'
                        style='position: relative;'>
                        </td>
                        <!-- ID added here. -->
                        <td id="<?php echo $row["customerID"] . "customerID" ?>"><?php echo $row["customerID"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cName" ?>" ><?php echo $row["cName"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cAccount" ?>" ><?php echo $row["cAccount"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cEmail" ?>" ><?php echo $row["cEmail"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cSex" ?>" ><?php echo $row["cSex"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cBirthDate" ?>" ><?php echo $row["cBirthDate"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cAddress" ?>" ><?php echo $row["cAddress"] ?></td>
                        <td id="<?php echo $row["customerID"] . "cMobile" ?>" ><?php echo $row["cMobile"] ?></td>

                        <td>
                    <input type="submit" value="刪除" name="<?php echo "delete" . $row["customerID"] ?>"
                        class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                    <!--Modal aslo toggled at here.-->
                    <input type='button' value="編輯" name="<?php echo "edit" . $row["customerID"] ?>"
                        class="btn btn-primary mb-3" onclick="throwinmodal_MEMBERS(<?php echo "'" . $row['customerID'] . "'" ?>)">
                        </td>
</tr>
            <?php endwhile?>
        </tbody>
    </table>
</form>
<!--頁尾頁碼&按鈕顯示:-->
<div class="d-flex justify-content-center align-items-center flex-column  m-5">
        <!-- page select -->
        <div class="m-3">
            <a class='m-2 btn btn-info' href='members.php?page=1'>第一頁</a>
            <a class='m-2 btn btn-info' href='members.php?page=<?php echo ($page <= 1) ? "1" : $previousPage; ?>'>上一頁</a>
            <a class='m-2 btn btn-info' href='members.php?page=<?php echo ($page >= $lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
            <a class='m-2 btn btn-info' href='members.php?page=<?php echo $lastPage; ?>'>最尾頁</a>
        </div>
            <div>
            <?php
for ($i = 1; $i <= 3 && $i <= $lastPage; $i++) {
    echo " <a class='m-2' href='members.php?page=$i'>$i</a>";
}
if ($page <= 6) {
    for ($i = 4; $i <= ($page + 2) && $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='members.php?page=$i'>$i</a>";
    }
} else {
    echo "<span>......</span>";
    for ($i = ($page - 2); $i <= ($page + 2) && $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='members.php?page=$i'>$i</a>";
    }
}
if ($lastPage - $page <= 5) {
    for ($i = ($page + 3); $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='members.php?page=$i'>$i</a>";
    }
} else {
    echo "<span>......</span>";
    for ($i = ($lastPage - 2); $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='members.php?page=$i'>$i</a>";
    }
}

?>
<!--頁尾頁碼&按鈕結束-->
</div>

<!-- Modal: add new -->
<div class="modal fade" id="myModal">
<div class="modal-dialog">
    <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header">
            <h4 class="modal-title">資料變更:</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <form method="post" action=''>
        <!-- Modal body -->
        <div class="modal-body">
            <tr>

                    <th>customerID:<input type="text" name='cid'>
                    </th>
                    <hr>
                    <th>cName: <input type="text" name='nam'></th>
                    <hr>
                    <th>cAccount: <input type="text" name='acc'>
                    </th>
                    <hr>
                    <th>cEmail: <input type="text" name='eml'>
                    </th>
                    <hr>
                    <th>cBirthDate:<input type="date" name='bid'>
                    </th>
                    <hr>
                    <th>cAddress: <input type="text" name='adr'>
                    </th>
                    <hr>
                    <th>cMobile: <input type="text" name='mob'></th>
                    <hr>
                    <th>cSex:
                    <select name='sex'>
                        <option value='M'>男</option>
                        <option value='F'>女</option>
                    </select>
                    </th>
                    <hr>
                    <th>
                    <span style="color:red;">cPassword:</span>
                    <input type="password" name='pwd' id='pwd' onkeyup='MODAL_PWcheck();'></th>
                    <hr>
                    <th>
                    <span style="color:red;">confirm Password:</span>
                    <input type="password" name='pwd_check' id='pwd_check' onkeyup='MODAL_PWcheck();'></th>
                    <hr>
                    <th><span id='error_msg' style="font-weight:bolder;"></span></th>
            </tr>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
            <input type="submit" name="modal_submit" id="modal_submit" value='submit' class="btn btn-primary"></input>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        </form>
    </div>
</div>
</div>

<!-- Modal: Edit old!-->
<div class="modal fade" id="Modal_edit">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">資料變更:</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <form method="post" action=''>
                <!-- Modal body -->
                <div class="modal-body">
                    <tr>

                    <th>customerID:<input type="text" name='cid_e' id='cid_e' readonly>
                    </th>
                    <hr>
                    <th>cName: <input type="text" name='nam_e' id='nam_e'></th>
                    <hr>
                    <th>cAccount: <input type="text" name='acc_e' id='acc_e'>
                    </th>
                    <hr>
                    <th>cEmail: <input type="text" name='eml_e' id='eml_e'>
                    </th>
                    <hr>
                    <th>cBirthDate:<input type="date" name='bid_e' id='bid_e'>
                    </th>
                    <hr>
                    <th>cAddress: <input type="text" name='adr_e' id='adr_e'>
                    </th>
                    <hr>
                    <th>cMobile: <input type="text" name='mob_e' id='mob_e'></th>
                    <hr>
                    <th>cSex: <select name='sex_e' id='sex_e'>
                        <option value='M'>男</option>
                        <option value='F'>女</option>
                    </select></th>
                    </tr>
                </div>
                <!-- Modal footer -->
                <div class="modal-footer">
                    <input type="submit" name="modal_submit_e" value='submit' class="btn btn-primary"></input>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
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

<script>
    
</script>