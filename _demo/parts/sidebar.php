<?php 
$sUserName = "";
$error = "";

?>

<div id="mySidebar" class="sidebar">
<!-- Add welcome message here. -->
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>


<?php if ($_SESSION['AorS'] === 0) { ?>
    <a href="members.php">會員管理</a>   
    <a href="sellers.php">廠商管理</a> 
<?php } elseif ($_SESSION['AorS'] === 1) {  ?>
    <a href="../regist/memregist.php">註冊</a> 
    <a href="../regist/memupdate.php">會員資料管理</a> 
    <a href="orders.php">訂單管理</a>
    <a href="products.php">商品管理</a>
    <a href="infomations.php">訊息管理</a>
    <a href="actions.php">活動管理</a>
    <a href="discounts.php">優惠管理</a>
<?php  } ?>
</div>
