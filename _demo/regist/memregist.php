<?php
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

if(isset($_POST["action"])&&($_POST["action"]=="join")){
	require_once("connMysql.php");
	//找尋帳號是否已經註冊
	$query_RecFindUser = "SELECT sAccount FROM sellers WHERE sAccount='{$_POST["sAccount"]}'";
	$RecFindUser=$db_link->query($query_RecFindUser);
	if ($RecFindUser->num_rows>0){
		header("Location: member_join.php?errMsg=1&username={$_POST["sAccount"]}");
	}else{
	//若沒有執行新增的動作	
		$query_insert = "INSERT INTO sellers (sName, sellerID, sAccount, sPassword, sPhone, sAddress, sMail, sCountry) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		$stmt = $db_link->prepare($query_insert);
		$stmt->bind_param("ssssssss", 
      GetSQLValueString($_POST["sName"], 'string'),
      GetSQLValueString($_POST["sellerID"], 'string'),
			GetSQLValueString($_POST["sAccount"], 'string'),

			password_hash($_POST["sPassword"], PASSWORD_BCRYPT),
      GetSQLValueString($_POST["sPhone"], 'string'),
      GetSQLValueString($_POST["sMail"], 'string'),
      GetSQLValueString($_POST["sCountry"], 'string'),
			GetSQLValueString($_POST["sAddress"], 'string'));
		$stmt->execute();
		$stmt->close();
		$db_link->close();
		header("Location: memregist.php?loginStats=1");
	}
}
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>廠商註冊系統</title>
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
	if(document.formJoin.sAccount.value==""){		
		alert("請填寫帳號!");
		document.formJoin.sAccount.focus();
		return false;
	}else{
		uid=document.formJoin.sAccount.value;
		if(uid.length<5 || uid.length>12){
			alert( "您的帳號長度只能5至12個字元!" );
			document.formJoin.sAccount.focus();
			return false;}
		if(!(uid.charAt(0)>='a' && uid.charAt(0)<='z')){
			alert("您的帳號第一字元只能為小寫字母!" );
			document.formJoin.sAccount.focus();
			return false;}
		for(idx=0;idx<uid.length;idx++){
			if(uid.charAt(idx)>='A'&&uid.charAt(idx)<='Z'){
				alert("帳號不可以含有大寫字元!" );
				document.formJoin.sAccount.focus();
				return false;}
			if(!(( uid.charAt(idx)>='a'&&uid.charAt(idx)<='z')||(uid.charAt(idx)>='0'&& uid.charAt(idx)<='9')||( uid.charAt(idx)=='_'))){
				alert( "您的帳號只能是數字,英文字母及「_」等符號,其他的符號都不能使用!" );
				document.formJoin.sAccount.focus();
				return false;}
			if(uid.charAt(idx)=='_'&&uid.charAt(idx-1)=='_'){
				alert( "「_」符號不可相連 !\n" );
				document.formJoin.sAccount.focus();
				return false;}
		}
	}
	if(!check_passwd(document.formJoin.sPassword.value,document.formJoin.sPasswordrecheck.value)){
		document.formJoin.sPassword.focus();
		return false;}	
	if(document.formJoin.sName.value==""){
		alert("請填寫姓名!");
		document.formJoin.sName.focus();
		return false;}
	
	
	return confirm('確定送出嗎？');
}
function check_passwd(pw1,pw2){
	if(pw1==''){
		alert("密碼不可以空白!");
		return false;}
	for(var idx=0;idx<pw1.length;idx++){
		if(pw1.charAt(idx) == ' ' || pw1.charAt(idx) == '\"'){
			alert("密碼不可以含有空白或雙引號 !\n");
			return false;}
		if(pw1.length<5 || pw1.length>10){
			alert( "密碼長度只能5到10個字母 !\n" );
			return false;}
		if(pw1!= pw2){
			alert("密碼二次輸入不一樣,請重新輸入 !\n");
			return false;}
	}
	return true;
}

</script>
</head>

<body>

