<?php
$sUserName = "";
$error = "";

?>

<div id="mySidebar" class="sidebar">
    <div class="sidebar_bg"></div>

    <div class="sidebar_context">
        <img src="../image/sidebar-head.jpg" alt="sidebar-head" class="sidebar-head" width="250px">

        <p href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</p>
    <!-- Add welcome message here. -->
        <p class="hello">Hello, <?php print_r($_SESSION['username']);?></p>
        <form method='post'  class='logout_form' >
        <button type='submit' class='outbtn btn' id='logout' name='logout'>登出</button>
        </form>
        <br><br><hr>
        <?php if ($_SESSION['AorS'] === 0) {?>
            <!-- Collapsible bar here. -->
            <a class='triangle_title' type="button" data-toggle="collapse" data-target="#member">
                會員管理<div class="triangle_rotate">▶</div></a>
            <div id="member" class="collapse">
            <a href="members.php">會員資料</a>
            <a href="cram.php">客訴內容</a>
            </div>
            <a class='triangle_title' href="sellers.php">廠商管理<div class="triangle_rotate">▶</div></a>
        <?php } elseif ($_SESSION['AorS'] === 1) {?>
            
            <a class='triangle_title' type="button" data-toggle="collapse" data-target="#regist">
               資料管理<div class="triangle_rotate">▶</div></a>
            <div id="regist" class="collapse">
            <a href="../regist/memupdate.php">修改資料</a>
            <a href="../works/infomations.php">訊息管理</a>
            <a href="../works/discounts.php">優惠活動管理</a>
            <a href="../works/discount_detail.php">優惠細節管理</a>
            </div>

            <a class='triangle_title' type="button" data-toggle="collapse" data-target="#order">
               訂單管理<div class="triangle_rotate">▶</div></a>
            <div id="order" class="collapse">
            <a href="../works/orders.php">訂單內容</a>
            <a href="../works/orders_detail.php">訂單細節</a>    
            </div>
            
            <a href="../works/products.php">商品管理</a>
            
            
            
<?php }?>
    </div>



</div>
