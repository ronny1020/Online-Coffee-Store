<?php
                     
//          　　∩＿＿＿∩　　   
//             | ˊ ︵ ︵ˋ
//            ∕   (⊙)(⊙)        It's not a bug, it's a feature.
//           |  　( _●_) ≡      /
//       ＿＿≡　    |∪| ミ        
//     ˋ＿＿＿        ﹨ˊ  ＼   
//          /　     ／  ( (    
//         /       ╱     ﹀    
//        /     ╴／         
//     （＿     ˋ           
//       | / ╲ }           
//       ∪    ))           
// 
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
if (isset($_POST["productID_ASC"]) || isset($_POST["ProductName_ASC"]) || isset($_POST["categoryName_ASC"]) || isset($_POST["UnitPrice_ASC"]) || isset($_POST["UnitsInStock_ASC"]) || isset($_POST["add_time_ASC"]) || isset($_POST["visited_ASC"])) {
    $_SESSION["product_ASCorDESC"] = "ASC";
} else if (isset($_POST["productID_DESC"]) || isset($_POST["ProductName_DESC"]) || isset($_POST["categoryName_DESC"]) || isset($_POST["UnitPrice_DESC"]) || isset($_POST["UnitsInStock_DESC"]) || isset($_POST["add_time_DESC"])|| isset($_POST["visited_DESC"])) {
    $_SESSION["product_ASCorDESC"] = "DESC";
} else if (isset($_SESSION["product_ASCorDESC"])) {
} else {
    $_SESSION["product_ASCorDESC"] = "ASC";
}
$ASCorDESC = $_SESSION["product_ASCorDESC"];

if (isset($_POST["productID_ASC"]) || isset($_POST["productID_DESC"])) {
    $_SESSION["product_orderby"] = "productID";
} else if (isset($_POST["ProductName_ASC"]) || isset($_POST["ProductName_DESC"])) {
    $_SESSION["product_orderby"] = "ProductName";
} else if (isset($_POST["categoryName_ASC"]) || isset($_POST["categoryName_DESC"])) {
    $_SESSION["product_orderby"] = "categoryName";
} else if (isset($_POST["UnitPrice_ASC"]) || isset($_POST["UnitPrice_DESC"])) {
    $_SESSION["product_orderby"] = "UnitPrice";
} else if (isset($_POST["UnitsInStock_ASC"]) || isset($_POST["UnitsInStock_DESC"])) {
    $_SESSION["product_orderby"] = "UnitsInStock";
} else if (isset($_POST["add_time_ASC"]) || isset($_POST["add_time_DESC"])) {
    $_SESSION["product_orderby"] = "add_time";
} else if (isset($_POST["visited_ASC"]) || isset($_POST["visited_DESC"])) {
    $_SESSION["product_orderby"] = "visited";
} else if (isset($_SESSION["product_orderby"])) {
} else {
    $_SESSION["product_orderby"] = "productID";
}
$orderby = $_SESSION["product_orderby"];

//number of rows
if (isset($_POST["row_num_submit"])) {
    $_SESSION["products_row_num"] = $_POST["row_num"];
    header('location:products.php');
} else if (isset($_SESSION["products_row_num"])) {
} else {
    $_SESSION["products_row_num"] = 50;
}
$rowNum = $_SESSION["products_row_num"];


// visitedRange
if (isset($_POST["visited_rangeSelect"])) {
    $_SESSION["visited_rangeSelect"] = $_POST["visited_rangeSelect"];
    // header('location:products.php');
} else if (isset($_SESSION["visited_rangeSelect"])) {
} else {
    $_SESSION["visited_rangeSelect"] = "999years";
}
$visitedRange= $_SESSION["visited_rangeSelect"];


$time = time();
$timeNow=date("Y-m-d H:i:s", $time);


$visitedRangeStart = date_create(date("Y-m-d H:i:s", $time));
date_add($visitedRangeStart, date_interval_create_from_date_string('-'.$visitedRange));
$visitedRangeStart=date_format($visitedRangeStart, 'Y-m-d H:i:s');



//connect to SQL
header("content-type:text/html; charset=utf-8");
$link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");



// search function
if (isset($_POST["startSearch"])) {
    if($_POST["searchKeyword"]!=""){
        $_SESSION["product_searchKeyword"] = $_POST["searchKeyword"];
    }
    $_SESSION["product_searchBy"] = $_POST["searchBy"];
    header('location:products.php');
}

// clear search
if (isset($_POST["clearSearch"])) {
    unset($_SESSION["product_searchKeyword"]);
    unset($_SESSION["product_searchBy"]);
    header('location:products.php');
}
$searchComment="";

