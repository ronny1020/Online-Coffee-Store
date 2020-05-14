<?php

function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

//connect to SQL
header("content-type:text/html; charset=utf-8");
$link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");

//insert
if (isset($_POST["insert"])) {
    $selectedList = "!";
    $start = $_POST["start"];
    $end = $_POST["end"];

    $insertList = "!";

    for ($i = $start; $i <= $end; $i++) {
        $iii= str_repeat("0",3-(strlen($i))).$i;
        // $sellerId=rand(1,5);
        // $sellerId= str_repeat("0",3-(strlen($sellerId))).$sellerId;
        $tmp_rand = rand(1,200);
        $cid = str_repeat("0",3-(strlen($tmp_rand))).$tmp_rand;
        $cacc = "dummy" . $i;
        $cpwd = "pwd" . $i;
        $csex = "F";
        $cbirthdate = "1997-" . rand(1, 12) . "-" . rand(1, 31);
        $crCONT = generateRandomString(100);
        $tmp_bool = rand(1,2);
        if ($tmp_bool === 1) $csex = "Y";
        else $csex = "N";
        $insertItem = "('CR$iii','C$cid','$cbirthdate','$crCONT','$csex')";
        $insertList = $insertList . "," . "$insertItem";
    }
    //1997-01-01 00:00:00
    //my_dummy_adrs01
    //0900-000-001

    $insertList = ltrim($insertList, "!,");

    $deleteSelectedCommandText = "
  INSERT INTO coffee.crams VALUES $insertList
  ";
    mysqli_query($link, $deleteSelectedCommandText);

    echo "done";
    // header('location:' . $_SERVER['REQUEST_URI'] . '');
}

// INSERT INTO coffee.products VALUES
//  ('P001','好貨01','S005',100,20)
// ,('P002','好貨02','S004',200,5)
// ,('P003','好貨03','S003',1000,10)
// ,('P004','好貨04','S002',500,10)
// ,('P005','好貨05','S001',400,100);

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
    <link rel="stylesheet" type="text/css" href="demostyle.css">
    <script src="demoutil.js"></script>
</head>

<body>
<form method='post'>
start:<input type='number' name='start' >
<br>
end:<input type='number' name='end' >
<br>
<input type='submit' value='insert' name='insert'>
</form>




</body>
