function throwinmodal_INFO(myid) {
    //Summon modal by Jquery.
    $('#Modal_edit').modal('show');

    var myid = myid.toString();
    // alert('myid');
    // Get datas from ID-labelled table.
    var infoID = myid + "infoID";
    var throw_infoID = document.getElementById(infoID).innerHTML;
    var infoName = myid + "infoName";
    var throw_infoName = document.getElementById(infoName).innerHTML;
    // DATE: need to change format before used!
    var openDate = myid + "openDate";
    var tmp_throw_openDate = document.getElementById(openDate).innerHTML;
    var throw_openDate = tmp_throw_openDate.split(" ");
    // alert(throw_cDate);
    var infoDescrip = myid + "infoDescrip";
    var throw_infoDescrip = document.getElementById(infoDescrip).innerHTML;
   
    // alert(throw_cChecked);

    // Write into Modal.
    document.getElementById('did2').value = throw_infoID;
    document.getElementById('nam2').value = throw_infoName;
    
    document.getElementById('ddp2').value = throw_infoDescrip;
    document.getElementById('opd2').value = throw_openDate;

}

function throwinmodal_DIS(myid) {
    //Summon modal by Jquery.
    $('#Modal_edit').modal('show');

    var myid = myid.toString();
    // alert('myid');
    // Get datas from ID-labelled table.
    var disID = myid + "disID";
    var throw_disID = document.getElementById(disID).innerHTML;
    var disName = myid + "disName";
    var throw_disName = document.getElementById(disName).innerHTML;
    // DATE: need to change format before used!
    var startDate = myid + "startDate";
    var tmp_throw_startDate = document.getElementById(startDate).innerHTML;
    var throw_startDate = tmp_throw_startDate.split(" ");

    var overDate = myid + "overDate";
    var tmp_throw_overDate = document.getElementById(overDate).innerHTML;
    var throw_overDate = tmp_throw_overDate.split(" ");
    // alert(throw_cDate);
    var disDescrip = myid + "disDescrip";
    var throw_disDescrip = document.getElementById(disDescrip).innerHTML;
    var Discount = myid + "Discount";
    var throw_Discount = document.getElementById(Discount).innerHTML;
   
    // alert(throw_cChecked);

    // Write into Modal.
    document.getElementById('did2').value = throw_disID;
    document.getElementById('nam2').value = throw_disName;
    
    document.getElementById('ddp2').value = throw_disDescrip;
    document.getElementById('dct2').value = throw_Discount;
    document.getElementById('std2').value = throw_startDate;
    document.getElementById('ovd2').value = throw_overDate;

}

function throwinmodal_TAL(myid) {
    //Summon modal by Jquery.
    $('#Modal_edit').modal('show');

    var myid = myid.toString();
    // alert('myid');
    // Get datas from ID-labelled table.
    var disID = myid + "disID";
    var throw_disID = document.getElementById(disID).innerHTML;
    var productID = myid + "productID";
    var throw_productID = document.getElementById(productID).innerHTML;
    // DATE: need to change format before used!

    // alert(throw_cDate);
    var disPrice = myid + "disPrice";
    var throw_disPrice = document.getElementById(disPrice).innerHTML;
    
   
    // alert(throw_cChecked);

    // Write into Modal.
    document.getElementById('did2').value = throw_disID;
    document.getElementById('nam2').value = throw_productID;
    
    document.getElementById('ddp2').value = throw_disPrice;
    

}

function throwinmodal_ABC(myid) {
    //Summon modal by Jquery.
    $('#Modal_edit').modal('show');

    var myid = myid.toString();
    // alert('myid');
    // Get datas from ID-labelled table.
    var couponID = myid + "couponID";
    var throw_couponID = document.getElementById(couponID).innerHTML;
    var couponName = myid + "couponName";
    var throw_couponName = document.getElementById(couponName).innerHTML;
    // DATE: need to change format before used!
    var cpendDate = myid + "cpendDate";
    var tmp_throw_cpendDate = document.getElementById(cpendDate).innerHTML;
    var throw_cpendDate = tmp_throw_cpendDate.split(" ");
    // alert(throw_cDate);
    var minus = myid + "minus";
    var throw_minus = document.getElementById(minus).innerHTML;
    var limitation = myid + "limitation";
    var throw_limitation = document.getElementById(limitation).innerHTML;
    var used = myid + "used";
    // var throw_used = document.getElementById(used).innerHTML;
    
   
    // alert(throw_cChecked);

    // Write into Modal.
    document.getElementById('did2').value = throw_couponID;
    document.getElementById('nam2').value = throw_couponName;
    
    document.getElementById('min2').value = throw_minus;
    document.getElementById('lim2').value = throw_limitation;
    document.getElementById('end2').value = throw_cpendDate;
    
    // document.getElementById('ovd2').value = throw_used;
    

}
