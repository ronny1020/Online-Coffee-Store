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
        <hr>
        <?php if ($_SESSION['AorS'] === 0) {?>
            <!-- Collapsible bar here. -->
            <a class='triangle_title' type="button" data-toggle="collapse" data-target="#member"
               onclick="rotateTarget('triangle_rotate')">
                會員管理<div class="triangle_rotate">▶</div></a>
            <div id="member" class="collapse">
            <a href="members.php">會員資料</a>
            <a href="cram.php">客訴內容</a>
            </div>
            <!-- collapse bar end here. -->
            <a class='triangle_title' href="sellers.php">廠商管理<div class="triangle_rotate">▶</div></a>
        <?php } elseif ($_SESSION['AorS'] === 1) {?>
            
            <a href="../regist/memupdate.php">資料管理</a>
            <a href="orders.php">訂單管理</a>
            <a href="products.php">商品管理</a>
            <a href="infomations.php">訊息管理</a>
            <a href="actions.php">活動管理</a>
            <a href="discounts.php">優惠管理</a>
<?php }?>
    </div>



</div>
