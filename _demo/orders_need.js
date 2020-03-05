

// Lightweight version by LEE.(0303)
// 1. 更改table使各欄位附加上id
// 2. onclick button觸發函數讀值進入modal
// 3. submit之後送出update MySql


//  myid 指的是從 onclick="throwinmodal_orders(<?php echo "'".$row['OrderID']."'"?>)" 抓到的這個嗎?
//   Y    /     N       =>


function throwinmodal_orders(myid) {
    //Summon modal by Jquery.
    $('#MyEdit').modal('show');

    var myid = myid.toString();
    // alert('myid');
    // Get datas from ID-labelled table.
    var OrderID = myid + "OrderID";
    var throw_OrderID = document.getElementById(OrderID).innerHTML;
    var CustomerID = myid + "CustomerID";
    var throw_CustomerID = document.getElementById(CustomerID).innerHTML;


    // DATE: need to change format before used!
    var OrderDate = myid + "OrderDate";
    var tmp_throw_OrderDate = document.getElementById(OrderDate).innerHTML;
    var throw_OrderDte = tmp_throw_OrderDate.split(" ");

    var ShippedDate = myid + "ShippedDate";
    var tmp_throw_ShippedDate = document.getElementById(ShippedDate).innerHTML;
    var throw_ShippedDate = tmp_throw_ShippedDate.split(" ");



    // alert(throw_OrderDate,    throw_ShippedDate);      原本寫的 alert(throw_Date) 代表的是?? 
    var ShipAddress = myid + "ShipAddress";
    var throw_ShipAddress = document.getElementById(ShipAddress).innerHTML;

    var ShipRegion = myid + "ShipRegion";
    var throw_ShipRegion = document.getElementById(ShipRegion).innerHTML;

    var ShipPostCode = myid + "ShipPostCode";
    var throw_ShipPostCode = document.getElementById(ShipPostCode).innerHTML;

    var ShipCity = myid + "ShipCity";
    var throw_ShipCity = document.getElementById(ShipCity).innerHTML;

    var ShipCountry = myid + "ShipCountry";
    var throw_ShipCountry = document.getElementById(ShipCountry).innerHTML;





    // alert(throw_cChecked);     為啥 cramContent   沒被丟掉??

    // Write into Modal.    為啥 throw_cDate[0]??
    document.getElementById('oid_e').value = throw_OrderID;
    document.getElementById('cid_e').value = throw_CustomerID;
    document.getElementById('OrderD_e').value = throw_OrderDte[0];
    document.getElementById('ShippedD_e').value = throw_ShippedDate[0];



    document.getElementById('ShippedA_e').value = throw_ShipAddress;
    document.getElementById('ShipR_e').value = throw_ShipRegion;
    document.getElementById('ShipPost_e').value = throw_ShipPostCode;
    document.getElementById('ShipCity_e').value = throw_ShipCity;
    document.getElementById('ShipCountry_e').value = throw_ShipCountry;


}

// function throwinmodal_MEMBERS(myid) {
//     //Summon modal by Jquery.
//     $('#Modal_edit').modal('show');

//     var myid = myid.toString();
//     // alert('myid');
//     // Get datas from ID-labelled table.
//     var customerID = myid + "customerID";
//     var throw_customerID = document.getElementById(customerID).innerHTML;
//     var cName = myid + "cName";
//     var throw_cName = document.getElementById(cName).innerHTML;
//     var cAccount = myid + "cAccount";
//     var throw_cAccount = document.getElementById(cAccount).innerHTML;
//     var cPassword = myid + "cPassword";
//     var throw_cPassword = document.getElementById(cPassword).innerHTML;
//     var cSex = myid + "cSex";
//     var throw_cSex = document.getElementById(cSex).innerHTML;

//     var cBirthDate = myid + "cBirthDate";
//     var tmp_throw_cBirthDate = document.getElementById(cBirthDate).innerHTML;
//     var throw_cBirthDate = tmp_throw_cBirthDate.split(" ");
//     // alert(throw_cBirthDate);
//     let cAddress = myid + "cAddress";
//     var throw_cAddress = document.getElementById(cAddress).innerHTML;
//     let cMobile = myid + "cMobile";
//     var throw_cMobile = document.getElementById(cMobile).innerHTML;

//     // Write into Modal.
//     document.getElementById('cid_e').value = throw_customerID;
//     document.getElementById('nam_e').value = throw_cName;
//     document.getElementById('acc_e').value = throw_cAccount;
//     document.getElementById('pwd_e').value = throw_cPassword;
//     document.getElementById('sex_e').value = throw_cSex;
//     document.getElementById('bid_e').value = throw_cBirthDate[0];
//     document.getElementById('adr_e').value = throw_cAddress;
//     document.getElementById('mob_e').value = throw_cMobile;

// }

// // function from lee ended here. (0303)



// //create form for create or edit in products

// //for Creating & Appending element & give attribute in the same time


