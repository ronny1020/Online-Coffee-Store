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
    <a href="orders.php">訂單管理</a>
    <a href="products.php">商品管理</a>
    <a href="#">資料管理</a> 
    <a href="discount.php">行銷管理</a>
<?php  } ?>
</div>
