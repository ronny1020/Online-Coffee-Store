<?php
$sUserName = "";
$error = "";

?>

<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<!-- 

若要改圖示，請至https://www.w3schools.com/icons/fontawesome5_icons_business.asp
把	fas fa-XXXXX 改成對應的代碼 

-->


<div id="mySidebar" class="sidebar">
    <!-- <div class="sidebar_bg"></div> -->

    <div class="sidebar_content">
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
            <i class='fas  fa-address-book w-25 text-center small'></i>會員管理<div class="triangle_rotate">▶</div></a>
            <div id="member" class="collapse">
            <a href="members.php"><i class='fas fa-address-card w-25 text-center small'></i>會員資料</a>
            <a href="cram.php"><i class='fas fa-phone-volume w-25 text-center small'></i>客訴內容</a>
            </div>
            <a class='triangle_title' href="sellers.php"><i class='fas fa-coffee w-25 text-center small'></i>廠商管理
            <!-- <div class="triangle_rotate">▶</div> -->
        </a>
        <?php } elseif ($_SESSION['AorS'] === 1) {?>

            <a class='triangle_title' type="button" data-toggle="collapse" data-target="#regist">
            <i class='fas fa-sitemap w-25 text-center small'></i>資料管理<div class="triangle_rotate">▶</div></a>
            <div id="regist" class="collapse">
            <a href="../regist/memupdate.php"><i class='fas fa-marker w-25 text-center small'></i>修改資料</a>
            <a href="../works/infomations.php"><i class='fas  fa-tasks w-25 text-center small'></i>訊息管理</a>
            <a href="../works/discounts.php"><i class='fas fa-bullhorn w-25 text-center small'></i>優惠活動管理</a>
            <a href="../works/discount_detail.php"><i class='fas fa-stream w-25 text-center small'></i>優惠細節管理</a>
            </div>

            <!-- <a class='triangle_title' type="button" data-toggle="collapse" data-target="#order">
                <i class='fas fa-clipboard w-25 text-center small'></i>訂單管理<div class="triangle_rotate">▶</div></a>
            <div id="order" class="collapse">
                <a href="../works/orders.php"><i class='fas fa-copy w-25 text-center small'></i>訂單內容</a>
                <a href="../works/orders_detail.php"><i class='fas fa-glasses w-25 text-center small'></i>訂單細節</a>
            </div> -->

            <a href="../works/products.php"><i class='fas fa-tags w-25 text-center small'></i>商品管理</a>



<?php }?>
    </div>



</div>
