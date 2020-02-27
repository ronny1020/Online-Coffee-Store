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

        //Right edit button:
    } elseif (substr($i, 0, 4) == "edit") {
        //獲得customerID
        $editItem = ltrim($i, "edit");
        $editCommandText = <<<SqlQuery
        select customerID, cName, cAccount, cSex, cBirthDate, cAddress, cMobile
        from coffee.customers WHERE customerID IN ('$editItem')
        SqlQuery;
        $result = mysqli_query($link, $editCommandText);
        while ($row = mysqli_fetch_assoc($result)) {
            $_SESSION["modal_cid"] = $row["customerID"];
            $_SESSION["modal_nam"] = $row["cName"];
            $_SESSION["modal_acc"] = $row["cAccount"];
            $_SESSION["modal_sex"] = $row["cSex"];
            $_SESSION["modal_bid"] = $row["cBirthDate"];
            $_SESSION["modal_adr"] = $row["cAddress"];
            $_SESSION["modal_mob"] = $row["cMobile"];
        }
        ;
        // header('location:' . $_SERVER['REQUEST_URI'] . '');
    }
}

// Output at modal.
function wModal($mystr)
{
    echo ($mystr);
    // setcookie($mystr, '', time() - 3600);
    unset($mystr);
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
    $deleteSelectedCommandText = <<<SqlQuery
    DELETE FROM coffee.customers WHERE customerID IN ($selectedList)
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
    </div>

    <table class="table table-striped ">
        <thead class="thead-light">
            <tr>
                <th>check</th>
                <th>customerID</th>
                <th>cName</th>
                <th>cAccount</th>
                <th>cSex</th>
                <th>cBirthDate</th>
                <th>cAddress</th>
                <th>cMobile</th>
                <th></th>
            </tr>
        </thead>
        <tbody>

<?php
// write table
// $commandText: $str
$commandText = <<<SqlQuery
select customerID, cName, cAccount, cSex, cBirthDate, cAddress, cMobile
from coffee.customers
SqlQuery;

$result = mysqli_query($link, $commandText);
while ($row = mysqli_fetch_assoc($result)): ?>

            <tr>
                <td>
                    <input type="checkbox" name="<?php echo "selected" . $row["customerID"] ?>" class='checkmark'
                        style='position: relative;'>
                </td>
                <?php echo $res_fSTR . $row["customerID"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["cName"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["cAccount"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["cSex"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["cBirthDate"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["cAddress"] . $res_bSTR ?>
                <?php echo $res_fSTR . $row["cMobile"] . $res_bSTR ?>
                <td>
                    <input type="submit" value="刪除" name="<?php echo "delete" . $row["customerID"] ?>"
                        class="btn btn-danger mb-3" onclick="return confirm('你確定要刪除這筆資料嗎？')">
                    <!--Modal aslo toggled at here.-->
                    <input type='submit' value="編輯" name="<?php echo "edit" . $row["customerID"] ?>"
                        class="btn btn-primary mb-3" data-toggle="modal" data-target="#myModal">
                </td>
            </tr>
            <?php endwhile?>
        </tbody>
    </table>
</form>
</div>
<!-- Dummy frame. -->
<iframe name="thisframe"></iframe>
<!-- Modal -->
<div class="modal" id="myModal">
<div class="modal-dialog">
    <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header">
            <h4 class="modal-title">資料變更:</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">
            <tr>
                <form method="post">
                    <th>customerID:<input type="text" name='cid ' value="<?php wModal($_SESSION["modal_cid"]);?>">
                    </th>
                    <hr>
                    <th>cName: <input type="text" name='nam' value="<?php wModal($_SESSION["modal_nam"]);?>"></th>
                    <hr>
                    <th>cAccount: <input type="text" name='acc' value="<?php wModal($_SESSION["modal_acc"]);?>">
                    </th>
                    <hr>
                    <th>cSex: <input type="text" name='sex' value="<?php wModal($_SESSION["modal_sex"]);?>"></th>
                    <hr>
                    <th>cBirthDate:<input type="text" name='bid' value="<?php wModal($_SESSION["modal_bid"]);?>">
                    </th>
                    <hr>
                    <th>cAddress: <input type="text" name='adr' value="<?php wModal($_SESSION["modal_adr"]);?>">
                    </th>
                    <hr>
                    <th>cMobile: <input type="text" name='mob' value="<?php wModal($_SESSION["modal_mob"]);?>"></th>
                </form>
            </tr>
        </div>

        <!-- Modal footer -->
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" data-dismiss="modal">Submit</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
    </div>
</div>
</div>
<!-- End your code here. -->
<?php include '../parts/footer.php';?>
</body>