$(document).ready(function(){
    $('.loader').hide();
    $('.container').show();
});
function err(){
    var swl = new swal;
    swal.fire("Error","Yor Email or password can't be empty","error") 
}
function succ() {
    var uname = $('#username').val();
    var pass = $('#password').val();
    $.ajax({
        url: "/APIs/login",
        method: "GET",
        data: { username: uname, password: pass },
        success: function (response) {
            if (response.code == 1) {
                swal.fire("login successflluy", "Redircting..", "success");
                window.location.href = "/Views/contact";
            }
            else {
                swal.fire("Something went wrong", "wrong username or password", "error");

            }
        }, error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log(JSON.stringify(XMLHttpRequest));
            console.log("text " + textStatus);
            console.log("error " + errorThrown);
        }
    });
}