// HTMLElement.prototype.CreateAppend = function(element, context, ...attr) {
//     e = document.createElement(element)
//     if (context != undefined) {
//         e.innerHTML = context;
//     }

//     if (attr[0] != undefined) {
//         for (let i = 0; i < attr.length; i += 2) {
//             e.setAttribute(attr[i], attr[i + 1]);
//         }
//     }
//     this.appendChild(e);
// }

// function create_edit_close() {
//     create_edit_window.removeChild(create_edit_context)
//     create_edit_window.setAttribute("class", "window_close");
// }


// function create_edit(ID) {

//     create_edit_window.setAttribute("class", "window_open");
//     create_edit_window.CreateAppend("form", "", "class", "card border-0", "id", "create_edit_context", "method", "post")
//     create_edit_context.CreateAppend("p", "x", "class", "closebtn", "onclick", "create_edit_close()")

//     if (ID == undefined) {
//         create_edit_context.CreateAppend("h2", "新增：", "id", "form-head", "class", "card-header bg-color-gold")
//         create_edit_context.CreateAppend("div", "", "class", "card-body bg-color-Paper  p-5", "id", "create_edit_form")
//         ProductNameInner = "";
//         categoryNameInner = 0;
//         UnitPriceInner = "";
//         UnitsInStockInner = "";
//         specificationInner = "";
//         descriptionInner = "";
//         submit_name = "create_data";
//         submit_value = "新增";
//     } else {
//         ID = ID.toString();
//         ID = "0".repeat(10 - ID.length) + ID;
//         create_edit_context.CreateAppend("h2", "修改：", "id", "form-head", "class", "card-header bg-color-gold")
//         create_edit_context.CreateAppend("div", "", "class", "card-body bg-color-Paper  p-5", "id", "create_edit_form")
//         create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "ProductID_ce")
//         ProductID_ce.CreateAppend("label", "產品ID：", "class", "form-control-label", "for", "ProductID_input")
//         ProductID_ce.CreateAppend("input", "", "type", "text", "value", ID, "class", "form-control", "id", "ProductID_input", "name", "ProductID_input", "readonly")

//         // name
//         ProductNameID = ID + "ProductName";
//         ProductNameInner = document.getElementById(ProductNameID).innerHTML
//             // category
//         categoryNameID = ID + "categoryName";
//         categoryNameInner = document.getElementById(categoryNameID).innerHTML
//             // UnitPrice
//         UnitPriceID = ID + "UnitPrice";
//         UnitPriceInner = document.getElementById(UnitPriceID).innerHTML.replace(",", "")
//             // UnitsInStock
//         UnitsInStockID = ID + "UnitsInStock";
//         UnitsInStockInner = document.getElementById(UnitsInStockID).innerHTML.replace(",", "")
//             // specification
//         specificationID = ID + "specification";
//         specificationInner = document.getElementById(specificationID).innerHTML
//             // description
//         descriptionID = ID + "description";
//         descriptionInner = document.getElementById(descriptionID).innerHTML

//         submit_name = "edit_data";
//         submit_value = "修改";
//     }

//     // name
//     // create_edit_form.CreateAppend("div", "", "id", "create_edit")
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "ProductName_ce")
//     ProductName_ce.CreateAppend("label", "產品名稱：", "class", "form-control-label", "for", "ProductName_input")
//     ProductName_ce.CreateAppend("input", "", "type", "text", "value", ProductNameInner, "class", "form-control", "id", "ProductName_input", "name", "ProductName_input", "required")
//     ProductName_ce.CreateAppend("div", "Valid.", "class", "valid-feedback")
//     ProductName_ce.CreateAppend("div", "Please fill out this field.", "class", "invalid-feedback")
//         // category
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "categoryName_ce")
//     categoryName_ce.CreateAppend("label", "產品類型：", "class", "form-control-label", "for", "categoryName_select")
//     categoryName_ce.CreateAppend("select", "", "class", "form-control", "id", "categoryName_select", "name", "categoryName_select", "required")
//     categoryName_select.CreateAppend("option", "未選", "value", "", "id", "categoryID_select0")
//     categoryName_select.CreateAppend("option", "咖啡豆", "value", "1", "id", "categoryID_select1")
//     categoryName_select.CreateAppend("option", "即溶咖啡", "value", "2", "id", "categoryID_select2")
//     categoryName_select.CreateAppend("option", "咖啡膠囊", "value", "3", "id", "categoryID_select3")
//     categoryName_select.CreateAppend("option", "濾掛包", "value", "4", "id", "categoryID_select4")
//     categoryName_select.CreateAppend("option", "濾紙", "value", "5", "id", "categoryID_select5")
//     categoryName_select.CreateAppend("option", "烘培機", "value", "6", "id", "categoryID_select6")
//     categoryName_select.CreateAppend("option", "磨豆機", "value", "7", "id", "categoryID_select7")
//     categoryName_select.CreateAppend("option", "咖啡機", "value", "8", "id", "categoryID_select8")
//     switch (categoryNameInner) {
//         case '咖啡豆':
//             categoryID_select1.selected = true;
//             break;
//         case '即溶咖啡':
//             categoryID_select2.selected = true;
//             break;
//         case '咖啡膠囊':
//             categoryID_select3.selected = true;
//             break;
//         case '濾掛包':
//             categoryID_select4.selected = true;
//             break;
//         case '濾紙':
//             categoryID_select5.selected = true;
//             break;
//         case '烘培機':
//             categoryID_select6.selected = true;
//             break;
//         case '磨豆機':
//             categoryID_select7.selected = true;
//             break;
//         case '咖啡機':
//             categoryID_select8.selected = true;
//             break;
//         default:
//             categoryID_select0.selected = true;

