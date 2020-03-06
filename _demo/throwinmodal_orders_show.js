// Lightweight version by LEE.(0303)
// 1. 更改table使各欄位附加上id
// 2. onclick button觸發函數讀值進入modal
// 3. submit之後送出update MySql


//  myid 指的是從 onclick="throwinmodal_orders(<?php echo "'".$row['OrderID']."'"?>)" 抓到的這個嗎?
//   Y    /     N       =>


function throwinmodal_orders_show(details_show) {
    //Summon modal by Jquery.
    $('#Orders_Detail_Show').modal('show');

    var details_show = details_show.toString();
    alert(details_show);
    // Get datas from ID-labelled table.
    var OrderID = details_show + "OrderID";
    var throw_OrderID = document.getElementById(OrderID).innerHTML;
    var ProductID = details_show + "ProductID";
    var throw_ProductID = document.getElementById(ProductID).innerHTML;
    var Quantity = details_show + "Quantity";
    var throw_Quantity = document.getElementById(Quantity).innerHTML;
    var Discount = details_show + "Discount";
    var throw_Discount = document.getElementById(Discount).innerHTML;


    // Write into Modal.   
    document.getElementById('oid_d_e').value = throw_OrderID;
    document.getElementById('pid_d_e').value = throw_ProductID;
    document.getElementById('Quan_d_e').value = throw_Quantity;
    document.getElementById('Dis_d_e').value = throw_Discount;




}
