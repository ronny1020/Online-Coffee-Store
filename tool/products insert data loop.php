<?php

//connect to SQL
header("content-type:text/html; charset=utf-8");
$link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
$result = mysqli_query($link, "set names utf8");
mysqli_select_db($link, "coffee");

//insert products
if (isset($_POST["insert"])) {
    
    $number = $_POST["number"];
   

    $time = time();
    
    while($number>=1){

        
        $thisTime =($number>999)?999:$number;
        $number-=999;
        $insertList = "!";
        
        for ($i = 1; $i <= $thisTime; $i++) {
            $sellerId=rand(1,5);
            $sellerId= str_repeat("0",3-(strlen($sellerId))).$sellerId;
            $CategoryID = rand(1,8);
            $UnitPrice=rand(10,1000);
            $UnitsInStock=rand(10,100);
            
            
            $timeRand =rand(0,3*365*24*60*60);
            $dateTime = $time-$timeRand;
            $dateTime =date("Y-m-d H:i:s", $dateTime);
        
            $specification="產地：";
            $description="最高品質的咖啡，感受手作的溫度。";
    
            $insertItem = "('好貨$i','S$sellerId','$CategoryID','$UnitPrice','$UnitsInStock','$dateTime','$specification','$description')";
            $insertList= $insertList.","."$insertItem";
        }

        
        $insertList = ltrim($insertList, "!,");

        $CommandText = "
        INSERT INTO `coffee`.`products` (`ProductName`, `sellerID`, `CategoryID`, `UnitPrice`,
        `UnitsInStock`, `add_time`, `specification`, `description`)  VALUES  $insertList;
    ";

        mysqli_query($link, $CommandText);
    }
    
    echo "done";    
}


//insert tags

if (isset($_POST["insertTag"])) {
    $number = $_POST["number"];

    $findMaxMin = mysqli_query( $link, "SELECT MAX( productID ) as MAX ,min( productID ) as MIN FROM products;" );
    $row = mysqli_fetch_assoc($findMaxMin);
    $maxProductID = $row["MAX"];
    $minProductID = $row["MIN"];
   
    $findMaxTag = mysqli_query( $link, "SELECT MAX( tagID ) as MAX FROM products_tags;" );
    $row = mysqli_fetch_assoc($findMaxTag);
    $maxTagID = $row["MAX"];


for($i=1;$i<=$number;$i++){
    $pid=rand($minProductID,$maxProductID);
    $pid= str_repeat("0",10-(strlen($pid))).$pid;
    $tid=rand(1,$maxTagID);

    $findTagMapExistComment="SELECT tagMapID FROM coffee.products_tagMap where productID=$pid and tagID=$tid;";
    $findTagMapExistResult=mysqli_query($link, $findTagMapExistComment);

    if(mysqli_num_rows($findTagMapExistResult)>0){

    }else{
        $CommandText = "INSERT INTO coffee.products_tagMap (productID, tagID) VALUES ($pid,$tid);";
        mysqli_query($link, $CommandText);
        echo $CommandText ;
        echo "<br>";
    }
}

    echo "done";   


}




// visited

if (isset($_POST["insertVisited"])) {
    $number = $_POST["number"];
    $time = time();

    $findMaxMin = mysqli_query( $link, "SELECT MAX( productID ) as MAX ,min( productID ) as MIN FROM products;" );
    $row = mysqli_fetch_assoc($findMaxMin);
    $maxProductID = $row["MAX"];
    $minProductID = $row["MIN"];

        for($i=1;$i<=$number;$i++){
        
        $timeRand =rand(0,3*365*24*60*60);
        $dateTime = $time-$timeRand;
        $dateTime =date("Y-m-d H:i:s", $dateTime);
        $pid=rand($minProductID,$maxProductID);

        $CustomerId=rand(1,5);
        $CustomerId= "C".str_repeat("0",3-(strlen($CustomerId))).$CustomerId;


        $CommandText = "INSERT INTO coffee.product_visited  (productID, customerID,time_stamp) VALUES ($pid,'$CustomerId','$dateTime');";
        mysqli_query($link, $CommandText);
        echo $CommandText ;
        echo "<br>";

    }

    echo "done";   


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
    <link rel="stylesheet" type="text/css" href="demostyle.css">
    <script src="demoutil.js"></script>
</head>

<body>
products:
<form method='post'>
number of data:<input type='number' name='number' >
<br>
<input type='submit' value='insert' name='insert'>
</form>

<hr>
tags:
<form method='post'>
number of data:<input type='number' name='number' >
<br>
<input type='submit' value='insert' name='insertTag'>
<Tag/form>

<hr>
visited:
<form method='post'>
number of data:<input type='number' name='number' >
<br>
<input type='submit' value='insert' name='insertVisited'>
<Tag/form>

</body>