//     }

//     // UnitPrice
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "UnitPrice_ce")
//     UnitPrice_ce.CreateAppend("label", "單價：", "class", "form-control-label", "for", "UnitPrice_input")
//     UnitPrice_ce.CreateAppend("input", "", "type", "number", "value", UnitPriceInner, "class", "form-control", "id", "UnitPrice_input", "name", "UnitPrice_input", "required")
//         // UnitsInStock
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "UnitsInStock_ce")
//     UnitsInStock_ce.CreateAppend("label", "庫存：", "class", "form-control-label", "for", "UnitsInStock_input")
//     UnitsInStock_ce.CreateAppend("input", "", "type", "number", "value", UnitsInStockInner, "class", "form-control", "id", "UnitsInStock_input", "name", "UnitsInStock_input", "required")
//         // specification
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "specification_ce")
//     specification_ce.CreateAppend("label", "規格：", "class", "form-control-label", "for", "specification_input")
//     specification_ce.CreateAppend("textarea", specificationInner, "type", "number", "class", "form-control", "id", "specification_input", "name", "specification_input")

//     // description
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "description_ce")
//     description_ce.CreateAppend("label", "介紹：", "class", "form-control-label", "for", "description_input")
//     description_ce.CreateAppend("textarea", descriptionInner, "type", "number", "class", "form-control", "id", "description_input", "name", "description_input")


//     // tags
//     create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "tags_ce")
//     tags_ce.CreateAppend("label", "Tags:", "class", "form-control-label")
//     tags_ce.CreateAppend("br")
//     if (document.getElementById(ID + "tag0") != null) {
//         tags_ce.CreateAppend("p", "(請勾選想刪除的TAG，將於送出時刪除)")
//     }
//     for (i = 0; true; i++) {
//         ProductTagID = ID + "tag" + i.toString();

//         if (document.getElementById(ProductTagID) != null) {
//             tagContext = document.getElementById(ProductTagID).innerHTML
//             tags_ce.CreateAppend("input", "", "type", "checkbox", "name", tagContext, "id", tagContext)
//             tags_ce.CreateAppend("label", tagContext, "for", tagContext)
//             tags_ce.CreateAppend("br")
//         } else {

//             break;
//         }
//     }
//     tags_ce.CreateAppend("div", "", "id", "createTagArea");
//     newTagNumber = 0;
//     tags_ce.CreateAppend("input", "", "type", "button", "value", "新增TAG欄位", "class", "btn bg-color-gold m-3", "onclick", "createNewTag()");
//     tags_ce.CreateAppend("input", "", "type", "button", "value", "刪除TAG欄位", "class", "btn bg-color-gold m-3", "onclick", "deleteNewTag()");
//     // footer submit
//     create_edit_context.CreateAppend("div", "", "class", "card-footer bg-color-Paper", "id", "create_edit_footer");
//     create_edit_footer.CreateAppend("input", "", "type", "submit", "class", "btn btn-primary", "value", submit_value, "name", submit_name, "onclick", `return confirm('你確定要${submit_value}資料嗎？')`);
//     create_edit_footer.CreateAppend("input", "", "type", "button", "class", "btn btn-danger ml-3", "value", "取消", "onclick", "create_edit_close()");


// }

// function createNewTag() {
//     newTagNo = "newTag" + newTagNumber.toString();
//     newTagNumber++;
//     createTagArea.CreateAppend("div", "", "class", "input-group mb-3", "id", newTagNo);
//     document.getElementById(newTagNo).CreateAppend("div", "", "class", "input-group-prepend", "id", newTagNo + "inner");
//     document.getElementById(newTagNo + "inner").CreateAppend("span", "#", "class", "input-group-text");
//     document.getElementById(newTagNo).CreateAppend("input", "", "class", "form-control", "type", "text", "name", newTagNo);
// }

// function deleteNewTag() {
//     if (newTagNumber > 0) {
//         newTagNumber--;
//         newTagNo = "newTag" + newTagNumber.toString();
//         document.getElementById(newTagNo).remove();
//     }
// }