<?php if(isset($_GET["loginStats"]) && ($_GET["loginStats"]=="1")){?>
<script language="javascript">
alert('會員新增成功\n請用申請的帳號密碼登入。');
window.location.href='../index.php';		  
</script>
<?php }?>
<table width="780" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td class="tdbline"><img src="images/mlogo4.png" alt="會員系統" width="164" height="67"></td>
  </tr>
  <tr>
    <td class="tdbline"><table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr valign="top">
        <td class="tdrline"><form action="" method="POST" name="formJoin" id="formJoin" onSubmit="return checkForm();">
          <p class="title">註冊會員</p>
		  <?php if(isset($_GET["errMsg"]) && ($_GET["errMsg"]=="1")){?>
          <div class="errDiv">帳號 <?php echo $_GET["sAccount"];?> 已經有人使用！</div>
          <?php }?>
          <div class="dataDiv">
            <hr size="1" />
            <p class="heading">帳號資料</p>
            <p><font color="#FF0000">*</font>使用帳號：
            <input name="sAccount" type="text" class="form-control" placeholder="請輸入帳號" id="sAccount">
            <span class="smalltext">請填入5~12個字元以內的小寫英文字母、數字、以及_ 符號。</span></p>
            <p><font color="#FF0000">*</font>使用密碼：
            <input name="sPassword" type="password" class="form-control" placeholder="請輸入密碼" id="sPassword">
            <span class="smalltext">請填入5~10個字元以內的英文字母、數字、以及各種符號組合，</span></p>
            <p><font color="#FF0000">*</font>確認密碼：
            <input name="sPasswordrecheck" type="password" class="form-control" placeholder="請確認密碼" id="sPasswordrecheck">
            <span class="smalltext">再輸入一次密碼</span></p>
            <p><font color="#FF0000">*</font>序　　號：
            <input name="sellerID" type="text" class="form-control" placeholder="請輸入序號" id="sellerID">
            <br>
            <hr size="1" />
            <p class="heading">基本資料</p>
            <p><font color="#FF0000">*</font>公司名稱：
            <input name="sName" type="text" class="form-control" placeholder="請輸入公司名稱" id="sName">
            <br>
            <p><label>&nbsp;國　　家</label>：
            <input name="sCountry" type="text" class="form-control" placeholder="請輸入國家" id="sCountry">
            <br>
            
            
            
            <p><font color="#FF0000">*</font>電　　話：
            <input name="sPhone" type="text" class="form-control" placeholder="請輸入電話" id="sPhone">
            <br>
            <p><font color="#FF0000">*</font>信　　箱：
            <input name="sMail" type="text" class="form-control" placeholder="請輸入信箱" id="sMail" size="40"></p>
            <br>
            <p><font color="#FF0000">*</font>地　　址：
            <input name="sAddress" type="text" class="form-control" placeholder="請輸入地址" id="sAddress" size="40">
            <br>
            <p> <font color="#FF0000">*</font> 表示為必填的欄位</p>
          </div>
          <hr size="1" />
          <p align="center">
            <input name="action" type="hidden" id="action" value="join">
            <input type="submit" class="btn btn-danger ml-3 mb-3" name="Submit2" value="送出申請">
            
            <input type="button" class="btn btn-primary ml-3 mb-3" name="Submit" value="回上一頁" onClick="window.history.back();">
          </p>
        </form></td>
        <td width="200">
        <div class="boxtl"></div><div class="boxtr"></div>
        <div class="regbox">
          <p class="heading" align="center"><strong>注意事項：</strong></p>
          <ol>
            <li> 請提供您本人正確、最新及完整的資料。 </li>
            <li> 在欄位後方出現「*」符號表示為必填的欄位。</li>
            <li>填寫時請您遵守各個欄位後方的補助說明。</li>
            <li>關於您的會員註冊以及其他特定資料，本系統不會向任何人出售或出借你所填寫的個人資料。</li>
            <li>在註冊成功後，除了「使用帳號」外您可以在會員專區內修改您所填寫的個人資料。</li>
          </ol>
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