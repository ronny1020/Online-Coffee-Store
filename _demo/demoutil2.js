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

    // alert(throw_cDate);
    var infoDescrip = myid + "infoDescrip";
    var throw_infoDescrip = document.getElementById(infoDescrip).innerHTML;
   
    // alert(throw_cChecked);

    // Write into Modal.
    document.getElementById('did2').value = throw_infoID;
    document.getElementById('nam2').value = throw_infoName;
    
    document.getElementById('ddp2').value = throw_infoDescrip;

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

}

