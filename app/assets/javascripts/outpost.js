function postEmailToServer(name, emailAddress, interest, altinterest, source, altsource, callback) {
    //var emailAddress = document.getElementById("emailInput").value;
    console.log("Called postEmailToServer: " + name + ", " + emailAddress + ", " + interest + ", " + altinterest + "," + source + "," + altsource);

    // do get
    $.get("http://135.0.25.246:2999", {
        name: name,
        email: emailAddress,
        interest: interest,
        altinterest: altinterest,
        source: source,
        altsource: altsource
    }, function (data, status) {
        if (status !== 'success') {
            alert("Connection Refused, Please try again.");
        } else if (data === 'true') {
            callback();
            // exit sequence
        } else if (data === 'false') {
            alert("Email failed to save");
            // should never happen.
        }
    });
}