if(isset($_SESSION["product_searchKeyword"])) {
    $searchKeyword=$_SESSION["product_searchKeyword"];
    if($_SESSION["product_searchBy"]=="productName"){
        $searchComment="and productName like '%$searchKeyword%'";
    }else if($_SESSION["product_searchBy"]=="specification"){
        $searchComment="and specification like '%$searchKeyword%'";
    }else if($_SESSION["product_searchBy"]=="description"){
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
        $searchComment="and products.productID in $productIDList";
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

$updateNum=0;
$insertNum=0;
$warningMessage="";
$deleteNum=0;




// right delete btn
foreach ($_POST as $i => $j) {
    if (substr($i, 0, 6) === "delete" && $i!="deleteSelected" ) {        
        

        $deleteItem = ltrim($i, "delete");
        $findDeletedTags="select tagID from coffee.products_tagMap WHERE productID ='$deleteItem';";
        $DeletedTags=mysqli_query($link, $findDeletedTags);
        $k=0;
        while ($tagRow = mysqli_fetch_assoc($DeletedTags)) {
            $tagList[$k] = $tagRow;
            $k++;
        }
        foreach ($tagList as $tagRow) {
            $DeletedTagID=$tagRow["tagID"];
            $checkDeletedTagsComment="select tagID from coffee.products_tagMap WHERE tagID ='$DeletedTagID';";
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
        // header('location:' . $_SERVER['REQUEST_URI'] . '');
        $deleteNum=1;

        
    }
}


// delete selected items
if (isset($_POST["deleteSelected"])) {
    $selectedList = "!";

    foreach ($_POST as $i => $j) {
        if (substr($i, 0, 8) === "selected") {
            $selectedItem = ltrim($i, "selected");
            $findDeletedTags="select tagID from coffee.products_tagMap WHERE productID ='$selectedItem';";
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
            // header('location:' . $_SERVER['REQUEST_URI'] . '');
            $deleteNum++;
        }
    }
    // header('location:' . $_SERVER['REQUEST_URI'] . '');
}


// export selected data
if (isset($_POST["exportSelected"])) {
  
    $selectedList="(";

    foreach ($_POST as $i => $j) {
        if (substr($i, 0, 8) == "selected") {
            $selectedItem = ltrim($i, "selected");
            $selectedList.=$selectedItem.",";
        }
    }

    $selectedList=rtrim($selectedList,",");
    $selectedList.=")";
    
    if($selectedList != "()"){
        $exportComment="select productID, ProductName, categoryName, UnitPrice, UnitsInStock, specification, products.description from coffee.products 
        JOIN coffee.category ON coffee.category.CategoryID=coffee.products.CategoryID  
        where sellerID='$userID' and productID in $selectedList ORDER BY productID;";
    
        $exportResult = mysqli_query($link, $exportComment);
        $columns_total = mysqli_num_fields($exportResult);
        $exportResult_exist = mysqli_num_rows($exportResult)>0;
    
        // Get The Field Name
        $output ="";
        for($i = 0; $i < $columns_total; $i++){
            $heading = mysqli_fetch_field_direct($exportResult, $i);
            $output .= '"' . $heading->name . '",';
        }
        $output =rtrim($output,",")."\n";
 
        // Get Records from the table

        while($row = mysqli_fetch_assoc($exportResult)){
    
        $output .='"' . $row["productID"] . '",';
        $output .='"' . $row["ProductName"] . '",';
        $output .='"' . $row["categoryName"] . '",';
        $output .='"' . $row["UnitPrice"] . '",';
        $output .='"' . $row["UnitsInStock"] . '",';
        $output .='"' . $row["specification"] . '",';
        $output .='"' . $row["description"] . '",';
        $output =rtrim($output,",")."\n";   
        }


            // Download the file
        $filename = "ProductList". date('Y-m-d H:i:s').".csv";
        header('Content-Encoding: big5');
        header("Content-Type: text/csv; charset=big5");
        header('Content-Disposition: attachment; filename=' . $filename);

        echo iconv("UTF-8", "big5", $output);
        exit;
  
    }
    // header('location:' . $_SERVER['REQUEST_URI'] . '');
}


// import data
if (isset($_POST["import_data"])) {
    
    $import_file = $_FILES["import_upload"]["tmp_name"];
    
  
    // Check if file is a  csv
    $import_type = strtolower(pathinfo(basename($_FILES["import_upload"]["name"]),PATHINFO_EXTENSION));

    
    if($import_type != "csv" ) {
        $warningMessage="僅接受csv。";
    }else{


        if ($_FILES["import_upload"]["size"] > 0) {

            $import_data = fopen($import_file, "r");


            // while(! feof($import_data)){
            //     print_r(fgetcsv($import_data));
            // }

            while (($row = fgetcsv($import_data, 10000, ",")) !== FALSE) {
    
                $row=mb_convert_encoding($row ,"UTF-8","big5");
                
                $productID_import=$row[0];
                $ProductName_import=$row[1];
                $categoryName_import=$row[2];
                $UnitPrice_import=$row[3];
                $UnitsInStock_import=$row[4];
                $specification_import=$row[5];
                $description_import=$row[6];

                $findCategoryIDCommend="select CategoryID from coffee.category where categoryName='$categoryName_import';";
                $findCategoryIDResult = mysqli_query($link, $findCategoryIDCommend);
                if(mysqli_num_rows($findCategoryIDResult)>0){
                    $CategoryID_import=mysqli_fetch_assoc($findCategoryIDResult)["CategoryID"];
        
                    if($productID_import=="productID"){
                    
                    }else if($productID_import==""){
                    
                        $add_time_now = date("Y-m-d H:i:s", time());
                        $import_comment = "INSERT INTO coffee.products (`ProductName`, `sellerID`, `CategoryID`, `UnitPrice`,`UnitsInStock`, `add_time`, `specification`, `description`)  
                        VALUES  ('$ProductName_import','$userID',$CategoryID_import,$UnitPrice_import,$UnitsInStock_import,'$add_time_now','$specification_import','$description_import');";
                        mysqli_query($link, $import_comment );
                        $insertNum++;
                        
                    }else{
                        $checkProductIDExistComment="select productID from coffee.products where productID=$productID_import and sellerID='$userID';";
                        $checkProductIDExistResult= mysqli_query($link, $checkProductIDExistComment);
        
                        if(mysqli_num_rows($checkProductIDExistResult)>0){
                            $importUpdate_comment = "UPDATE `coffee`.`products` SET 
                            `ProductName` = '$ProductName_import', 
                            `CategoryID` = '$CategoryID_import',
                            `UnitPrice` = $UnitPrice_import, 
                            `UnitsInStock` = $UnitsInStock_import,
                            `specification` = '$specification_import',
                            `description` = '$description_import'
                            WHERE `productID` = $productID_import;";

                            mysqli_query($link, $importUpdate_comment);
                            $updateNum++;
                        }else{
                            if ($productID_import != "productID") {
                                // $warningMessage=$warningMessage."<br>"."產品ID:$productID_import 發生ID錯誤。";
                            }
                        }

                    }    
                }else{
                    if($productID_import != "productID"){
                        // $warningMessage=$warningMessage."<br>"."在$productID_import 發生類別錯誤。";
                    }
                }   
            }

            fclose($import_data);
        }
    }   
}





// uploadImage
function uploadImage($productIDForImage){
    $ImageUpload_dir = "../image/products/";

    $uploadOk = 1;
    $ImageUploadType = strtolower(pathinfo(basename($_FILES["ProductImage_upload"]["name"]),PATHINFO_EXTENSION));

    $uploadedName=$ImageUpload_dir.$productIDForImage.".".$ImageUploadType;
  
    // Check if image file is a actual image or fake image
 
    $check = getimagesize($_FILES["ProductImage_upload"]["tmp_name"]);
    if($check == false) {
        $GLOBALS['warningMessage']="圖片上傳失敗，這不是圖片。";
        $uploadOk = 0;
    }
    
    if(($ImageUploadType != "jpg" && $ImageUploadType != "png" && $ImageUploadType != "jpeg"  && $ImageUploadType != "gif" )  ) {
        $GLOBALS['warningMessage']="圖片上傳失敗，僅接受JPG、JPEG、PNG、GIF。";
        $uploadOk = 0;
    }

    if ($uploadOk == 0) {

    // if everything is ok, try to upload file
    } else {
        if (move_uploaded_file($_FILES["ProductImage_upload"]["tmp_name"], $uploadedName)) {
            $GLOBALS['warningMessage']="圖片上傳成功";
        } else {
  
        }
    }
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

    if($_FILES["ProductImage_upload"]["name"]!=""){
        uploadImage($productID_input);
    }

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
    // header('location:' . $_SERVER['REQUEST_URI'] . '');
    $insertNum++;
}
// update
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

    if($_FILES["ProductImage_upload"]["name"]!=""){
        uploadImage($productID_input);
    }
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
    // header('location:' . $_SERVER['REQUEST_URI'] . '');
    $updateNum++;
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

    <?php if($updateNum>0){ ?>
    <div class="alert alert-primary alert-dismissible fade show">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <?php echo "您成功修改".$updateNum."筆資料。" ; ?>
    </div>
    
    <?php };    
    if($insertNum>0){ ?>
    <div class="alert alert-info alert-dismissible fade show">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <?php echo "您成功新增".$insertNum."筆資料。" ; ?>
    </div>
    <?php };    
    if($warningMessage !== "" ){ ?>
    <div class="alert alert-warning alert-dismissible fade show">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <?php echo $warningMessage ; ?>
    </div>
    <?php };    
    if($deleteNum>0){ ?>
    <div class="alert alert-danger alert-dismissible fade show">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <?php echo "您成功刪除".$deleteNum."筆資料。" ; ?>
    </div>
    <?php };  ?>


    <div class="container mb-3" style="text-align:center; font-size: 40px; font-weight: 700;">商品管理</div>
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
                    if(isset($_SESSION["product_searchKeyword"])){
                        echo "您正在搜尋：".$_SESSION["product_searchKeyword"];
                    }                    
                     ?>
                </p>
            </div>
        </form>

        <form method='post' class="card p-3">
            <div>
                <input type="submit" value="刪除勾選" name="deleteSelected" onclick="return confirm('你確定要刪除勾選資料嗎？')" class="btn btn-danger mb-3">
                <input type="button" value="新增資料" class="btn btn-primary ml-3 mb-3" onclick="create_edit()">
                <input type="submit" value="匯出勾選" class="btn btn-success ml-3 mb-3" name="exportSelected">
                <input type="button" value="匯入資料" class="btn btn-info ml-3 mb-3" onclick="importDataUpload()">

                <div class='float-right'>
                    <span class="mr-5">
                        <!-- show where you are -->
                        <?php
echo "您在第 $page 頁，顯示資料為 $showDataStartFrom - $showDataEndTo 筆(共 $total_num_rows 筆資料)" ?>
                    </span>
                    <label for="visited_rangeSelect" class="ml-3">請選擇人氣統計時間:</label>
                    <select id="visited_rangeSelect" name="visited_rangeSelect">
                        <option value="999years" <?php if ($visitedRange == "999years") {echo "selected";}?>>全部</option>
                        <option value="1day" <?php if ($visitedRange == "1day") {echo "selected";}?>>單日內 </option>
                        <option value="1week" <?php if ($visitedRange == "1week") {echo "selected";}?>>單周內 </option>
                        <option value="1month" <?php if ($visitedRange == "1month" ) {echo "selected";}?>>單月內 </option>
                        <option value="3months" <?php if ($visitedRange == "3months") {echo "selected";}?>>三個月內</option>
                        <option value="1year" <?php if ($visitedRange == "1year") {echo "selected";}?>>一年內</option>
                    </select>

                    <label for="row_num_select" class="ml-3">請選擇顯示行數:</label>
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
                        <th>
                            <div class="d-flex justify-content-center align-items-center flex-row m-0">
                                <p class="m-1">人氣</p>
                                <div class="DESC-ASC ml-2">
                                    <input type="submit" class="d-block btn btn-DESC" value="▲" name="visited_DESC">
                                    <input type="submit" class="d-block btn btn-ASC" value="▼" name="visited_ASC">
                                </div>
                            </div>
                        </th>
                        <th class="tags">tags
                        </th>
                        <th class="right_btn">
                        </th>
                </thead>

                <tbody>

                    <?php
                    // write table

                    $commandText = "select products.productID, ProductName, sellerID, categoryName, UnitPrice, UnitsInStock, add_time,COUNT(time_stamp) visited, specification, products.description from coffee.products 
                    JOIN coffee.category ON coffee.category.CategoryID=coffee.products.CategoryID  
                    LEFT JOIN coffee.product_visited ON coffee.product_visited.productID=coffee.products.productID  and time_stamp BETWEEN '$visitedRangeStart' AND '$timeNow' 
                    where sellerID='$userID' $searchComment  group by productID ORDER BY $orderby $ASCorDESC LIMIT $rowNum OFFSET $tableOffSet;";

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
                        <td id="<?php echo $row["productID"] . "visited" ?>"class="num" ><?php echo $row["visited"] ?></td>
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
                            <input type="button" value="編輯" class="btn btn-primary my-0  mr-o btn-md" onclick="create_edit(<?php echo "'" . $row["productID"] . "'" ?>)">
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
            <a class='m-2 btn btn-warning border-0 bg-color-gold' href='products.php?page=1'>第一頁</a>
            <a class='m-2 btn btn-warning border-0 bg-color-gold' href='products.php?page=<?php echo ($page <= 1) ? "1" : $previousPage; ?>'>上一頁</a>
            <a class='m-2 btn btn-warning border-0 bg-color-gold' href='products.php?page=<?php echo ($page >= $lastPage) ? $lastPage : $nextPage; ?>'>下一頁</a>
            <a class='m-2 btn btn-warning border-0 bg-color-gold' href='products.php?page=<?php echo $lastPage; ?>'>最尾頁</a>
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
<div id="popUp_window" class="window_close">
    <div id="popUp_bg" onclick="popUp_close()">
    </div>


</div>
    <!-- End your code here. -->
    <?php include '../parts/footer.php';?>

</body>