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

//orderby
if (isset($_POST["disID_ASC"])||isset($_POST["disName_ASC"])||isset($_POST["disDescrip_ASC"])||isset($_POST["producyID_ASC"])||isset($_POST["Discount_ASC"])) {
    $_SESSION["ASCorDESC"] = "ASC";
} else if (isset($_POST["infoID_DESC"])||isset($_POST["infoName_DESC"])||isset($_POST["infoDescrip_DESC"])||isset($_POST["producyID_DESC"])||isset($_POST["Discount_DESC"])) {
    $_SESSION["ASCorDESC"] = "DESC";
} else if(isset($_SESSION["ASCorDESC"])) {
} else {
    $_SESSION["ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["ASCorDESC"] ;


if (isset($_POST["disID_ASC"])||isset($_POST["disID_DESC"])){
    $_SESSION["orderby"]="disID";
} else if (isset($_POST["disName_ASC"])||isset($_POST["disName_DESC"])){
    $_SESSION["orderby"]="disName";
} else if (isset($_POST["disDescrip_ASC"])||isset($_POST["disDescrip_DESC"])){
    $_SESSION["orderby"]="disDescrip";
} else if (isset($_POST["productID_ASC"])||isset($_POST["productID_DESC"])){
  $_SESSION["orderby"]="productID";
} else if (isset($_POST["Discount_ASC"])||isset($_POST["Discount_DESC"])){
  $_SESSION["orderby"]="Discount";
} else if(isset($_SESSION["orderby"])) {
} else {
    $_SESSION["orderby"]="disID";
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
$username=$_SESSION['username'];
$findID=mysqli_query($link,"select sellerID from coffee.sellers WHERE sAccount='$username';");
$userID="";
while ($ID = mysqli_fetch_assoc($findID)){
    $userID = $ID["sellerID"];
}
$total_num_rows = mysqli_num_rows(mysqli_query($link,"select disID from coffee.discounts WHERE sellerID='$userID';"));
$lastPage=floor($total_num_rows/$rowNum)+1;
$tableOffSet = $rowNum * ($page-1);
$showDataStartFrom=$tableOffSet+1;
$showDataEndTo=$tableOffSet+$rowNum;
if($showDataEndTo>$total_num_rows)
{$showDataEndTo=$total_num_rows;};
$previousPage=$page-1;
$nextPage=$page+1;


// right delete btn
foreach ($_POST as $i => $j) {
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $deleteCommandText = <<<SqlQuery
        DELETE FROM coffee.discounts WHERE disID IN ('$deleteItem')
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
  DELETE FROM coffee.discounts WHERE disID IN ($selectedList)
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
                    <span class="mr-5">
                        <!-- show where you are -->
                        <?php 
                        echo "您在第 $page 頁，顯示資料為 $showDataStartFrom - $showDataEndTo 筆(共 $total_num_rows 筆資料)"?>
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

            <table class="table table-striped ">
                <thead class="thead-light">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" onclick="selectAllCheckbox()">
                            <label for="selectAll">全選</label>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0 ">    
                                <p class="m-1">折扣編號</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="disID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="disID_ASC">
                                </div>
                            </div>
                        </th>
                  
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">折扣名稱</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="disName_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="disName_ASC">
                                </div>
                            </div>
                        </th>
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">折扣描述</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="disName_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="disName_ASC">
                                </div>
                            </div>
                        </th>
                        <th>
                        <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">適用產品</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="productID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="productID_ASC">
                                </div>
                            </div>
                        </th>
                        <th>
                        <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">折數</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="Discount_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="Discount_ASC">
                                </div>
                            </div>
                        </th>

                        </th>
                        <th>                        
                </thead>

                <tbody class="data_main_table">

                    <?php
// write table

$commandText = <<<SqlQuery
                    select disID, disName, disDescrip, productID, Discount, sellerID from coffee.discounts where sellerID='$userID' ORDER BY disID $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet
                    SqlQuery;


$result = mysqli_query($link, $commandText);

while ($row = mysqli_fetch_assoc($result)):

?>

                    <tr>
                        <td>
                            <input type="checkbox" name="<?php echo "selected" . $row["disID"] ?>"
                                class="btn btn-danger mb-3">
                        </td>
                        <td><?php echo $row["disID"] ?></td>
                        <td><?php echo $row["disName"] ?></td>
                        <td><?php echo $row["disDescrip"] ?></td>
                        <td><?php echo $row["productID"] ?></td>
                        <td><?php echo $row["Discount"] ?></td>
                        
                        <td class="p-0">
                            <input type="submit" value="刪除" name="<?php echo "delete" . $row["disID"] ?>"
                                class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                            <input type="submit" value="編輯" class="btn btn-primary mb-3">
                        </td>
                    </tr>
                    <?php endwhile?>
                </tbody>

            </table>
        </form>


        <div class="d-flex justify-content-center align-items-center flex-column  m-5">
        <!-- page select -->
        <div class="m-3">
            <a class='m-2 btn btn-info' href='discounts.php?page=1'>第一頁</a>
            <a class='m-2 btn btn-info' href='discounts.php?page=<?php echo ($page<=1)? "1" : $previousPage; ?>'>上一頁</a>
            <a class='m-2 btn btn-info' href='discounts.php?page=<?php echo ($page>=$lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
            <a class='m-2 btn btn-info' href='discounts.php?page=<?php echo $lastPage;     ?>'>最尾頁</a>
        </div>
            <div>
            <?php
            for($i=1 ; $i<=3 && $i<=$lastPage ; $i++ ){
                echo " <a class='m-2' href='discounts.php?page=$i'>$i</a>";
            }
            if($page<=6){
                for($i=4 ; $i<=($page+2)&& $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='discounts.php?page=$i'>$i</a>";
                }               
            }else{
                echo "<span>......</span>";
                for($i=($page-2)  ; $i<=($page+2)&& $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='discounts.php?page=$i'>$i</a>";
                }
            }
            if($lastPage-$page<=5){
                for($i=($page+3) ;  $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='discounts.php?page=$i'>$i</a>";
                }               
            }else{
                echo "<span>......</span>";
                for($i=($lastPage-2)  ; $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='discounts.php?page=$i'>$i</a>";
                }
            }
        
            ?>
            </div>
        </div>

    </div>

    <!-- End your code here. -->
    <?php include '../parts/footer.php';?>

</body>