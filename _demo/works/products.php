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
if (isset($_POST["productID_ASC"]) || isset($_POST["ProductName_ASC"]) || isset($_POST["categoryName_ASC"]) || isset($_POST["UnitPrice_ASC"]) || isset($_POST["UnitsInStock_ASC"]) || isset($_POST["add_time_ASC"])) {
    $_SESSION["ASCorDESC"] = "ASC";
} else if (isset($_POST["productID_DESC"]) || isset($_POST["ProductName_DESC"]) || isset($_POST["categoryName_DESC"]) || isset($_POST["UnitPrice_DESC"]) || isset($_POST["UnitsInStock_DESC"]) || isset($_POST["add_time_DESC"])) {
    $_SESSION["ASCorDESC"] = "DESC";
} else if (isset($_SESSION["ASCorDESC"])) {
} else {
    $_SESSION["ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["ASCorDESC"];

if (isset($_POST["productID_ASC"]) || isset($_POST["productID_DESC"])) {
    $_SESSION["orderby"] = "productID";
} else if (isset($_POST["ProductName_ASC"]) || isset($_POST["ProductName_DESC"])) {
    $_SESSION["orderby"] = "ProductName";
} else if (isset($_POST["categoryName_ASC"]) || isset($_POST["categoryName_DESC"])) {
    $_SESSION["orderby"] = "categoryName";
} else if (isset($_POST["UnitPrice_ASC"]) || isset($_POST["UnitPrice_DESC"])) {
    $_SESSION["orderby"] = "UnitPrice";
} else if (isset($_POST["UnitsInStock_ASC"]) || isset($_POST["UnitsInStock_DESC"])) {
    $_SESSION["orderby"] = "UnitsInStock";
} else if (isset($_POST["add_time_ASC"]) || isset($_POST["add_time_DESC"])) {
    $_SESSION["orderby"] = "add_time";
} else if (isset($_SESSION["orderby"])) {
} else {
    $_SESSION["orderby"] = "productID";
}
$orderby = $_SESSION["orderby"];

//number of rows
if (isset($_POST["row_num_submit"])) {
    $_SESSION["products_row_num"] = $_POST["row_num"];
    header('location:products.php');
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



// search function
if (isset($_POST["startSearch"])) {
    if($_POST["searchKeyword"]!=""){
        $_SESSION["searchKeyword"] = $_POST["searchKeyword"];
    }
    $_SESSION["searchBy"] = $_POST["searchBy"];
    header('location:products.php');
}

// clear search
if (isset($_POST["clearSearch"])) {
    unset($_SESSION["searchKeyword"]);
    unset($_SESSION["searchBy"]);
    header('location:products.php');
}
$searchComment="";

if(isset($_SESSION["searchKeyword"])) {
    $searchKeyword=$_SESSION["searchKeyword"];
    if($_SESSION["searchBy"]=="productName"){
        $searchComment="and productName like '%$searchKeyword%'";
    }else if($_SESSION["searchBy"]=="specification"){
        $searchComment="and specification like '%$searchKeyword%'";
    }else if($_SESSION["searchBy"]=="description"){
        $searchComment="and description like '%$searchKeyword%'";
    }
    else{
        // get tagID
        $searchTagComment="select tagID from coffee.products_tags WHERE tagName like '%$searchKeyword%';";
        $searchTagResult= mysqli_query($link, $searchTagComment);
        $tagIDList="('";
        while ($tagRow = mysqli_fetch_assoc($searchTagResult)) {
            $tagID=$tagRow['tagID'];
            $tagIDList=$tagIDList.$tagID."','";
        }
        $tagIDList=$tagIDList."')";
        // get productsID
        $searchProductIDComment="select ProductID from coffee.products_tagMap WHERE tagID in $tagIDList;";
        $searchProductIDResult= mysqli_query($link, $searchProductIDComment);
        $productIDList="('";
        while ($productRow = mysqli_fetch_assoc($searchProductIDResult)) {
            $productID=$productRow['ProductID'];
            $productIDList=$productIDList.$productID."','";
        }
        $productIDList=$productIDList."')";
        $searchComment="and productID in $productIDList";
    }
}

//important var
$username = $_SESSION['username'];
$findID = mysqli_query($link, "select sellerID from coffee.sellers WHERE sAccount='$username';");
$ID = mysqli_fetch_assoc($findID);
$userID = $ID["sellerID"];

$total_num_rows = mysqli_num_rows(mysqli_query($link, "select productID from coffee.products WHERE sellerID='$userID' $searchComment;"));
$lastPage = ceil($total_num_rows / $rowNum);
$tableOffSet = $rowNum * ($page - 1);
$showDataStartFrom = $tableOffSet + 1;
$showDataEndTo = $tableOffSet + $rowNum;
if ($showDataEndTo > $total_num_rows) {$showDataEndTo = $total_num_rows;}
;
if($showDataStartFrom>$showDataEndTo){
    $showDataStartFrom=$showDataEndTo;
}
$previousPage = $page - 1;
$nextPage = $page + 1;


// right delete btn
foreach ($_POST as $i => $j) {
    if (substr($i, 0, 6) == "delete") {
        $deleteItem = ltrim($i, "delete");
        $findDeletedTags="select tagID from coffee.products_tagmap WHERE productID ='$deleteItem';";
        $DeletedTags=mysqli_query($link, $findDeletedTags);
        $k=0;
        while ($tagRow = mysqli_fetch_assoc($DeletedTags)) {
            $tagList[$k] = $tagRow;
            $k++;
        }
        foreach ($tagList as $tagRow) {
            $DeletedTagID=$tagRow["tagID"];
            $checkDeletedTagsComment="select tagID from coffee.products_tagmap WHERE tagID ='$DeletedTagID';";
            $checkDeletedTags=mysqli_query($link, $checkDeletedTagsComment);
            if(mysqli_num_rows($checkDeletedTags)==1){
                $deletedTagID=mysqli_fetch_assoc($checkDeletedTags)["tagID"];
                $DeletedTagComment = "DELETE FROM coffee.products_tags WHERE tagID ='$deletedTagID';";
                echo $DeletedTagComment;
                mysqli_query($link, $DeletedTagComment);
            }
        }
        $deleteCommandTextTagMap = "DELETE FROM coffee.products_tagMap WHERE productID IN ('$deleteItem');";
        mysqli_query($link, $deleteCommandTextTagMap);
        $deleteCommandText = "DELETE FROM coffee.products WHERE productID IN ('$deleteItem');";
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
            $findDeletedTags="select tagID from coffee.products_tagmap WHERE productID ='$selectedItem';";
            $DeletedTags=mysqli_query($link, $findDeletedTags);
            $k=0;
            while ($tagRow = mysqli_fetch_assoc($DeletedTags)) {
                $tagList[$k] = $tagRow;
                $k++;
            }
            foreach ($tagList as $tagRow) {
                $DeletedTagID=$tagRow["tagID"];
                $checkDeletedTagsComment="select tagID from coffee.products_tagmap WHERE tagID ='$DeletedTagID';";
                $checkDeletedTags=mysqli_query($link, $checkDeletedTagsComment);
                if(mysqli_num_rows($checkDeletedTags)==1){
                    $deletedTagID=mysqli_fetch_assoc($checkDeletedTags)["tagID"];
                    $DeletedTagComment = "DELETE FROM coffee.products_tags WHERE tagID ='$deletedTagID';";
                    echo $DeletedTagComment;
                    mysqli_query($link, $DeletedTagComment);
                }
            }
            $deleteCommandTextTagMap = "DELETE FROM coffee.products_tagMap WHERE productID IN ('$selectedItem');";
            mysqli_query($link, $deleteCommandTextTagMap);
            $deleteCommandText = "DELETE FROM coffee.products WHERE productID IN ('$selectedItem');";
            mysqli_query($link, $deleteCommandText);
            header('location:' . $_SERVER['REQUEST_URI'] . '');
        }
    }
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}


// create data from button
if (isset($_POST["create_data"])) {
    $ProductName_input = $_POST["ProductName_input"];
    $categoryID_select = $_POST["categoryName_select"];
    $UnitPrice_input = $_POST["UnitPrice_input"];
    $UnitsInStock_input = $_POST["UnitsInStock_input"];
    $add_time_now = date("Y-m-d H:i:s", time());
    $specification_input = $_POST["specification_input"];
    $description_input = $_POST["description_input"];

    $input_comment = "INSERT INTO coffee.products (`ProductName`, `sellerID`, `CategoryID`, `UnitPrice`,`UnitsInStock`, `add_time`, `specification`, `description`)  
    VALUES  ('$ProductName_input','$userID',$categoryID_select,$UnitPrice_input,$UnitsInStock_input,'$add_time_now','$specification_input','$description_input');";
    mysqli_query($link, $input_comment );

    $productID_input=mysqli_insert_id($link);
    $productID_input= str_repeat("0",10-(strlen($productID_input))).$productID_input;
    mysqli_error($link);

    foreach ($_POST as $i => $j) {
        if (substr($i, 0, 6) == "newTag" && $j !="" ) {
            $newTag=$j;
            $findTagID = mysqli_query($link, "select tagID from coffee.products_tags WHERE tagName ='$newTag';");
            if(mysqli_num_rows($findTagID)==0){
                mysqli_query($link, "INSERT INTO coffee.products_tags (tagName) VALUES ('$newTag');");
                $newTagID=mysqli_insert_id($link);
            }else{
            $newTagID= mysqli_fetch_assoc($findTagID)["tagID"];
            }

            mysqli_query($link, "INSERT INTO coffee.products_tagMap (productID, tagID) VALUES ($productID_input,$newTagID);");
            }
    }
    header('location:' . $_SERVER['REQUEST_URI'] . '');
}

if (isset($_POST["edit_data"])) {
    $productID_input = $_POST["ProductID_input"];
    $ProductName_input = $_POST["ProductName_input"];
    $categoryID_select = $_POST["categoryName_select"];
    $UnitPrice_input = $_POST["UnitPrice_input"];
    $UnitsInStock_input = $_POST["UnitsInStock_input"];
    $specification_input = $_POST["specification_input"];
    $description_input = $_POST["description_input"];


    $input_comment = "UPDATE `coffee`.`products` SET 
    `ProductName` = '$ProductName_input', 
    `CategoryID` = '$categoryID_select',
    `UnitPrice` = $UnitPrice_input, 
    `UnitsInStock` = $UnitsInStock_input,
    `specification` = '$specification_input',
    `description` = '$description_input'
    WHERE `productID` = $productID_input;";
    
    mysqli_query($link, $input_comment);

    mysqli_error($link);

    // tags delete or create
    foreach ($_POST as $i => $j) {
    // delete tags
        if (substr($i, 0, 1) == "#") {
        $deletedTag=ltrim($i, "#");;
        $findDeletedTagID = mysqli_query($link, "select tagID from coffee.products_tags WHERE tagName ='$deletedTag';");
        $deletedTagID=mysqli_fetch_assoc($findDeletedTagID)["tagID"];
        $findDeletedTagMapID = mysqli_query($link, "select tagID from coffee.products_tagMap WHERE tagID ='$deletedTagID';");
        if(mysqli_num_rows($findDeletedTagMapID)==1){
            $DeletedTagMapIDComment = "DELETE FROM coffee.products_tagMap WHERE tagID ='$deletedTagID';";
            mysqli_query($link, $DeletedTagMapIDComment);
        }
        $DeletedTagIDComment = "DELETE FROM coffee.products_tags WHERE tagID ='$deletedTagID';";
        mysqli_query($link, $DeletedTagIDComment);

        }
    // create tags
        if (substr($i, 0, 6) == "newTag" && $j !="" ) {
        $newTag=$j;
        $findTagID = mysqli_query($link, "select tagID from coffee.products_tags WHERE tagName ='$newTag';");
        if(mysqli_num_rows($findTagID)==0){
            mysqli_query($link, "INSERT INTO coffee.products_tags (tagName) VALUES ('$newTag');");
            $newTagID=mysqli_insert_id($link);
        }else{
        $newTagID= mysqli_fetch_assoc($findTagID)["tagID"];
        }

        mysqli_query($link, "INSERT INTO coffee.products_tagMap (productID, tagID) VALUES ($productID_input,$newTagID);");
        }
    }
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
        <form class="card p-3 mb-5" method="POST">
            <div class="w-50 mx-auto">
                <label for="searchKeyword">
                    請輸入關鍵字並選擇搜尋欄位：
                </label>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search" id="searchKeyword" name="searchKeyword">
                    <select name="searchBy">
                        <option value="productName">
                            產品名稱
                        </option>
                        <option value="specification">
                            規格    
                        </option>
                        <option value="description">
                            介紹
                        </option>
                        <option value="tagName">
                            TAG
                        </option>
                    </select>
                </div>
                <button class="btn btn-success mt-3" type="submit" name="startSearch">開始搜尋</button> 
                <button class="btn btn-info mt-3 ml-3" type="submit" name="clearSearch">清除搜尋</button> 
                <p class="mt-3">
                    <?php 
                    if(isset($_SESSION["searchKeyword"])){
                        echo "您正在搜尋：".$_SESSION["searchKeyword"];
                    }                    
                     ?>
                </p>
            </div>
        </form>

        <form method='post' class="card p-3">
            <div>
                <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')" class="btn btn-danger mb-3">
                <input type="button" value="新增資料" class="btn btn-primary ml-3 mb-3" onclick="create_edit()">

                <div class='float-right'>
                    <span class="mr-5">
                        <!-- show where you are -->
                        <?php
echo "您在第 $page 頁，顯示資料為 $showDataStartFrom - $showDataEndTo 筆(共 $total_num_rows 筆資料)" ?>
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

            <table class="table table-striped table-bordered data_main_table">
                <thead class="bg-color-gold">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" onclick="selectAllCheckbox()" class='checkmark' style='position: relative;'>
                            <label for="selectAll">全選</label>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0 ">
                                <p class="m-1">產品ID</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="productID_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="productID_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">產品名稱</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="ProductName_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="ProductName_ASC">
                                </div>
                            </div>
                        </th>

                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">產品類型</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="categoryName_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="categoryName_ASC">
                                </div>
                            </div>

                        </th>
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">單價</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="UnitPrice_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="UnitPrice_ASC">
                                </div>
                            </div>
                        </th>
                        <!-- here -->
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">庫存量</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="UnitsInStock_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="UnitsInStock_ASC">
                                </div>
                            </div>
                        </th>
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">新增時間</p>
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
                    where sellerID='$userID' $searchComment ORDER BY $orderby $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet;";

                    $result = mysqli_query($link, $commandText);
                    $result_exist = mysqli_num_rows($result)>0;

                    if($result_exist){
                    $rowList = array();
                    $i = 0;
                    while ($row = mysqli_fetch_assoc($result)) {
                        $rowList[$i] = $row;
                        $i++;
                    }

                    foreach ($rowList as $row) {

                        ?>

                    <tr class="dataSQL">
                        <td>
                            <input type="checkbox" name="<?php echo "selected" . $row["productID"] ?>"class='checkmark'
                        style='position: relative;'>
                        </td>
                        <td id="<?php echo $row["productID"] . "productID" ?>" class="num"><?php echo $row["productID"] ?></td>
                        <td id="<?php echo $row["productID"] . "ProductName" ?>" ><?php echo $row["ProductName"] ?></td>
                        <td id="<?php echo $row["productID"] . "categoryName" ?>" ><?php echo $row["categoryName"] ?></td>
                        <td id="<?php echo $row["productID"] . "UnitPrice" ?>"  class="num"><?php echo number_format($row["UnitPrice"]) ?></td>
                        <td id="<?php echo $row["productID"] . "UnitsInStock" ?>"  class="num"><?php echo number_format($row["UnitsInStock"]) ?></td>
                        <td id="<?php echo $row["productID"] . "add_time" ?>" ><?php echo $row["add_time"] ?></td>
                        <td class="hide" id="<?php echo $row["productID"] . "specification" ?>" ><?php echo $row["specification"] ?></td>
                        <td class="hide" id="<?php echo $row["productID"] . "description" ?>" ><?php echo $row["description"] ?></td>
                        <td><?php

                        $productIDForTags = $row["productID"];
                        $tagCommandText = "SELECT tagName FROM coffee.products_tagMap
                        JOIN coffee.products ON coffee.products.productID=coffee.products_tagMap.productID
                        JOIN coffee.products_tags ON coffee.products_tags.tagID=coffee.products_tagMap.tagID
                        WHERE coffee.products.productID = $productIDForTags ORDER BY tagName;";

                        $result = mysqli_query($link, $tagCommandText);

                        $tag_num = 0;
                        while ($rowJ = mysqli_fetch_assoc($result)) {?>


                        <span id="<?php echo $row["productID"] . "tag" . $tag_num ?>" class="tags"><?php echo "#" . $rowJ["tagName"] ?></span>


                        <?php
                        $tag_num++;
                            }?>


                        </td>
                        <td>
                            <div class="right_btn">
                            <input type="submit" value="刪除" name="<?php echo "delete" . $row["productID"] ?>"
                                class="btn btn-danger my-0 btn-md" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                            <input type="button" value="編輯" class="btn btn-primary my-0 btn-md" onclick="create_edit(<?php echo "'" . $row["productID"] . "'" ?>)">
                            </div>

                        </td>
                    </tr>
                        <?php }}?>
                </tbody>

            </table>
        </form>


        <div class="d-flex justify-content-center align-items-center flex-column  m-5">
        <!-- page select -->
        <div class="m-3">
            <a class='m-2 btn bg-color-gold' href='products.php?page=1'>第一頁</a>
            <a class='m-2 btn bg-color-gold' href='products.php?page=<?php echo ($page <= 1) ? "1" : $previousPage; ?>'>上一頁</a>
            <a class='m-2 btn bg-color-gold' href='products.php?page=<?php echo ($page >= $lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
            <a class='m-2 btn bg-color-gold' href='products.php?page=<?php echo $lastPage; ?>'>最尾頁</a>
        </div>
            <div>
            <?php
for ($i = 1; $i <= 3 && $i <= $lastPage; $i++) {
    echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
}
if ($page <= 6) {
    for ($i = 4; $i <= ($page + 2) && $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
    }
} else {
    echo "<span>......</span>";
    for ($i = ($page - 2); $i <= ($page + 2) && $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
    }
}
if ($lastPage - $page <= 5) {
    for ($i = ($page + 3); $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
    }
} else {
    echo "<span>......</span>";
    for ($i = ($lastPage - 2); $i <= $lastPage; $i++) {
        echo " <a class='m-2' href='products.php?page=$i'>$i</a>";
    }
}



mysqli_close($link);
?>
            </div>
        </div>

    </div>
</div>
<div id="create_edit_window" class="window_close">
    <div id="create_edit_bg">
    </div>


</div>
    <!-- End your code here. -->
    <?php include '../parts/footer.php';?>

</body>