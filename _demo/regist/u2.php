<?php
include("connMysql.php");
$username=$_SESSION['username'];
$findID=mysqli_query($link,"select sellerID from coffee.sellers WHERE sAccount='$username';");
$userID="";
while ($ID = mysqli_fetch_assoc($findID)){
    $userID = $ID["sellerID"];
}




$MyName=$_POST["cName"];
$MyMobile=$_POST["cMobile"];
$MyBirthDate=$_POST["cBirthDate"];
$MySex=$_POST["cSex"];
$MyMobile=$_POST["cMobile"];
$MyAddress=$_POST["cAddress"];

$sql_query = "UPDATE customers SET cName='$MyName',cMobile= '$MyMobile', cBirthDate='$MyBirthDate', cSex='$MySex', cMobile='$MyMobile', cAddress='$MyAddress' WHERE customerID='$userID' ";
$stmt = $db_link -> prepare($sql_query);
$stmt -> execute();
$stmt -> close();
$db_link -> close();



?>
<html>

<form action="u2.php" method="post">


<td>姓名</td><td><input type="text" name="cName" id="cName" value=""></td><br/>
<td>電話</td><td><input type="text" name="cMobile" id="cMobile" value=""></td><br/>
<td>生日</td><td><input type="text" name="cBirthDate" id="cBirthDate" value=""></td><br/>
<td>性別</td><input type="radio" name="cSex" id="radio" value="M" <?php if($csex=="M") echo "checked";?>>男
<input type="radio" name="cSex" id="radio" value="F" <?php if($csex=="F") echo "checked";?>>女<br/>
<td>電話</td><td><input type="text" name="cMobile" id="cMobile" value="<?php echo $cMobile;?>"></td><br/>
<td>住址</td><td><input name="cAddress" type="text" id="cAddress" size="40" value="<?php echo $cAddress;?>"></td><br/>
<input type="submit" name="button" id="button" value="更新資料">

</form>

</html>

<?php

?>