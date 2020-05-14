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





//orderby
// OrderID, CustomerID, OrderDate, ShippedDate, ShipAddress, ShipRegion, ShipPostCode, ShipCity, ShipCountry
// if (isset($_POST["OrderID_ASC"]) || isset($_POST["CustomerID_ASC"]) || isset($_POST["OrderDate_ASC"]) || isset($_POST["ShippedDate_ASC"]) || isset($_POST["ShipAddress_ASC"]) || isset($_POST["ShipRegion_ASC"]|| isset($_POST["ShipPostCode_ASC"]|| isset($_POST["ShipCity_ASC"]|| isset($_POST["ShipCountry_ASC"])) {
//     $_SESSION["OrderID_ASCorDESC"] = "ASC";
// } else if (isset($_POST["OrderID_DESC"]) || isset($_POST["CustomerID_DESC"]) || isset($_POST["OrderDate_DESC"]) || isset($_POST["ShippedDate_DESC"]) || isset($_POST["ShipAddress_DESC"]) || isset($_POST["ShipRegion_DESC"] || isset($_POST["ShipPostCode_DESC"] || isset($_POST["ShipCity_DESC"] || isset($_POST["ShipCountry_DESC"])) {
//     $_SESSION["OrderID_ASCorDESC"] = "DESC";
// } else if (isset($_SESSION["OrderID_ASCorDESC"])) {
// } else {
//     $_SESSION["OrderID_ASCorDESC"] = "ASC";
// }
// $ASCorDESC = $_SESSION["OrderID_ASCorDESC"];

// if (isset($_POST["OrderID_ASC"]) || isset($_POST["OrderID_DESC"])) {
//     $_SESSION["OrderID_orderby"] = "OrderID";
// } else if (isset($_POST["CustomerID_ASC"]) || isset($_POST["CustomerID_DESC"])) {
//     $_SESSION["OrderID_orderby"] = "CustomerID";
// } else if (isset($_POST["OrderDate_ASC"]) || isset($_POST["OrderDate_DESC"])) {
//     $_SESSION["product_orderby"] = "OrderDate";
// } else if (isset($_POST["ShippedDate_ASC"]) || isset($_POST["ShippedDate_DESC"])) {
//     $_SESSION["product_orderby"] = "ShippedDate";
// } else if (isset($_POST["ShipAddress_ASC"]) || isset($_POST["ShipAddress_DESC"])) {
//     $_SESSION["product_orderby"] = "ShipAddress";
// } else if (isset($_POST["ShipRegion_ASC"]) || isset($_POST["ShipRegion_DESC"])) {
//     $_SESSION["product_orderby"] = "ShipRegion"
// } else if (isset($_POST["ShipPostCode_ASC"]) || isset($_POST["ShipPostCode_DESC"])) {
//     $_SESSION["product_orderby"] = "ShipPostCode"
// } else if (isset($_POST["ShipCity_ASC"]) || isset($_POST["ShipCity_DESC"])) {
//     $_SESSION["product_orderby"] = "ShipCity"
// } else if (isset($_POST["ShipCountry_ASC"]) || isset($_POST["ShipCountry_DESC"])) {
//     $_SESSION["product_orderby"] = "ShipCountry"    
 
    
    
    
//     ;
// } else if (isset($_SESSION["product_orderby"])) {
// } else {
//     $_SESSION["product_orderby"] = "OrderID";
// }
// $orderby = $_SESSION["OrderID_orderby"];





//number of rows
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
        $deleteCommandText = "
        DELETE FROM coffee.orders WHERE OrderID IN ('$deleteItem')
        ";
        mysqli_query($link, $deleteCommandText);
        header('location:' . $_SERVER['REQUEST_URI'] . '');
    } 
}

