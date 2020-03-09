<?php

if (isset($_POST["logout"])) {

    $_SESSION['username'] = '';
    $_SESSION['AorS'] = '';
    header('Location: ../index.php');
}

function GetSQLValueString($theValue, $theType) {
  switch ($theType) {
    case "string":
      $theValue = ($theValue != "") ? filter_var($theValue, FILTER_SANITIZE_MAGIC_QUOTES) : "";
      break;
    case "int":
      $theValue = ($theValue != "") ? filter_var($theValue, FILTER_SANITIZE_NUMBER_INT) : "";
      break;
    case "email":
      $theValue = ($theValue != "") ? filter_var($theValue, FILTER_VALIDATE_EMAIL) : "";
      break;
    case "url":
      $theValue = ($theValue != "") ? filter_var($theValue, FILTER_VALIDATE_URL) : "";
      break;      
  }
  return $theValue;
}
require_once("connMysql.php");
session_start();

$username=$_SESSION['username'];
$findID=mysqli_query($db_link,"select sellerID from coffee.sellers WHERE sAccount='$username';");
$ID = mysqli_fetch_assoc($findID);
$userID = $ID["sellerID"];

//檢查是否經過登入
if(!isset($_SESSION['username']) || ($_SESSION['username']=="")){
	header("Location: ../index.php");
}
//執行登出動作
if(isset($_GET["logout"]) && ($_GET["logout"]=="true")){
	unset($_SESSION["username"]);
	
	header("Location: ../index.php");
}
//重新導向頁面
$redirectUrl="../works/_main.php";
//執行更新動作
if(isset($_POST["action"])&&($_POST["action"]=="update")){	
	// $query_update = "UPDATE sellers SET sPassword=?, sName=?, sMail=?, sCountry=?, sPhone=?, sAddress=? WHERE sellerID=?";
	// $stmt = $db_link->prepare($query_update);

	//修正bug
	$MyName=$_POST["sName"];
	$MyPhone=$_POST["sPhone"];
	$MyPassword = password_hash($_POST["sPassword"], PASSWORD_BCRYPT);
	$MyAddress=$_POST["sAddress"];
	$MyMail=$_POST["sMail"];
	$MyCountry=$_POST["sCountry"];
	$sql_query = "UPDATE sellers SET sName='$MyName', sPassword='$MyPassword', sPhone='$MyPhone', sAddress='$MyAddress', sMail='$MyMail', sCountry='$MyCountry' WHERE sellerID='$userID' ";   
	$stmt = $db_link -> prepare($sql_query);
	$stmt -> execute();
	$stmt -> close();
	$db_link -> close();





	//檢查是否有修改密碼
	$mpass = $_POST["sPasswordo"];
	if(($_POST["sPassword"]!="")&&($_POST["sPassword"]==$_POST["sPasswordrecheck"])){
		$mpass = password_hash($_POST["sPassword"], PASSWORD_DEFAULT);
	}
	// $stmt->bind_param("ssssssi", 
	// 	$mpass,
	// 	GetSQLValueString($_POST["sName"], 'string'),
	
	// 	GetSQLValueString($_POST["sMail"], 'email'),
	// 	GetSQLValueString($_POST["sCountry"], 'string'),
	// 	GetSQLValueString($_POST["sPhone"], 'string'),
	// 	GetSQLValueString($_POST["sAddress"], 'string'),		
	// 	GetSQLValueString($_POST["sellerID"], 'int'));
	// $stmt->execute();
	// $stmt->close();

	//若有修改密碼，則登出回到首頁。
	if(($_POST["sPassword"]!="")&&($_POST["sPassword"]==$_POST["sPasswordrecheck"])){
		unset($_SESSION["username"]);
		
		$redirectUrl="../index.php";
	}		
	//重新導向
	header("Location: $redirectUrl");
}

//繫結登入會員資料
$query_RecMember = "SELECT * FROM sellers WHERE sellerID='$userID'";
$RecMember = $db_link->query($query_RecMember);	
$row_RecMember = $RecMember->fetch_assoc();
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>網站會員系統</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC|Noto+Serif+TC&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../demostyle.css">
<script src="../demoutil.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">

