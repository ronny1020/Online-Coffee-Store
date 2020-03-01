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