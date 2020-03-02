// document.getElementById('error').innerHTML = '';
function openCloseNav() {
    check = document.getElementById("mySidebar").getAttribute("class")
    if (check == "sidebar") {
        openNav();
    } else {
        closeNav();
    }
}


function openNav() {
    document.getElementById("mySidebar").setAttribute("class", "sidebar sidebar_open");
    document.getElementById("head").style.transform = "translateX(250px)";
    // Hide button, show sidebar.
    // document.getElementById('openbtn').style.display = 'none';
    // document.getElementById('mySidebar').style.display = '';
}

function closeNav() {
    document.getElementById("mySidebar").setAttribute("class", "sidebar");
    document.getElementById("head").style.transform = "translateX(0px)";
    //Show button, hide sidebar.
    // document.getElementById('openbtn').style.display = '';
    // document.getElementById('mySidebar').style.display = 'none';
}

//Negligible. Not used.
function logout() {
    //php SESSION =/= JS sessionStorage!
    // sessionStorage.clear();
    // sessionStorage.removeItem('username');
    // sessionStorage.removeItem('AorS');
    location.href = 'index.php';
}

//Negligible. Not used.
function dummyLogin(strACC, strPWD) {
    var strACC = String(strACC);
    const strAdmin = 'admin';
    const strSeller = 'seller';
    if (strPWD == '') {
        alert('Password is empty!');
        return null;
    }
    if (strACC.indexOf(strAdmin) !== -1) {
        //write username to file.
        location.href = 'index_admin.html';
    } else if (strACC.indexOf(strSeller) !== -1) {
        //write username to file.
        location.href = 'index_seller.html';
    } else {
        alert('Invalid account!');
        return null;
    }
}

//select All
function selectAllCheckbox() {
    let checkboxes = document.querySelectorAll('input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = selectAll.checked;
    }
}



//create form for create or edit in products

//for Creating & Appending element & give attribute in the same time


HTMLElement.prototype.CreateAppend = function(element, context, ...attr) {
    e = document.createElement(element)
    if (context != undefined) {
        e.innerHTML = context;
    }

    if (attr[0] != undefined) {
        for (i = 0; i < attr.length; i += 2) {
            e.setAttribute(attr[i], attr[i + 1]);

        }
        this.appendChild(e);
    }
}

function create_edit_close() {
    create_edit_window.removeChild(create_edit_form)
    create_edit_window.setAttribute("class", "window_close");
}