<script language="javascript">
function checkForm(){
	if(document.formJoin.sPassword.value!="" || document.formJoin.sPasswordrecheck.value!=""){
		if(!check_passwd(document.formJoin.sPassword.value,document.formJoin.sPasswordrecheck.value)){
			document.formJoin.sPassword.focus();
			return false;
		}
	}	
	if(document.formJoin.sName.value==""){
		alert("請填寫名稱!");
		document.formJoin.sName.focus();
		return false;
	}
	
	if(document.formJoin.sMail.value==""){
		alert("請填寫電子郵件!");
		document.formJoin.sMail.focus();
		return false;
	}
	if(!checkmail(document.formJoin.sMail)){
		document.formJoin.sMail.focus();
		return false;
	}
	return confirm('確定送出嗎？');
}
function check_passwd(pw1,pw2){
	if(pw1==''){
		alert("密碼不可以空白!");
		return false;
	}
	for(var idx=0;idx<pw1.length;idx++){
		if(pw1.charAt(idx) == ' ' || pw1.charAt(idx) == '\"'){
			alert("密碼不可以含有空白或雙引號 !\n");
			return false;
		}
		if(pw1.length<5 || pw1.length>10){
			alert( "密碼長度只能5到10個字母 !\n" );
			return false;
		}
		if(pw1!= pw2){
			alert("密碼二次輸入不一樣,請重新輸入 !\n");
			return false;
		}
	}
	return true;
}
function checkmail(sMail) {
	var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if(filter.test(sMail.value)){
		return true;
	}
	alert("電子郵件格式不正確");
	return false;
}
</script>
</head>

<body>

<?php include '../parts/sidebar.php';?>
<?php include '../parts/head.php';?>

<table width="780" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td class="tdbline"><img src="images/mlogo5.png" alt="會員系統" width="164" height="67"></td>
  </tr>
  <tr>
    <td class="tdbline"><table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr valign="top">
        <td class="tdrline"><form action="" method="POST" name="formJoin" id="formJoin" onSubmit="return checkForm();">
          <p class="title">修改資料</p>
          <div class="dataDiv">
            <hr size="1" />
            <p class="heading">帳號資料</p>
            <p>&nbsp;使用帳號：
			<input class="form-control" value="<?php echo $row_RecMember["sAccount"];?>" readonly></p></input><br>
            <p>&nbsp;使用密碼：
            <input name="sPassword" type="password" class="form-control" id="sPassword"><br>
    		<input name="sPasswordo" type="hidden" id="sPasswordo" value="<?php echo $row_RecMember["sPassword"];?>"></p>
            <p>&nbsp;確認密碼 ：
            <input name="sPasswordrecheck" type="password" class="form-control" id="sPasswordrecheck">
            <span class="smalltext">若不修改密碼，請不要填寫。若要修改，請輸入密碼</span><span class="smalltext">二次。<br>若修改密碼，系統會自動登出，請用新密碼登入。</span></p>
            <hr size="1" />
            <p class="heading">基本資料</p>
            <p><font color="#FF0000">*</font>公司名稱：
            <input name="sName" type="text" class="form-control" id="sName" value="<?php echo $row_RecMember["sName"];?>">
            <br>
            
            <p><font color="#FF0000">*</font>電子郵件：
            <input name="sMail" type="text" class="form-control" id="sMail" value="<?php echo $row_RecMember["sMail"];?>">
            <span class="smalltext">請確定此電子郵件為可使用狀態，以方便未來系統使用。</span></p>
            <p>&nbsp;國　　家：
            <input name="sCountry" type="text" class="form-control" id="sCountry" value="<?php echo $row_RecMember["sCountry"];?>">
            <br><span class="smalltext"></span></p>
            <p><font color="#FF0000">*</font>電　　話：
            <input name="sPhone" type="text" class="form-control" id="sPhone" value="<?php echo $row_RecMember["sPhone"];?>"></p>
            <br><p><font color="#FF0000">*</font>地　　址：
            <input name="sAddress" type="text" class="form-control" id="sAddress" value="<?php echo $row_RecMember["sAddress"];?>" size="40"> </p>
            <br><p><font color="#FF0000">*</font> 表示為必填的欄位</p>
          </div>
          <hr size="1" />
          <p align="center">
            <input name="sellerID" type="hidden" id="sellerID" value="<?php echo $row_RecMember["sellerID"];?>">
            <input name="action" type="hidden" id="action" value="update">
            <input type="submit" class="btn btn-danger ml-3 mb-3" name="Submit2" value="修改資料">
            
            <input type="button" class="btn btn-primary ml-3 mb-3" name="Submit" value="回上一頁" onClick="window.history.back();">
          </p>
        </form></td>
        <td width="200">
        <div class="boxtl"></div><div class="boxtr"></div>
        <div class="regbox" align="center">
          <p class="heading"><strong>會員系統</strong></p>
          
            <p><strong><?php echo $row_RecMember["sName"];?></strong> 您好。</p>
            
            <p>本次登入的時間為：</p>
            <?php echo date("Y年m月d日") ;?></br>
            <p ><a href="../works/_main.php">會員中心</a> | <a href="?logout=true">登出系統</a></p>
        </div>
        <div class="boxbl"></div><div class="boxbr"></div></td>
      </tr>
    </table></td>
  </tr>
  <!-- <tr>
    <td align="center" background="images/album_r2_c1.jpg" class="trademark">© 2020 ILoveCoffee Company All Rights Reserved.</td>
  </tr> -->
</table>
</body>
</html>
<?php
	$db_link->close();
?>