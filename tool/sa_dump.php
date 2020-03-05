<?php

$s_pwds = array('pwd01', 'pwd02', 'pwd03', 'pwd04', 'pwd05', 'pwd06');
$hashed_pwds=array('','','','','','');
for ($i = 0; $i < count($s_pwds); $i++) {
    $hashed_pwds[$i] = password_hash($s_pwds[$i], PASSWORD_BCRYPT);
    print_r($hashed_pwds[$i] . "<br>");
}
?>
