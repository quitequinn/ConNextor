function postEmailToServer(name, emailAddress, interest, altinterest) {
    //var emailAddress = document.getElementById("emailInput").value;
    console.log("Called postEmailToServer: " + name + ", " + emailAddress + ", " + interest + ", " + altinterest);

    // do get
    $.get("http://135.0.25.246:2999", {
        name: name,
        email: emailAddress,
        interest: interest,
        altinterest: altinterest
    }, function (data, status) {
        if (status !== 'success') {
            alert("Connection Refused, Please try again.");
        } else if (data === 'true') {
            alert("Email saved");
            // exit sequence
        } else if (data === 'false') {
            alert("Email failed to save");
            // should never happen.
        }
    });
}


//$(".input-upright").keyup(function (e) {
//    if (e.keyCode == 13) {
//        postEmailToServer()
//    }
//});