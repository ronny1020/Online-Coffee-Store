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
    header('Location: cram.php');
} else if (isset($_SESSION["member_row_num"])) {
} else {
//初始欄數=50
    $_SESSION["member_row_num"] = 50;
}
$rowNum = $_SESSION["member_row_num"];

//總欄數:
$total_num_rows = mysqli_num_rows(mysqli_query($link, "select cramID from coffee.crams;"));
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

//2 Buttons work here.
foreach ($_POST as $i => $j) {
    //Right delete button:
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = <<<SqlQuery
        DELETE FROM coffee.crams WHERE cramID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandText);
        header('location:' . $_SERVER['REQUEST_URI'] . '');
    } //Right edit button:
    // elseif (substr($i, 0, 4) == "edit") {
    //     //獲得customerID
    //     $editItem = ltrim($i, "edit");
    //     $editCommandText = <<<SqlQuery
    //     select customerID, cName, cAccount, cSex, cBirthDate, cAddress, cMobile
    //     from coffee.customers WHERE customerID IN ('$editItem')
    //     SqlQuery;
    //     $result = mysqli_query($link, $editCommandText);
    //     while ($row = mysqli_fetch_assoc($result)) {
    //         $_SESSION["modal_cid"] = $row["customerID"];
    //         $_SESSION["modal_nam"] = $row["cName"];
    //         $_SESSION["modal_acc"] = $row["cAccount"];
    //         $_SESSION["modal_sex"] = $row["cSex"];
    //         $_SESSION["modal_bid"] = $row["cBirthDate"];
    //         $_SESSION["modal_adr"] = $row["cAddress"];
    //         $_SESSION["modal_mob"] = $row["cMobile"];
    //     }
    //     ;
    //     // header('location:' . $_SERVER['REQUEST_URI'] . '');
    // }
}

//ADD NEW DATA TO FORM! :
if (isset($_POST['modal_submit'])) {
    $tmp_cri = $_POST['cri'];
    $tmp_cid = $_POST['cid'];
    $tmp_dat = $_POST['dat'];
    $tmp_ccn = $_POST['ccn'];
    $tmp_ckd = $_POST['ckd'];
    $insertCommandText = <<<SqlQuery
    insert into coffee.crams VALUES ('$tmp_cri','$tmp_cid','$tmp_dat','$tmp_ccn','$tmp_ckd')
    SqlQuery;
    mysqli_query($link, $insertCommandText);
}

//EDIT INNER DATA FROM FROM!
//整行砍掉再重丟
if (isset($_POST['modal_submit_e'])) {
    $tmp_cri_e = $_POST['cri_e'];
    $tmp_cid_e = $_POST['cid_e'];
    $tmp_dat_e = $_POST['dat_e'];
    $tmp_ccn_e = $_POST['ccn_e'];
    $tmp_ckd_e = $_POST['ckd_e'];

    //刪除舊資料
    $insertCommandText = <<<SqlQuery
    DELETE FROM coffee.crams WHERE cramID IN ('$tmp_cri_e');
    SqlQuery;
    mysqli_query($link, $insertCommandText);

    //插入新資料
    $insertCommandText = <<<SqlQuery
    insert into coffee.crams VALUES ('$tmp_cri_e','$tmp_cid_e','$tmp_dat_e','$tmp_ccn_e','$tmp_ckd_e');
    SqlQuery;
    mysqli_query($link, $insertCommandText);
}

// $editbtn = "<input type='submit' value='編輯' class='btn btn-primary mb-3' name='to_edit'>";
// $updtbtn = "<input type='submit' value='送出' class='btn btn-primary mb-3' name='to_updt'>";
// $resultBtn = $editbtn;

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
    DELETE FROM coffee.crams WHERE cramID IN ($selectedList)
    SqlQuery;
    mysqli_query($link, $deleteSelectedCommandText);
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}

//===== 排序調整: =====//
//Adjusted by 2 SESSION:
// 1. ASCorDESC: 決定升序抑或降序
// if ASC triggered:

