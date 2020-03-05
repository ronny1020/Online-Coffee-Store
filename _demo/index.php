<?php
//Source: https://www.tutdepot.com/advanced-php-session-start/
// $expire = the time in seconds until a session have to expire
function start_session($expire = 0)
{
    if ($expire == 0) {
        $expire = ini_get("session.gc_maxlifetime");
    } else {
        ini_set("session.gc_maxlifetime", $expire);
    }
    if (empty($_COOKIE['PHPSESSID'])) {
        session_set_cookie_params($expire);
        session_start();
    } else {
        session_start();
        setcookie("PHPSESSID", session_id(), time() + $expire);
    }
}
session_start();
// start_session(600) will start a session which will expire after 10 minutes (60*10 seconds)

//Return:
//admin  -->0
//seller -->1
//Invalid-->-1
function loginCheck($acc, $pwd)
{
    header("content-type:text/html; charset=utf-8");
    $link = @mysqli_connect("localhost", "root", "") or die(mysqli_connect_error());
    $result = mysqli_query($link, "set names utf8");
    mysqli_select_db($link, "coffee");

    //Seller filter.
    $commandText = "select * from sellers";
    $result = mysqli_query($link, $commandText);
    while ($row = mysqli_fetch_assoc($result)) {
        if ($row['sAccount'] == $acc && password_verify($pwd, $row['sPassword'])) {
            mysqli_close($link);
            $_SESSION["AorS"] = 1;
            return 1;
        } else {
            continue;
        }
    }

    //Admin filter.
    $commandText = "select * from admins";
    $result = mysqli_query($link, $commandText);
    while ($row = mysqli_fetch_assoc($result)) {
        if ($row['aAccount'] == $acc && password_verify($pwd, $row['aPassword'])) {
            mysqli_close($link);
            $_SESSION["AorS"] = 0;
            return 0;
        } else {
            continue;
        }
    }

    //Invalid case:
    mysqli_close($link);
    return -1;
}

$sUserName = "";
$error = "";

//無註冊:

if (isset($_POST["btnOK"])) {
    $sUserName = $_POST["txtacc"];
    $sPassword = $_POST["txtpwd"];
    //密碼加密: 雜湊(hash)
    // $encrypt_pwd = password_hash($sPassword, PASSWORD_BCRYPT);
    //Empty contents shall not pass.
    if ($sPassword !== "" && $sUserName !== "") {
        //檢查登入:
        if (loginCheck($sUserName, $sPassword) >= 0) {
            //If 記得我 ticked:
            if ($_POST['remember'] == true) {
                // $_SESSION['password'] = $sPassword;
                setcookie('password', $sPassword, time() + 60);
                //丟到textbox裡的username
                setcookie('username', $sUserName, time() + 60);
                setcookie('isChecked', 1, time() + 60);
                //測試用: 只記得1分鐘
            } else { // 不用記得我!
                setcookie('password', '');
                setcookie('username', '');
                setcookie('isChecked', 0);
            }
            //驗證登入用的username
            $_SESSION['username'] = $sUserName;
            header('Location: ./works/_main.php');
        } else {
            $error = '帳號或密碼錯誤！';
        }
    } else {
        $error = '密碼或欄位不得為空白。';
        //echo "<script type='text/javascript'>alert('密碼欄位不得為空白。');</script>";
        // header("Refresh:0");
        // header('Location: index.php');
        // exit();
    }
}
?>

<!DOCTYPE html>
<title>管理後台</title>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- include Bootstrap 4: cdn-->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <!-- I edited these stuffs.-->
    <link rel="stylesheet" type="text/css" href="demostyle.css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC|Noto+Serif+TC&display=swap" rel="stylesheet">
    <script src="demoutil.js"></script>
</head>

<body class="login_bg">
    <form method='post' action="index.php" class='login card p-5'>
        <div class="form-group">
            <label for="account">輸入帳號:</label>
            <input type="text" class="form-control" name='txtacc' placeholder="Enter account" id="acc"
             value=<?php if (isset($_COOKIE['username'])) {
    echo $_COOKIE['username'];
}
?>>
        </div>
        <div class="form-group">
            <label for="pwd">輸入密碼:</label>
            <input type="password" class="form-control" name='txtpwd' placeholder="Enter password" id="pwd"
            value=<?php if (isset($_COOKIE['password'])) {
    echo $_COOKIE['password'];
}
?>>
        </div>
        <div class="form-group form-check">
            <!--Remember me: -->
            <label class="form-check-label mycheck">記得我
                <input class="form-check-input" type="checkbox" name='remember'
                       <?php if (isset($_COOKIE["isChecked"]) && $_COOKIE["isChecked"] == 1) {
    echo "checked";}?>><span class="checkmark"></span>
    
            </label><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="./regist/memregist.php">還沒註冊嗎?點我註冊</a></span>
        </div>
        <!--Fake login: -->
        <button type="submit" name="btnOK" class="btn btn-primary">登入</button>
        <span id='error'><?php print_r($error);?></span>
    </form>
</body>
