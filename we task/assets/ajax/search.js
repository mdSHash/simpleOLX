function search() {
    var search = $('#search').val();
    $.ajax({
        url: "/APIs/search",
        method: "POST",
        data: { token: search },
        success: function (response) {
            if (response.code == 1) {
                alert(response.data);
                swal.fire("login successflluy", "Redircting..", "success");
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