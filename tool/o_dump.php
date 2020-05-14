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
header("Content-Type:text/html; charset=utf-8");
function ChineseName($length = 1){
    $characters = array('王','李','張','劉','陳','楊','趙','吳','周','徐',
    '孫','馬','朱','胡','郭','何','林','高','羅','鄭','梁','謝');
    $charactersLength = sizeof($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;

}

function CityName($length = 1){
    $characters = array('台北','台中','高雄','倫敦','東京','大阪','馬六甲','雅加達');
    $charactersLength = sizeof($characters);
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
        $cus_rand=rand(1,50);
        $cus = str_repeat("0",3-(strlen($cus_rand))).$cus_rand;
        // $sellerId=rand(1,5);
        // $sellerId= str_repeat("0",3-(strlen($sellerId))).$sellerId;
        // $name = ChineseName().rand(1,9).rand(1,9);
        $addr = generateRandomString(5);
        $region = generateRandomString(5);
        $post_rand = rand(1,99999);
        $post = str_repeat("0",5-(strlen($post_rand))).$post_rand;
        $city = CityName();
        $country = $city.rand(1,20);
        // $eml = generateRandomString(10) . "@gmail.com";
        // $cpwd = 'pwd' . str_repeat("0",3-(strlen($i))).$i;;
        // $hashedpwd = password_hash($cpwd, PASSWORD_BCRYPT);
        // $tmp_bool = rand(1,2);
        // if ($tmp_bool === 1) $csex = "F";
        // else $csex = "M";
        $o_date = "1997-" . rand(1, 12) . "-" . rand(1, 31);
        $s_date = "1997-" . rand(1, 12) . "-" . rand(1, 31);
        // $caddress = "my_dummy_adrs" . rand(1, 100);
        // $cmoblie = "0900-00" . rand(1, 9) . "-00" . rand(1, 9);
        $insertItem = "('R$iii','C$cus','$o_date','$s_date','$addr','$region','$post','$city','$country')";
        $insertList = $insertList . "," . "$insertItem";
    }
    //1997-01-01 00:00:00
    //my_dummy_adrs01
    //0900-000-001

    $insertList = ltrim($insertList, "!,");

    $deleteSelectedCommandText = "
  INSERT INTO coffee.orders VALUES $insertList
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