if (isset($_POST["cramID_ASC"]) ||
    isset($_POST["customerID_ASC"]) ||
    isset($_POST["cDate_ASC"]) ||
    // isset($_POST["cramContent_ASC"]) ||
    isset($_POST["cChecked_ASC"])) {
    $_SESSION["ASCorDESC"] = "ASC";
//elseif DESC triggered:
} else if (
    isset($_POST["cramID_DESC"]) ||
    isset($_POST["customerID_DESC"]) ||
    isset($_POST["cDate_DESC"]) ||
    // isset($_POST["cramContent_DESC"]) ||
    isset($_POST["cChecked_DESC"])) {
    $_SESSION["ASCorDESC"] = "DESC";
} else if (isset($_SESSION["ASCorDESC"])) {
} else {// Default of ASCorDESC: ASC(升序)
    $_SESSION["ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["ASCorDESC"];

// 2. ORDERBY: 決定以何物排序
if (isset($_POST["cramID_ASC"]) || isset($_POST["cramID_DESC"])) {
    $_SESSION["orderby"] = "cramID";
} else if (isset($_POST["customerID_ASC"]) || isset($_POST["customerID_DESC"])) {
    $_SESSION["orderby"] = "customerID";
} else if (isset($_POST["cDate_ASC"]) || isset($_POST["cDate_DESC"])) {
    $_SESSION["orderby"] = "cDate";
} else if (isset($_POST["cChecked_ASC"]) || isset($_POST["cChecked_DESC"])) {
    $_SESSION["orderby"] = "cChecked";
} else if (isset($_SESSION["orderby"])) {
} else {// Default of orderby: cramID
    $_SESSION["orderby"] = "cramID";
}
$orderby = $_SESSION["orderby"];

// 排序調整END HERE. //

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
        <!--Modal toggled here.-->
        <input type="button" value="新增資料" name="edit" class="btn btn-primary ml-3 mb-3"
               data-toggle="modal" data-target="#Modal_add">
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
<!-- Main table created here. -->
    <table class="table table-striped ">
    <thead class="bg-color-silk">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" onclick="selectAllCheckbox()" class='checkmark' style='position: relative;'>
                            <label for="selectAll">全選</label>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0 ">
                                <p class="m-1">cramID</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="cramID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="cramID_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">customerID</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="customerID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="customerID_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cDate</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="cDate_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="cDate_ASC">
                                </div>
                            </div>

                        </th>
                        </th>
                        <th class=tags>cramContent
                        </th>
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">cChecked</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="cChecked_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="cChecked_ASC">
                                </div>
                            </div>
                        </th>
                        <!-- here -->
                        <th>
                        </th>
                </thead>
        <tbody>
<?php

// write main table
// $commandText: string
// 受所允許之總欄數調控!
// 受升序降序調控!
$commandText = <<<SqlQuery
select cramID, customerID, cDate, cramContent, cChecked
from coffee.crams ORDER BY $orderby $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet
SqlQuery;

$result = mysqli_query($link, $commandText);

// Give each row specific ID.
$result = mysqli_query($link, $commandText);
while ($row = mysqli_fetch_assoc($result)): ?>

            <tr>
                        <td>
                        <input type="checkbox" name="<?php echo "selected" . $row["cramID"] ?>"class='checkmark'
                        style='position: relative;'>
                        </td>
                        <!-- ID added here. -->
                        <td id="<?php echo $row["cramID"]."cramID" ?>"><?php echo $row["cramID"] ?></td>
                        <td id="<?php echo $row["cramID"]."customerID" ?>" ><?php echo $row["customerID"] ?></td>
                        <td id="<?php echo $row["cramID"]."cDate" ?>" ><?php echo $row["cDate"] ?></td>
                        <td id="<?php echo $row["cramID"]."cramContent" ?>"><?php echo $row["cramContent"] ?></td>
                        <td id="<?php echo $row["cramID"]."cChecked" ?>"><?php echo $row["cChecked"] ?></td>
                        <td>
                        
                    <input type="submit" value="刪除" name="<?php echo "delete" . $row["cramID"] ?>"
                        class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                    <!--Modal aslo toggled at here.-->
                    <input type='button' value="編輯" name="<?php echo "edit" . $row["cramID"] ?>"
                        class="btn btn-primary mb-3" onclick="throwinmodal_CRAM(<?php echo "'".$row['cramID']."'"?>)">
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

<!-- Modal: Add new-->
<div class="modal fade" id="Modal_add">
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

                    <th>cramID:<input type="text" name='cri'>
                    </th>
                    <hr>
                    <th>customerID: <input type="text" name='cid'></th>
                    <hr>
                    <th>cDate:<input type="date" name='dat'>
                    </th>
                    <hr>
                    <th>cContent: <textarea name="ccn" rows="4" cols="50"></textarea>
                    </th>
                    <hr>
                    <th>cChecked: <select name='ckd'>
                        <option value='Y'>是</option>
                        <option value='N'>否</option>
                    </select></th>
            </tr>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
            <input type="submit" name="modal_submit" value='submit' class="btn btn-primary"></input>
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

                        <th>cramID:<input type="text" name='cri_e' id='cri_e' readonly></a>
                        </th><!-- ID不給改: readonly-->
                        <hr>
                        <th>customerID: <input type="text" name='cid_e' id='cid_e'></th>
                        <hr>
                        <th>cDate:<input type="date" name='dat_e' id='dat_e'>
                        </th>
                        <hr>
                        <th>cContent: <textarea name="ccn_e" id='ccn_e' rows="4" cols="50"></textarea>
                        </th>
                        <hr>
                        <th>cChecked: <select name='ckd_e' id='ckd_e'>
                                <option value='Y'>是</option>
                                <option value='N'>否</option>
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