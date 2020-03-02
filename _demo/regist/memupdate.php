<?php
session_start();
include("connMysql.php");
error_reporting(0);
$username=$_SESSION['username'];
$findID=mysqli_query($db_link,"select sellerID from coffee.sellers WHERE sAccount='$username';");
$findNA=mysqli_query($db_link,"select sName from coffee.sellers WHERE sAccount='$username';");
$findPW=mysqli_query($db_link,"select sPassword from coffee.sellers WHERE sAccount='$username';");
$findPH=mysqli_query($db_link,"select sPhone from coffee.sellers WHERE sAccount='$username';");
$findAD=mysqli_query($db_link,"select sAddress from coffee.sellers WHERE sAccount='$username';");
$findMA=mysqli_query($db_link,"select sMail from coffee.sellers WHERE sAccount='$username';");
$findCT=mysqli_query($db_link,"select sCountry from coffee.sellers WHERE sAccount='$username';");

$ID = mysqli_fetch_assoc($findID);
$NA = mysqli_fetch_assoc($findNA);
$PW = mysqli_fetch_assoc($findPW);
$PH = mysqli_fetch_assoc($findPH);
$AD = mysqli_fetch_assoc($findAD);
$MA = mysqli_fetch_assoc($findMA);
$CT = mysqli_fetch_assoc($findCT);

$userID = $ID["sellerID"];
$name = $NA["sName"];
$password = $PW["sPassword"];
$phone = $PH["sPhone"];
$address = $AD["sAddress"];
$mail = $MA["sMail"];
$country = $CT["sCountry"];
    




$MyName=$_POST["sName"];
$MyPhone=$_POST["sPhone"];
$MyPassword=$_POST["sPassword"];
$MyAddress=$_POST["sAddress"];
$MyMail=$_POST["sMail"];
$MyCountry=$_POST["sCountry"];
$sql_query = "UPDATE sellers SET sName='$MyName', sPassword='$MyPassword', sPhone='$MyPhone', sAddress='$MyAddress', sMail='$MyMail', sCountry='$MyCountry' WHERE sellerID='$userID' ";   
$stmt = $db_link -> prepare($sql_query);
$stmt -> execute();
$stmt -> close();
$db_link -> close();



?>



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>註冊資訊修改系統</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript">

</script>
</head>

<body>
<table width="780" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td class="tdbline"><img src="images/mlogo.png" alt="會員系統" width="164" height="67"></td>
  </tr>
  <tr>
    <td class="tdbline"><table width="100%" border="0" cellspacing="0" cellpadding="10">
      <tr valign="top">
        <td class="tdrline"><form action="" method="POST" name="formJoin" id="formJoin" onSubmit="return checkForm();">
          <p class="title">修改註冊資料</p>
          <div class="dataDiv">
            <hr size="1" />
            <p class="heading">帳號資料</p>
            <p><strong>使用帳號</strong>：<?php echo $userID;?></p>
            <p><strong>使用密碼</strong>：
            <input name="sPassword" type="password" class="normalinput" id="sPassword">
    		<input name="sPasswordo" type="hidden" id="sPasswordo" value="<?php echo $password;?>"></p>
            <p><strong>確認密碼</strong> ：
            <input name="sPasswordrecheck" type="password" class="normalinput" id="sPasswordrecheck"><br>
            <span class="smalltext">若不修改密碼，請不要填寫。若要修改，請輸入密碼</span><span class="smalltext">二次。<br>若修改密碼，系統會自動登出，請用新密碼登入。</span></p>
            <hr size="1" />
            <p class="heading">廠商資料</p>
            <p><strong>公司名稱</strong>：
            <input name="sName" type="text" class="normalinput" id="sName" value="<?php echo $name;?>">
            <font color="#FF0000">*</font></p>
            <p><strong>國　　家</strong>：
            <input name="sCountry" type="text" class="normalinput" id="sCountry" value="<?php echo $country;?>">
            <font color="#FF0000">*</font></p>
           
            <p><strong>電　　話</strong>：
            <input name="sPhone" type="text" class="normalinput" id="sPhone" value="<?php echo $phone;?>">
            <font color="#FF0000">*</font></p>
            <p><strong>信　　箱</strong>：
            <input name="sMail" type="text" class="normalinput" id="sMail" value="<?php echo $mail;?>" size="40"></p>
            <p><strong>地　　址</strong>：
            <input name="sAddress" type="text" class="normalinput" id="sAddress" value="<?php echo $address;?>" size="40">
            <font color="#FF0000">*</font></p>
            <p><font color="#FF0000">*</font> 表示為必填的欄位</p>
          </div>
          <hr size="1" />
          <p align="center">
            <input name="m_id" type="hidden" id="m_id" value="<?php echo $row_RecMember["m_id"];?>">
            <input name="action" type="hidden" id="action" value="update">
            <input type="submit" name="Submit2" value="修改資料">
            <input type="button" name="Submit" value="回上一頁" onClick="window.history.back();">
          </p>
        </form></td>
        <td width="200">
        <div class="boxtl"></div><div class="boxtr"></div>
        <div class="regbox">
          <p class="heading"><strong>會員系統</strong></p>
          
            <p><strong><?php echo $name;?></strong> 您好。</p>
            
            本次登入的日期為：<br>
            <?php echo date("Y年m月d日") ;?></p>
            <p align="center"><a href="../works/_main.php">回到主頁</a> | <a href="../index.php">登出系統</a></p>
        </div>
        <div class="boxbl"></div><div class="boxbr"></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="center" background="images/album_r2_c1.jpg" class="trademark">© 2016 eHappy Studio All Rights Reserved.</td>
  </tr>
</table>
</body>
</html>