<div id="head">
        <button class="openbtn btn" id='openbtn ' onclick="openNav()">☰ 展開選單</button>
        <!-- <button class='outbtn' id='logout' onclick='logout()'>登出</button> -->
        <form method='post'  class='logout_form' >
            <button type='submit' class='outbtn btn' id='logout' name='logout'>登出</button>
        </form>
        <h3 style="float: right;">Hello, <?php print_r($_SESSION['username']);?></h3>
    </div>