//ADD NEW DATA TO FORM! :
if (isset($_POST['modal_submit'])) {
   $tmp_oid = @$_POST['oid'];
   $tmp_cid = @$_POST['cid'];
   $tmp_OrderD = @$_POST['OrderD'];
   $tmp_ShippedD = @$_POST['ShippedD'];
   $tmp_ShippedA = @$_POST['ShippedA'];
   $tmp_ShipR = @$_POST['ShipR'];
   $tmp_ShipPost = @$_POST['ShipPost'];
   $tmp_ShipCity = @$_POST['ShipCity'];
   $tmp_ShipCountry = @$_POST['ShipCountry'];
   $insertCommandText = "
   insert into coffee.orders VALUES ('$tmp_oid','$tmp_cid','$tmp_OrderD','$tmp_ShippedD','$tmp_ShippedA','$tmp_ShipR','$tmp_ShipPost','$tmp_ShipCity','$tmp_ShipCountry')
   ";      
   mysqli_query($link, $insertCommandText);
}

//EDIT INNER DATA FROM FROM!
//整行砍掉再重丟
if (isset($_POST['modal_submit_e'])) {
    $tmp_oid_e = $_POST['oid_e'];
    $tmp_cid_e = $_POST['cid_e'];
    $tmp_OrderD_e = $_POST['OrderD_e'];
    $tmp_ShippedD_e = $_POST['ShippedD_e'];
    $tmp_ShippedA_e = $_POST['ShippedA_e'];
    $tmp_ShipR_e = $_POST['ShipR_e'];
    $tmp_ShipPost_e = $_POST['ShipPost_e'];
    $tmp_ShipCity_e = $_POST['ShipCity_e'];
    $tmp_ShipCountry_e = $_POST['ShipCountry_e'];


    //刪除舊資料
    $insertCommandText = "
    DELETE FROM coffee.orders WHERE OrderID IN ('$tmp_oid_e');
    ";
    mysqli_query($link, $insertCommandText);

    //插入新資料
    $insertCommandText = "
    insert into coffee.orders VALUES ('$tmp_oid_e','$tmp_cid_e','$tmp_OrderD_e','$tmp_ShippedD_e','$tmp_ShippedA_e','$tmp_ShipR_e','$tmp_ShipPost_e','$tmp_ShipCity_e', '$tmp_ShipCountry_e');
    ";
    mysqli_query($link, $insertCommandText);
}


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
    $deleteSelectedCommandText = "
    DELETE FROM coffee.orders WHERE OrderID IN ($selectedList)
    ";
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

    <!-- I edited these stuffs.      Used in the "Edit modal on the right button..."-->
    <link rel="stylesheet" type="text/css" href="../demostyle.css">
    <script src="../demoutil.js"></script>
    <script src="../orders_need.js"></script>   
    <script src="../throwinmodal_orders_show.js"></script>

</head>

<body>
<?php include '../parts/sidebar.php';?>
<?php include '../parts/head.php';?>
<!-- Start your code here. -->
 <div class="main p-5">
