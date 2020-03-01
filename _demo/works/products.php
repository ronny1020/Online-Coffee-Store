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
// productID, ProductName, categoryName, UnitPrice, UnitsInStock, add_time
if (isset($_POST["productID_ASC"])||isset($_POST["ProductName_ASC"])||isset($_POST["categoryName_ASC"])||isset($_POST["UnitPrice_ASC"])||isset($_POST["UnitsInStock_ASC"])||isset($_POST["add_time_ASC"])) {
    $_SESSION["ASCorDESC"] = "ASC";
} else if (isset($_POST["productID_DESC"])||isset($_POST["ProductName_DESC"])||isset($_POST["categoryName_DESC"])||isset($_POST["UnitPrice_DESC"])||isset($_POST["UnitsInStock_DESC"])||isset($_POST["add_time_DESC"])) {
    $_SESSION["ASCorDESC"] = "DESC";
} else if(isset($_SESSION["ASCorDESC"])) {
} else {
    $_SESSION["ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["ASCorDESC"] ;


if (isset($_POST["productID_ASC"])||isset($_POST["productID_DESC"])){
    $_SESSION["orderby"]="productID";
} else if (isset($_POST["ProductName_ASC"])||isset($_POST["ProductName_DESC"])){
    $_SESSION["orderby"]="ProductName";
} else if (isset($_POST["categoryName_ASC"])||isset($_POST["categoryName_DESC"])){
    $_SESSION["orderby"]="categoryName";
} else if (isset($_POST["UnitPrice_ASC"])||isset($_POST["UnitPrice_DESC"])){
    $_SESSION["orderby"]="UnitPrice";
} else if (isset($_POST["UnitsInStock_ASC"])||isset($_POST["UnitsInStock_DESC"])){
    $_SESSION["orderby"]="UnitsInStock";
} else if (isset($_POST["add_time_ASC"])||isset($_POST["add_time_DESC"])){
    $_SESSION["orderby"]="add_time";
} else if(isset($_SESSION["orderby"])) {
} else {
    $_SESSION["orderby"]="productID";
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
$ID = mysqli_fetch_assoc($findID);
$userID = $ID["sellerID"];

$total_num_rows = mysqli_num_rows(mysqli_query($link,"select productID from coffee.products WHERE sellerID='$userID';"));
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
        DELETE FROM coffee.products WHERE productID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandText);
        $deleteCommandTextTagMap = <<<SqlQuery
        DELETE FROM coffee.products_tags WHERE productID IN ('$deleteItem')
        SqlQuery;
        mysqli_query($link, $deleteCommandTextTagMap);

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
    $deleteSelectedCommandText = "DELETE FROM coffee.products WHERE productID IN ($selectedList);";
    mysqli_query($link, $deleteSelectedCommandText);
    $deleteSelectedCommandTextTagMap = "DELETE FROM coffee.products_tags WHERE productID IN ($selectedList);";
    mysqli_query($link, $deleteSelectedCommandTextTagMap);
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

<body class="bg-color-Paper">
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

            <table class="table table-striped data_main_table">
                <thead class="bg-color-gold">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" onclick="selectAllCheckbox()" class='checkmark' style='position: relative;'>
                            <label for="selectAll">全選</label>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0 ">    
                                <p class="m-1">productID</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="productID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="productID_ASC">
                                </div>
                            </div>
                        </th>
                  
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">ProductName</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="ProductName_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="ProductName_ASC">
                                </div>
                            </div>
                        </th>
                        
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">categoryName</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="categoryName_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="categoryName_ASC">
                                </div>
                            </div>
                      
                        </th>
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">UnitPrice</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="UnitPrice_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="UnitPrice_ASC">
                                </div>
                            </div>
                        </th>
                        <!-- here -->
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">UnitsInStock</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="UnitsInStock_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="UnitsInStock_ASC">
                                </div>
                            </div>
                        </th>
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">    
                                <p class="m-1">add_time</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="add_time_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="add_time_ASC">
                                </div>
                            </div>
                        </th>
                        <th class=tags>tags                            
                        </th> 
                        <th>                            
                        </th>                       
                </thead>

                <tbody>

                    <?php
// write table

$commandText = "select productID, ProductName, sellerID, categoryName, UnitPrice, UnitsInStock, add_time, specification, products.description
from coffee.products JOIN coffee.category ON coffee.category.CategoryID=coffee.products.CategoryID 
where sellerID='$userID' ORDER BY $orderby $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet;";
   
$result = mysqli_query($link, $commandText);


$rowList=array();
$i=0;
while ($row = mysqli_fetch_assoc($result)) {
    $rowList[$i]=$row;
    $i++;
}

foreach( $rowList as $row ){


?>

                    <tr>
                        <td>
                            <input type="checkbox" name="<?php echo "selected" . $row["productID"] ?>"class='checkmark'
                        style='position: relative;'>
                        </td>
                        <td class="num"><?php echo $row["productID"] ?></td>
                        <td><?php echo $row["ProductName"] ?></td>
                        <td><?php echo $row["categoryName"] ?></td>
                        <td class="num"><?php echo number_format($row["UnitPrice"]) ?></td>
                        <td class="num"><?php echo number_format($row["UnitsInStock"]) ?></td>
                        <td><?php echo $row["add_time"] ?></td>
                        <td><?php 
                        
                        $productIDForTags=$row["productID"];
                        $tagCommandText = "SELECT tagName FROM coffee.products_tagMap
                        JOIN coffee.products ON coffee.products.productID=coffee.products_tagMap.productID
                        JOIN coffee.products_tags ON coffee.products_tags.tagID=coffee.products_tagMap.tagID
                        WHERE coffee.products.productID = $productIDForTags;";
                        
                        $result = mysqli_query($link, $tagCommandText);
                        while ($rowJ = mysqli_fetch_assoc($result)){ ?>
                        
                        
                        <span class="tags"><?php echo  "#".$rowJ["tagName"] ?></span>
                        
                        
                        <?php }  ?>
                        
                        
                        </td>
                        <td>
                            <div class="right_btn">
                            <input type="submit" value="刪除" name="<?php echo "delete" . $row["productID"] ?>"
                                class="btn btn-danger my-0 btn-md" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                            <input type="submit" value="編輯" class="btn btn-primary my-0 btn-md">
                            </div>
                            
                        </td>
                    </tr>
                        <?php }?>
                </tbody>

            </table>
        </form>


        <div class="d-flex justify-content-center align-items-center flex-column  m-5">
        <!-- page select -->
        <div class="m-3">
            <a class='m-2 btn bg-color-gold' href='products.php?page=1'>第一頁</a>
            <a class='m-2 btn bg-color-gold' href='products.php?page=<?php echo ($page<=1)? "1" : $previousPage; ?>'>上一頁</a>
            <a class='m-2 btn bg-color-gold' href='products.php?page=<?php echo ($page>=$lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
            <a class='m-2 btn bg-color-gold' href='products.php?page=<?php echo $lastPage;     ?>'>最尾頁</a>
        </div>
            <div>
            <?php
            for($i=1 ; $i<=3 && $i<=$lastPage ; $i++ ){
                echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
            }
            if($page<=6){
                for($i=4 ; $i<=($page+2)&& $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
                }               
            }else{
                echo "<span>......</span>";
                for($i=($page-2)  ; $i<=($page+2)&& $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
                }
            }
            if($lastPage-$page<=5){
                for($i=($page+3) ;  $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
                }               
            }else{
                echo "<span>......</span>";
                for($i=($lastPage-2)  ; $i<=$lastPage ; $i++ ){
                    echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
                }
            }
        
            ?>
            </div>
        </div>

    </div>
</div>
    <!-- End your code here. -->
    <?php include '../parts/footer.php';?>

</body>