function create_edit(ID) {

    create_edit_window.setAttribute("class", "window_open");
    create_edit_window.CreateAppend("form", "", "class", "card p-5", "id", "create_edit_form")
    create_edit_form.CreateAppend("p", "x", "class", "closebtn", "onclick", "create_edit_close()")

    if (ID == undefined) {
        create_edit_form.CreateAppend("h2", "新增：", "id", "form-head", "class", "mb-5")

        ProductNameInner = "";
        categoryNameInner = 0;
        UnitPriceInner = "";
        UnitsInStockInner = "";
        specificationInner = "";

        submit_type = "create";
    } else {
        ID = ID.toString();
        ID = "0".repeat(10 - ID.length) + ID;
        create_edit_form.CreateAppend("h2", "修改：", "id", "form-head", "class", "mb-5")

        create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "ProductID_ce")
        ProductID_ce.CreateAppend("label", "ProductID:", "class", "form-control-label", "for", "ProductID_input")
        ProductID_ce.CreateAppend("input", "", "type", "text", "value", ID, "class", "form-control", "id", "ProductID_input", "name", "ProductID_input", "disabled")
            // name
        ProductNameID = ID + "ProductName";
        ProductNameInner = document.getElementById(ProductNameID).innerHTML
            // category
        categoryNameID = ID + "categoryName";
        categoryNameInner = document.getElementById(categoryNameID).innerHTML
            // UnitPrice
        UnitPriceID = ID + "UnitPrice";
        UnitPriceInner = document.getElementById(UnitPriceID).innerHTML.replace(",", "")
            // UnitsInStock
        UnitsInStockID = ID + "UnitsInStock";
        UnitsInStockInner = document.getElementById(UnitsInStockID).innerHTML.replace(",", "")
            // specification
        specificationID = ID + "specification";
        specificationInner = document.getElementById(specificationID).innerHTML
        console.log(specificationInner);
        // description
        descriptionID = ID + "description";
        descriptionInner = document.getElementById(descriptionID).innerHTML


        submit_type = "edit";
    }
    // name
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "ProductName_ce")
    ProductName_ce.CreateAppend("label", "ProductName:", "class", "form-control-label", "for", "ProductName_input")
    ProductName_ce.CreateAppend("input", "", "type", "text", "value", ProductNameInner, "class", "form-control", "id", "ProductName_input", "name", "ProductName_input")
        // category
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "categoryName_ce")
    categoryName_ce.CreateAppend("label", "categoryName:", "class", "form-control-label", "for", "categoryName_select")
    categoryName_ce.CreateAppend("select", "", "class", "form-control", "id", "categoryName_select", "name", "categoryName_select")
    categoryName_select.CreateAppend("option", "未選", "value", "0", "id", "categoryID_select0")
    categoryName_select.CreateAppend("option", "咖啡豆", "value", "1", "id", "categoryID_select1")
    categoryName_select.CreateAppend("option", "即溶咖啡", "value", "2", "id", "categoryID_select2")
    categoryName_select.CreateAppend("option", "咖啡膠囊", "value", "3", "id", "categoryID_select3")
    categoryName_select.CreateAppend("option", "濾掛包", "value", "4", "id", "categoryID_select4")
    categoryName_select.CreateAppend("option", "濾紙", "value", "5", "id", "categoryID_select5")
    categoryName_select.CreateAppend("option", "烘培機", "value", "6", "id", "categoryID_select6")
    categoryName_select.CreateAppend("option", "磨豆機", "value", "7", "id", "categoryID_select7")
    categoryName_select.CreateAppend("option", "咖啡機", "value", "8", "id", "categoryID_select8")
    switch (categoryNameInner) {
        case '咖啡豆':
            categoryID_select1.selected = true;
            break;
        case '即溶咖啡':
            categoryID_select2.selected = true;
            break;
        case '咖啡膠囊':
            categoryID_select3.selected = true;
            break;
        case '濾掛包':
            categoryID_select4.selected = true;
            break;
        case '濾紙':
            categoryID_select5.selected = true;
            break;
        case '烘培機':
            categoryID_select6.selected = true;
            break;
        case '磨豆機':
            categoryID_select7.selected = true;
            break;
        case '咖啡機':
            categoryID_select8.selected = true;
            break;
        default:
            categoryID_select0.selected = true;

    }

    // UnitPrice
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "UnitPrice_ce")
    UnitPrice_ce.CreateAppend("label", "UnitPrice:", "class", "form-control-label", "for", "UnitPrice_input")
    UnitPrice_ce.CreateAppend("input", "", "type", "number", "value", UnitPriceInner, "class", "form-control", "id", "UnitPrice_input", "name", "UnitPrice_input")
        // UnitsInStock
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "UnitsInStock_ce")
    UnitsInStock_ce.CreateAppend("label", "UnitPrice:", "class", "form-control-label", "for", "UnitsInStock_input")
    UnitsInStock_ce.CreateAppend("input", "", "type", "number", "value", UnitsInStockInner, "class", "form-control", "id", "UnitsInStock_input", "name", "UnitsInStock_input")
        // specification
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "specification_ce")
    specification_ce.CreateAppend("label", "specification:", "class", "form-control-label", "for", "specification_input")
    specification_ce.CreateAppend("textarea", specificationInner, "type", "number", "value", specificationInner, "class", "form-control", "id", "specification_input", "name", "specification_input")

    // description
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "description_ce")
    description_ce.CreateAppend("label", "description:", "class", "form-control-label", "for", "description_input")
    description_ce.CreateAppend("textarea", "", "type", "number", "value", descriptionInner, "class", "form-control", "id", "description_input", "name", "description_input")





    // tags
    create_edit_form.CreateAppend("div", "", "class", "form-group", "id", "tags_ce")
    tags_ce.CreateAppend("label", "tags:", "class", "form-control-label")

    for (i = 0; i < true; i++) {
        ProductTagID = ID + "tag" + i.toString();

        if (document.getElementById(ProductTagID) != null) {
            tagContext = document.getElementById(ProductTagID).innerHTML
            tags_ce.CreateAppend("input", "", "type", "checkbox", "name", tagContext)
            tags_ce.CreateAppend("p", tagContext)
            console.log(tagContext);
        } else {
            break;
        }

    }
    //Rotate target when clicked.(0302, lee)

    function rotateTarget(strid) {
        let target = getElementById(strid).innerHTML;

    }