<form class="card p-3 mb-5" method="POST">
<!--            <div class="w-50 mx-auto">
                <label for="searchKeyword">
                    請輸入關鍵字並選擇搜尋欄位1111111：
                </label>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" id="searchKeyword" name="searchKeyword">
                    <select name="searchBy">
                        <option value="OrderID">
                            流水號
                        </option>
                        <option value="CustomerID">
                            流水號(買家)    
                        </option>
                        <option value="OrderDate">
                            下單日期
                        </option>
                        <option value="ShippedDate">
                            運送日期
                        </option>
                        <option value="ShipAddress">
                            運送地址  
                        </option>
                        <option value="ShipRegion">
                            運送區域  
                        </option>
                        <option value="ShipPostCode">
                            運送郵遞區號
                        </option>
                        <option value="ShipCity">
                            運送城市
                        </option>
                        <option value="ShipCountry">
                            運送國家
                        </option>
                    </select>
                </div>
                <button class="btn btn-success mt-3" type="submit" name="startSearch">開始搜尋</button> 
                <button class="btn btn-info mt-3 ml-3" type="submit" name="clearSearch">清除搜尋</button> 
                <p class="mt-3">

                </p>
            </div>
        </form> -->

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
                <th>
                <div style="width: 40px;">
                訂單ID
                </div>
                </th>
                
                <th >
                <div style='width:40px;'>
               顧客ID
                </div>
                </th>
                
                <th >
                <div style='width:100px;'>
                下訂日期
                </div>
                </th>

                <th >
                <div style='width:100px;'>
                運送日期
                </div>
                </th>

                <th >
                <div style='width:100px;'>
                運送地址
                </div>
                </th>

                <th >
                <div style='width:100px;'>
                運送區域
                </div>
                </th>


                <th >
                <div style='width:100px;'>
                運送郵遞區號
                </div>
                </th>
                
                <th >
                <div style='width:80px;'>
                運送城市
                </div>
                </th>


                <th >
                <div style='width:80px;'>
                運送國家
                </div>
                </th>



                <th></th>
                <th style="display:none;">ProductID</th>
                <th style="display:none;">Quantity</th>
                <th style="display:none;">Discount</th>
                
            </tr>
        </thead>
        <tbody>

<?php
// write table
// $commandText: $str
// 受所允許之總欄數調控        這邊還要再 join orders_detail 兩個表的內容...


$commandText = "



SELECT orders.*, orders_detail.* FROM orders 
INNER JOIN orders_detail ON orders.OrderID = orders_detail.orderID order by orders.OrderID

";

$result = mysqli_query($link, $commandText);
while ($row = mysqli_fetch_assoc($result)): ?>

            <tr>
                <td>
                    <input type="checkbox" name="<?php echo "selected" . $row["OrderID"] ?>" class='checkmark'
                        style='position: relative;'>
                </td>
                <td id="<?php echo $row["OrderID"]."OrderID" ?>"><?php echo $row["OrderID"] ?></td>
                <td id="<?php echo $row["OrderID"]."CustomerID" ?>"><?php echo $row["CustomerID"] ?></td>
                <td id="<?php echo $row["OrderID"]."OrderDate" ?>"><?php echo $row["OrderDate"] ?></td>
                <td id="<?php echo $row["OrderID"]."ShippedDate" ?>"><?php echo $row["ShippedDate"] ?></td>
                <td id="<?php echo $row["OrderID"]."ShipAddress" ?>"><?php echo $row["ShipAddress"] ?></td>
                <td id="<?php echo $row["OrderID"]."ShipRegion" ?>"><?php echo $row["ShipRegion"] ?></td>
                <td id="<?php echo $row["OrderID"]."ShipPostCode" ?>"><?php echo $row["ShipPostCode"] ?></td>
                <td id="<?php echo $row["OrderID"]."ShipCity" ?>"><?php echo $row["ShipCity"] ?></td>
                <td id="<?php echo $row["OrderID"]."ShipCountry" ?>"><?php echo $row["ShipCountry"] ?></td>

                
                
                
               
                <td>

                    <input type="submit" value="刪除" name="<?php echo "delete" . $row["OrderID"] ?>"
                        class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                    <!--Modal aslo toggled at here.-->
                    <input type='button' value="編輯" name="<?php echo "edit" . $row["OrderID"] ?>"
                        class="btn btn-primary mb-3" onclick="throwinmodal_orders(<?php echo "'".$row['OrderID']."'"?>)">
            
                    <input type='button' value="訂單細節" name="<?php echo "edit" . $row["OrderID"] ?>"
                        class="btn btn-info mb-3" onclick="throwinmodal_orders_show(<?php echo "'".$row['OrderID']."'"?>)">
            
                </td>

                <td style="display:none;" id="<?php echo $row["OrderID"]."ProductID" ?>"><?php echo $row["productID"] ?></td>
                <td style="display:none;" id="<?php echo $row["OrderID"]."Quantity" ?>"><?php echo $row["Quantity"] ?></td>
                <td style="display:none;" id="<?php echo $row["OrderID"]."Discount" ?>"><?php echo $row["Discount"] ?></td>


            </tr>
            <?php endwhile?>
        </tbody>
    </table>
