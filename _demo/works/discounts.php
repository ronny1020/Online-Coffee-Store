<?php
session_start();
error_reporting(0);

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

//orderby
if (isset($_POST["couponID_ASC"]) || isset($_POST["couponName_ASC"]) || isset($_POST["minus_ASC"]) || isset($_POST["limitation_ASC"]) || isset($_POST["cpendDate_ASC"]) || isset($_POST["used_ASC"])) {
    $_SESSION["ASCorDESC"] = "ASC";
} else if (isset($_POST["couponID_DESC"]) || isset($_POST["couponName_ASC"]) || isset($_POST["minus_ASC"]) || isset($_POST["limitation_ASC"]) || isset($_POST["cpendDate_ASC"]) || isset($_POST["used_ASC"])) {
    $_SESSION["ASCorDESC"] = "DESC";
} else if (isset($_SESSION["ASCorDESC"])) {
} else {
    $_SESSION["ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["ASCorDESC"];


if (isset($_POST["couponID_ASC"]) || isset($_POST["couponID_DESC"])) {
    $_SESSION["orderby"] = "couponID";
} else if (isset($_POST["couponName_ASC"]) || isset($_POST["couponName_DESC"])) {
    $_SESSION["orderby"] = "couponName";
} else if (isset($_POST["minus_ASC"]) || isset($_POST["minus_DESC"])) {
    $_SESSION["orderby"] = "minus";
} else if (isset($_POST["limitation_ASC"]) || isset($_POST["limitation_DESC"])) {
    $_SESSION["orderby"] = "limitation";
} else if (isset($_POST["cpendDate_ASC"]) || isset($_POST["cpendDate_DESC"])) {
    $_SESSION["orderby"] = "cpendDate";
} else if (isset($_POST["used_ASC"]) || isset($_POST["used_DESC"])) {
    $_SESSION["orderby"] = "used";
} else if (isset($_SESSION["orderby"])) {
} else {
    $_SESSION["orderby"] = "couponID";
}
$orderby = $_SESSION["orderby"];





//number of rows
if (isset($_POST["row_num_submit"])) {
    $_SESSION["products_row_num"] = $_POST["row_num"];
    header('location:' . $_SERVER['REQUEST_URI'] . '');
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

//important var
$username = $_SESSION['username'];
$findID = mysqli_query($link, "select sellerID from coffee.sellers WHERE sAccount='$username';");
$userID = "";
while ($ID = mysqli_fetch_assoc($findID)) {
    $userID = $ID["sellerID"];
}
$total_num_rows = mysqli_num_rows(mysqli_query($link, "select couponID from coffee.coupon WHERE sellerID='$userID';"));
$total_num_rows = mysqli_num_rows(mysqli_query($link, "select couponID from coffee.coupon ;"));
$lastPage = floor($total_num_rows / $rowNum) + 1;
$tableOffSet = $rowNum * ($page - 1);
$showDataStartFrom = $tableOffSet + 1;
$showDataEndTo = $tableOffSet + $rowNum;
if ($showDataEndTo > $total_num_rows) {
    $showDataEndTo = $total_num_rows;
};
$previousPage = $page - 1;
$nextPage = $page + 1;


// right delete btn
foreach ($_POST as $i => $j) {
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = "
        DELETE FROM coffee.coupon WHERE couponID IN ('$deleteItem')
        ";
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
    $deleteSelectedCommandText = "
  DELETE FROM coffee.coupon WHERE couponID IN ($selectedList)
  ";
    mysqli_query($link, $deleteSelectedCommandText);
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}


if (isset($_POST['modal_submit'])) {
    $tmp_did = $_POST['did'];
    $tmp_nam = $_POST['nam'];
    $tmp_min = $_POST['min'];
    $tmp_lim = $_POST['lim'];
    $tmp_end = $_POST['end'];
    $tmp_ovd = $_POST['ovd'];

    $insertCommandText = "
    insert into coffee.coupon VALUES ('$tmp_did','$tmp_nam','$tmp_min', '$tmp_lim' ,'$tmp_end','$tmp_ovd')
    ";
    mysqli_query($link, $insertCommandText);
}

if (isset($_POST['modal_submit2'])) {
    $tmp_did2 = $_POST['did2'];
    $tmp_nam2 = $_POST['nam2'];
    $tmp_min2 = $_POST['min2'];
    $tmp_lim2 = $_POST['lim2'];
    $tmp_end2 = $_POST['end2'];
    // $tmp_ovd2 = $_POST['ovd2'];


    $sql_query = "UPDATE coupon SET couponName='$tmp_nam2', minus='$tmp_min2', limitation='$tmp_lim2', cpendDate='$tmp_end2' WHERE couponID='$tmp_did2'";
    $stmt = $link->prepare($sql_query);
    $stmt->execute();
    $stmt->close();
    // $link -> close();
}



$query_RecMember = "SELECT * FROM coupon ";
$RecMember = $link->query($query_RecMember);
$row_RecMember = $RecMember->fetch_assoc();


// search function
if (isset($_POST["startSearch"])) {
    if ($_POST["searchKeyword"] != "") {
        $_SESSION["coupon_searchKeyword"] = $_POST["searchKeyword"];
    }
    $_SESSION["coupon_searchBy"] = $_POST["searchBy"];
    header('location:coupon.php');
}

// clear search
if (isset($_POST["clearSearch"])) {
    unset($_SESSION["coupon_searchKeyword"]);
    unset($_SESSION["coupon_searchBy"]);
    header('location:coupon.php');
}
$searchComment = "";

if (isset($_SESSION["coupon_searchKeyword"])) {
    $searchKeyword = $_SESSION["coupon_searchKeyword"];
    if ($_SESSION["coupon_searchBy"] == "couponName") {
        $searchComment = "and couponName like '%$searchKeyword%'";
    } else if ($_SESSION["coupon_searchBy"] == "minus") {
        $searchComment = "and minus like '%$searchKeyword%'";
    } else if ($_SESSION["coupon_searchBy"] == "limitation") {
        $searchComment = "and limitation like '%$searchKeyword%'";
    } else if ($_SESSION["coupon_searchBy"] == "cpendDate") {
        $searchComment = "and cpendDate like '%$searchKeyword%'";
    } else if ($_SESSION["v_searchBy"] == "used") {
        $searchComment = "and used like '%$searchKeyword%'";
    }
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
    $exportComment = "
    select couponID, couponName, minus, limitation, cpendDate, used from coffee.coupon  
    where sellerID='$userID' and couponID IN $selectedList ORDER BY couponID
    ";

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
            $output .= '"' . $row["couponID"] . '",';
            $output .= '"' . $row["couponName"] . '",';
            $output .= '"' . $row["minus"] . '",';
            $output .= '"' . $row["limitation"] . '",';
            $output .= '"' . $row["cpendDate"] . '",';
            $output .= '"' . $row["used"] . '",';

            $output .= "\n";
        }

        $filename = "infomationList" . date('Y-m-d H:i:s') . ".csv";
        header('Content-Encoding: UTF-8');
        header("Content-Type: text/csv; charset=UTF-8");
        header('Content-Disposition: attachment; filename=' . $filename);
        echo "\xEF\xBB\xBF";
        echo $output;
    }
    exit;
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
    <link rel="stylesheet" type="text/css" href="../style2.css">
    <script src="../demoutil.js"></script>
    <script src="../demoutil2.js"></script>
</head>

<body class="bg-color-Paper">
    <?php include '../parts/sidebar.php'; ?>
    <?php include '../parts/head.php'; ?>

    <!-- Start your code here -->
    <div class="main p-5">

        <form class="card p-3 mb-5" method="POST">
            <div class="w-50 mx-auto">
                <label for="searchKeyword">
                    請輸入關鍵字並選擇搜尋欄位：
                </label>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" id="searchKeyword" name="searchKeyword">
                    <select name="searchBy">
                        <option value="couponName">
                            優惠名稱
                        </option>
                        <option value="minus">
                            折扣額
                        </option>
                        <option value="limitation">
                            限制
                        </option>
                        <option value="cpendDate">
                            結束日期
                        </option>
                        <!-- <option value="used">
                            使用
                        </option> -->


                    </select>
                </div>
                <button class="btn btn-success mt-3" type="submit" name="startSearch">開始搜尋</button>
                <button class="btn btn-info mt-3 ml-3" type="submit" name="clearSearch">清除搜尋</button>
                <p class="mt-3">
                    <?php
                    if (isset($_SESSION["coupon_searchKeyword"])) {
                        echo "您正在搜尋：" . $_SESSION["coupon_searchKeyword"];
                    }
                    ?>
                </p>
            </div>
        </form>




        <form method='post' class="card p-3">
            <div>
                <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')" class="btn btn-danger mb-3">
                <input type="button" value="新增資料" name="edit" class="btn btn-primary ml-3 mb-3" data-toggle="modal" data-target="#myModal">
                <!-- <input type="submit" value="匯出勾選" class="btn btn-success ml-3 mb-3" name="exportSelected">
                    <input type="button" value="匯入資料" class="btn btn-info ml-3 mb-3" onclick="importDataUpload()"> -->

                <div class='float-right'>
                    <span class="mr-5">
                        <!-- show where you are -->
                        <?php
                        echo "您在第 $page 頁，顯示資料為 $showDataStartFrom - $showDataEndTo 筆(共 $total_num_rows 筆資料)" ?>
                    </span>
                    <label for="row_num_select">請選擇顯示行數:</label>
                    <select id="row_num_select" name="row_num">
                        <option value="10" <?php if ($rowNum == 10) {
                                                echo "selected";
                                            } ?>>10 </option>
                        <option value="20" <?php if ($rowNum == 20) {
                                                echo "selected";
                                            } ?>>20 </option>
                        <option value="50" <?php if ($rowNum == 50) {
                                                echo "selected";
                                            } ?>>50 </option>
                        <option value="100" <?php if ($rowNum == 100) {
                                                echo "selected";
                                            } ?>>100</option>
                    </select>
                    <input type="submit" value="確定" name="row_num_submit" class="btn btn-primary ml-3 mb-3">
                    </span>
                </div>

                <table class="table table-striped table-bordered data_main_table">
                    <thead class="bg-color-gold">
                        <tr>
                            <th>
                                <div class="d-flex justify-content-center align-items-center flex-row m-0 " style='width: 100px;'>
                                    <input type="checkbox" id="selectAll" onclick="selectAllCheckbox()" class='checkmark' style='position: relative;'>
                                    <label for="selectAll">全選</label>
                                </div>
                            </th>

                            <th>
                                <div align="center">
                                    <div class="d-flex justify-content-center align-items-center flex-row m-0 " style='width: 100px;'>
                                        <p class="m-1">優惠編號</p>
                                        <div class="DESC-ASC ml-2">
                                            <input type="submit" class="d-block btn btn-DESC" value="▲" name="couponID_DESC">
                                            <input type="submit" class="d-block btn btn-ASC" value="▼" name="couponID_ASC">
                                        </div>
                                    </div>
                                </div>
                            </th>

                            <th>
                                <div align="center">
                                    <div class="d-flex justify-content-center align-items-center flex-row m-0" style='width: 100px;'>
                                        <p class="m-1">優惠名稱</p>
                                        <div class="DESC-ASC ml-2">
                                            <input type="submit" class="d-block btn btn-DESC" value="" name="couponName_DESC">
                                            <input type="submit" class="d-block btn btn-ASC" value="" name="couponName_ASC">
                                        </div>
                                    </div>
                                </div>
                            </th>
                            <th>
                                <div align="center">
                                    <div class="d-flex justify-content-center align-items-center flex-row m-0" style='width: 100px;'>
                                        <p class="m-1">折扣額</p>
                                        <div class="DESC-ASC ml-2">
                                            <input type="submit" class="d-block btn btn-DESC" value="" name="minus_DESC">
                                            <input type="submit" class="d-block btn btn-ASC" value="" name="minus_ASC">
                                        </div>
                                    </div>
                                </div>
                            </th>

                            <th>
                                <div align="center">
                                    <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                        <p class="m-1">限制</p>
                                        <div class="DESC-ASC ml-2">
                                            <input type="submit" class="d-block btn btn-DESC" value="▲" name="limitation_DESC">
                                            <input type="submit" class="d-block btn btn-ASC" value="▼" name="limitation_ASC">
                                        </div>
                                    </div>
                                </div>
                            </th>

                            <th>
                                <div align="center">
                                    <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                        <p class="m-1">結束日期</p>
                                        <div class="DESC-ASC ml-2">
                                            <input type="submit" class="d-block btn btn-DESC" value="▲" name="cpendDate_DESC">
                                            <input type="submit" class="d-block btn btn-ASC" value="▼" name="cpendDate_ASC">
                                        </div>
                                    </div>
                                </div>
                            </th>

                            <!-- <th>
                                <div align="center">
                                    <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                        <p class="m-1">使用</p>
                                        <div class="DESC-ASC ml-2">
                                            <input type="submit" class="d-block btn btn-DESC" value="▲" name="used_DESC">
                                            <input type="submit" class="d-block btn btn-ASC" value="▼" name="used_ASC">
                                        </div>
                                    </div>
                                </div>
                            </th> -->

                            </th>
                            <th>
                    </thead>

                    <tbody class="data_main_table">

                        <?php
                        // write table

                        $commandText = "
                    select couponID, couponName, minus, limitation, cpendDate, used from coffee.coupon $searchComment ORDER BY couponID $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet
                    ";


                        $result = mysqli_query($link, $commandText);

                        while ($row = mysqli_fetch_assoc($result)) :

                        ?>

                            <tr class="dataSQL" align="center">
                                <td>
                                    <input type="checkbox" name="<?php echo "selected" . $row["couponID"] ?>" class='checkmark' style='position: relative;'>
                                </td>
                                <td id="<?php echo $row["couponID"] . "couponID" ?>"><?php echo $row["couponID"] ?></td>
                                <td id="<?php echo $row["couponID"] . "couponName" ?>"><?php echo $row["couponName"] ?></td>
                                <td id="<?php echo $row["couponID"] . "minus" ?>"><?php echo $row["minus"] ?></td>
                                <td id="<?php echo $row["couponID"] . "limitation" ?>"><?php echo $row["limitation"] ?></td>
                                <td id="<?php echo $row["couponID"] . "cpendDate" ?>"><?php echo $row["cpendDate"] ?></td>
                                <!-- <td id="<?php echo $row["couponID"] . "used" ?>"><?php echo $row["used"] ?></td> -->








                                <td class="p-0">
                                    <div class="right_btn" align="center">
                                        <input type="submit" value="刪除" name="<?php echo "delete" . $row["couponID"] ?>" class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">

                                        <input type='button' value="編輯" name="<?php echo "edit" . $row["couponID"] ?>" class="btn btn-primary mb-3" onclick="throwinmodal_ABC(<?php echo "'" . $row['couponID'] . "'" ?>)">
                                    </div>
                                </td>
                            </tr>
                        <?php endwhile ?>
                    </tbody>

                </table>
        </form>


        <div class="d-flex justify-content-center align-items-center flex-column  m-5">
            <!-- page select -->
            <div class="m-3">
                <a class='m-2 btn btn-info' href='coupon.php?page=1'>第一頁</a>
                <a class='m-2 btn btn-info' href='coupon.php?page=<?php echo ($page <= 1) ? "1" : $previousPage; ?>'>上一頁</a>
                <a class='m-2 btn btn-info' href='coupon.php?page=<?php echo ($page >= $lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
                <a class='m-2 btn btn-info' href='coupon.php?page=<?php echo $lastPage;     ?>'>最尾頁</a>
            </div>
            <div>
                <?php
                for ($i = 1; $i <= 3 && $i <= $lastPage; $i++) {
                    echo " <a class='m-2' href='coupon.php?page=$i'>$i</a>";
                }
                if ($page <= 6) {
                    for ($i = 4; $i <= ($page + 2) && $i <= $lastPage; $i++) {
                        echo " <a class='m-2' href='coupon.php?page=$i'>$i</a>";
                    }
                } else {
                    echo "<span>......</span>";
                    for ($i = ($page - 2); $i <= ($page + 2) && $i <= $lastPage; $i++) {
                        echo " <a class='m-2' href='coupon.php?page=$i'>$i</a>";
                    }
                }
                if ($lastPage - $page <= 5) {
                    for ($i = ($page + 3); $i <= $lastPage; $i++) {
                        echo " <a class='m-2' href='coupon.php?page=$i'>$i</a>";
                    }
                } else {
                    echo "<span>......</span>";
                    for ($i = ($lastPage - 2); $i <= $lastPage; $i++) {
                        echo " <a class='m-2' href='coupon.php?page=$i'>$i</a>";
                    }
                }

                ?>
            </div>


            <iframe name="thisframe"></iframe>
            <!-- Modal -->
            <div class="modal fade" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">新增資料:</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <form method="post" action=''>
                            <!-- Modal body -->
                            <div class="modal-body">
                                <tr>

                                    <th>優惠編號:<input type="text" name='did'>
                                    </th>
                                    <hr>
                                    <th>優惠名稱: <input type="text" name='nam'></th>
                                    <hr>

                                    <th>折扣額:<input type="text" name='dct'>
                                    </th>
                                    <hr>
                                    <th>限制:<input type="text" name='std'>
                                    </th>
                                    <hr>
                                    <th>結束日期:<input type="date" name='ovd'>
                                    </th>
                                    <hr>
                                    <th>使用: <textarea type="text" name='ddp' rows="4" cols="50"></textarea>
                                    </th>
                                    <hr>

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

            <iframe name="thisframe2"></iframe>
            <!-- Modal -->
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

                                    <th>優惠編號:<input type="text" name='did2' id='did2' readonly>
                                    </th>
                                    <hr>
                                    <th>優惠名稱: <input type="text" name='nam2' id='nam2'></th>
                                    <hr>

                                    <th>折扣額:<input type="text" name='min2' id='min2'>
                                    </th>
                                    <hr>
                                    <th>限制:<input type="text" name='lim2' id='lim2'>
                                    </th>
                                    <hr>
                                    <th>結束日期:<input type="date" name='end2' id='end2'>
                                    </th>
                                    <hr>
                                    <!-- <th>使用: <textarea type="text" name='ovd2' id='ovd2' rows="4" cols="50"></textarea>
                                    </th>
                                    <hr> -->

                                </tr>
                            </div>
                            <!-- Modal footer -->
                            <div class="modal-footer">
                                <input type="submit" name="modal_submit2" value='submit' class="btn btn-primary"></input>
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>




        </div>

    </div>
    </div>


    <div id="popUp_window" class="window_close">
        <div id="popUp_bg" onclick="popUp_close()">
        </div>


    </div>
    <!-- End your code here. -->
    <?php include '../parts/footer.php'; ?>

</body>