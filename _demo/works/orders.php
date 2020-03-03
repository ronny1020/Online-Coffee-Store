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

// // get page
// if (isset($_GET["page"])) {
//     $page = $_GET["page"];
// } else {
//     $page = 1;
// }
// //number of rows
// if (isset($_POST["row_num_submit"])) {
//     $_SESSION["member_row_num"] = $_POST["row_num"];
//     header('Location: members.php');
// } else if (isset($_SESSION["member_row_num"])) {
// } else {
// //初始欄數=50
//     $_SESSION["member_row_num"] = 50;
// }
// $rowNum = $_SESSION["member_row_num"];

// //總欄數:
// $total_num_rows = mysqli_num_rows(mysqli_query($link, "select customerID from coffee.customers;"));
// //最後一頁的頁數為:
// $lastPage = floor($total_num_rows / $rowNum) + 1;
// $tableOffSet = $rowNum * ($page - 1);
// $showDataStartFrom = $tableOffSet + 1;
// $showDataEndTo = $tableOffSet + $rowNum;
// if ($showDataEndTo > $total_num_rows) {
//     $showDataEndTo = $total_num_rows;
// }
// ;
// $previousPage = $page - 1;
// $nextPage = $page + 1;

//===== ENDED HERE. =====//

//2 Buttons work here.
foreach ($_POST as $i => $j) {
    //Right delete button:
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = <<<SqlQuery
        DELETE FROM coffee.orders WHERE OrderID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandText);
        header('location:' . $_SERVER['REQUEST_URI'] . '');
    } //Right edit button:
    elseif (substr($i, 0, 4) == "edit") {
        //獲得customerID
        // $editItem = ltrim($i, "edit");
        // $editCommandText = <<<SqlQuery
        // select OrderID, CustomerID, EmployeeID, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, 
        // ShipAddress, ShipRegion, ShipPostCode, ShipCountry, ShipCity   
        // from coffee.orders WHERE CustomerID IN ('$editItem')
        // SqlQuery;
        // $result = mysqli_query($link, $editCommandText);
        // while ($row = mysqli_fetch_assoc($result)) {
        //     $_SESSION["modal_cid"] = $row["customerID"];
        //     $_SESSION["modal_nam"] = $row["cName"];
        //     $_SESSION["modal_acc"] = $row["cAccount"];
        //     $_SESSION["modal_sex"] = $row["cSex"];
        //     $_SESSION["modal_bid"] = $row["cBirthDate"];
        //     $_SESSION["modal_adr"] = $row["cAddress"];
        //     $_SESSION["modal_mob"] = $row["cMobile"];
        // }
        // ;
        // header('location:' . $_SERVER['REQUEST_URI'] . '');
    }
}

//ADD NEW DATA TO FORM! :
//if (isset($_POST['modal_submit'])) {
//    $tmp_cid = $_POST['cid'];
//    $tmp_nam = $_POST['nam'];
//    $tmp_acc = $_POST['acc'];
//    $tmp_pwd = $_POST['pwd'];
//    $tmp_sex = $_POST['sex'];
//    $tmp_bid = $_POST['bid'];
//    $tmp_adr = $_POST['adr'];
//    $tmp_mob = $_POST['mob'];
//    $insertCommandText = <<<SqlQuery;
  
//    insert into coffee.orders (OrderID, CustomerID, RequiredDate, ShippedDate, ShipAddress, ShipRegion, ShipCity, ShipCountry, ShipPostCode  )
//    VALUES ('R100', 'C002' , 1997-02-22 00:00:00, 1997-02-10 00:00:00,  'Albert Street No.113, 4F', 'B region', 'A City', 'U.S.', '104885'  );
    

         
       
           
   
 

   
//    mysqli_query($link, $insertCommandText);
//}

// Write table:
$front_STR1 = "<td>";
$back_STR1 = "</td>";
$front_STR2 = "<td><input type='textbox' value='";
$back_STR2 = "'></td>";
$res_fSTR = $front_STR1;
$res_bSTR = $back_STR1;

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
    DELETE FROM coffee.orders WHERE OrderID IN ($selectedList)
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
<!-- Start your code here. -->
<div class="main p-5">

<form method='post' class="card p-3">
    <div>
        <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')"
            class="btn btn-danger mb-3">
        <!--Modal toggled here.-->
        <input type="button" value="新增資料" name="edit" class="btn btn-primary ml-3 mb-3"
               data-toggle="modal" data-target="#myModal">
                <div class='float-right'>
                    <span class="mr-5">
                    <!-- show where you are -->
                <!--刪除某些東西-->

                </div>

    <table class="table table-striped ">
        <thead class="thead-light">
            <tr>
            <th><input type="checkbox" id="selectAll" onclick="selectAllCheckbox()"><label for="selectAll">全選</label></th>
                <th>OrderID</th>
                <th>CustomerID</th>
                <th>OrderDate</th>
                <th>ShippedDate</th>
                <th>ShipAddress</th>
                <th>ShipRegion</th>
                <th>ShipPostCode</th>
                <th>ShipCity</th>
                <th>ShipCountry</th>





            </tr>
        </thead>
        <tbody>

<?php
// write table
// $commandText: $str
// 受所允許之總欄數調控
$commandText = <<<SqlQuery
select OrderID, CustomerID,  OrderDate, ShippedDate, 
ShipAddress, ShipRegion, ShipPostCode, ShipCity, ShipCountry from coffee.orders 
SqlQuery;

$result = mysqli_query($link, $commandText);
while ($row = mysqli_fetch_assoc($result)): ?>

            <tr>
                <td>
                    <input type="checkbox" name="<?php echo "selected" . $row["customerID"] ?>" class='checkmark'
                        style='position: relative;'>
                </td>
                <?php echo $res_fSTR . $row["OrderID"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["CustomerID"] . $res_bSTR ?>
                
                <?php echo $res_fSTR . $row["OrderDate"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["ShippedDate"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["ShipAddress"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["ShipRegion"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["ShipPostCode"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["ShipCity"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["ShipCountry"] . $res_bSTR ?>

                

                <td>

                    <input type="submit" value="刪除" name="<?php echo "delete" . $row["customerID"] ?>"
                        class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                    <!--Modal aslo toggled at here.-->
                    <input type='button' value="編輯" name="<?php echo "edit" . $row["customerID"] ?>"
                        class="btn btn-primary mb-3">
                </td>
            </tr>
            <?php endwhile?>
        </tbody>
    </table>
</form>
<!--頁尾頁碼&按鈕顯示:-->

<!--頁尾頁碼&按鈕結束-->
</div>
<!-- Modal -->
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
        <!--<div class="modal-body">
            <tr>

                    <th>customerID:<input type="text" name='cid'>
                    </th>
                    <hr>
                    <th>cName: <input type="text" name='nam'></th>
                    <hr>
                    <th>cAccount: <input type="text" name='acc'>
                    </th>
                    <hr>
                    <th>cPassword: <input type="text" name='pwd'>
                    </th>
                    <hr>
                    <th>cSex: <input type="text" name='sex'></th>
                    <hr>
                    <th>cBirthDate:<input type="date" name='bid'>
                    </th>
                    <hr>
                    <th>cAddress: <input type="text" name='adr'>
                    </th>
                    <hr>
                    <th>cMobile: <input type="text" name='mob'></th>
            </tr>
        </div>

        -->

        <!-- Modal footer -->
        <div class="modal-footer">
            <input type="submit" name="modal_submit" value='submit' class="btn btn-primary"></input>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        </form>
    </div>
</div>
</div>
<!-- End your code here. -->
<?php include '../parts/footer.php';?>
</body>