</form>
<!--頁尾頁碼&按鈕顯示:-->

<!--頁尾頁碼&按鈕結束-->
</div>
<!-- 新增資料用 Modal -->
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

                    <th>OrderID:<input type="text" name='oid'>
                    </th>
                    <hr>
                    <th>CustomerID: <input type="text" name='cid'></th>
                    <hr>
                    <th>OrderDate: <input type="date" name='OrderD'>
                    </th>
                    <hr>
                    <th>ShippedDate: <input type="date" name='ShippedD'>
                    </th>
                    <hr>
                    <th>ShipAddress: <input type="text" name='ShippedA'></th>
                    <hr>
                    <th>ShipRegion:<input type="text" name='ShipR'>
                    </th>
                    <hr>
                    
                    
                    <th>ShipPostCode: <input type="text" name='ShipPost'></th>
                    <hr>
                    <th>ShipCity: <input type="text" name='ShipCity'></th>
                    <hr>
                    <th>ShipCountry: <input type="text" name='ShipCountry'></th>


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
<!-- End your code here. -->






<!--編輯資料用 Modal -->
<div class="modal fade" id="MyEdit">
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

                    <th>OrderID:<input type="text" name='oid_e' id='oid_e' readonly>
                    </th>
                    <hr>
                    <th>CustomerID: <input type="text" name='cid_e'  id='cid_e'></th>
                    <hr>
                    <th>OrderDate: <input type="date" name='OrderD_e'  id='OrderD_e'>
                    </th>
                    <hr>
                    <th>ShippedDate: <input type="date" name='ShippedD_e' id='ShippedD_e'>
                    </th>
                    <hr>
                    <th>ShipAddress: <input type="text" name='ShippedA_e' id='ShippedA_e'></th>
                    <hr>
                    <th>ShipRegion:<input type="text" name='ShipR_e' id='ShipR_e'>
                    </th>
                    <hr>
                    
                    
                    <th>ShipPostCode: <input type="text" name='ShipPost_e'  id='ShipPost_e'></th>
                    <hr>
                    <th>ShipCity: <input type="text" name='ShipCity_e'  id='ShipCity_e'></th>
                    <hr>
                    <th>ShipCountry: <input type="text" name='ShipCountry_e' id='ShipCountry_e'></th>


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
<!-- End your code here. -->






<!--訂單細節用 Modal -->
<div class="modal fade" id="Orders_Detail_Show">
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

                    <th>OrderID:<input type="text" name='oid_d_e' id='oid_d_e' readonly>
                    </th>
                    <hr>
                    <th>ProductID: <input type="text" name='pid_d_e'  id='pid_d_e' readonly></th>         
                    <hr>
                    <th>Quantity: <input type="int" name='Quan_d_e' id='Quan_d_e' readonly></th>
                    <hr>
                    <th>Discount:<input type="float" name='Dis_d_e' id='Dis_d_e' readonly>
                    </th>
                    <hr>
                    
                   


            </tr>
        </div>



        <!-- Modal footer -->
        <div class="modal-footer">
            <!-- <input type="submit" name="modal_submit_e" value='submit' class="btn btn-primary"></input> -->
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
        </form>
    </div>
</div>
</div>
<!-- End your code here. -->











<!--

<script>
 內嵌一段  javascript程式 抓每個欄位中的資料 接著再進行修改  


</script>

原本想把右邊的 編輯按鈕的功能做在這的 但想了想還是另外放在 orders_need.js好惹...

主要是更改以下這段後面的內容XD
// Lightweight version by LEE.(0303)
// 1. 更改table使各欄位附加上id
// 2. onclick button觸發函數讀值進入modal
// 3. submit之後送出update MySql


-->


<?php include '../parts/footer.php';?>
</body>