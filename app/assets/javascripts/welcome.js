
// Add event listener when buttons are clicked
function scrollToInvitation() {
    var scrollPoint = $('#invite').offset().top;
    $('body,html').animate({scrollTop: scrollPoint}, 400);
    return false;
}

// Form submit listener
function postInviteToRemote(inviteForm) {
    var name = inviteForm.name.value,
        email = inviteForm.email.value;
    //interest = inviteForm.interest.value,
    //altinterest = inviteForm.altinterest.value;
    //    source = inviteForm.source.value,
    //    altsource = inviteForm['source-alt'].value;

    // validation
    var invalid = false;
    $('form[name="invitation"] input[name="name"]').removeClass("input-warning-glow");
    $('form[name="invitation"] input[name="email"]').removeClass("input-warning-glow");
    if (name == null
        || name === "") {
        invalid = true;
        $('form[name="invitation"] input[name="name"]').addClass("input-warning-glow");
    }
    if (email == null
        || email === ""
        || !email.contains("@")
        || !email.contains(".")
        || email.contains(" ")) {
        invalid = true;
        $('form[name="invitation"] input[name="email"]').addClass("input-warning-glow");
    }
    if (invalid) return false;

    var title = document.getElementById('form-title');
    postEmailToServer(name, email, "", "", "", "", function () {
        $('form[name="invitation"]').fadeOut();
        $('#form-subtext').fadeOut();
        swapWithAltText(title);
    });
    return false;
}

// Form alternative field
function changeFormAlternativeField() {
    if(this.value == 'friend'){
        $('form[name="invitation"] input[name="source-alt"]').prop('disabled', true);
        $('form[name="invitation"] input[name="source-alt"]').val('');
        document.forms['invitation']['source-alt'].placeholder = "";
    } else {
        $('form[name="invitation"] input[name="source-alt"]').prop('disabled', false);
        if (this.value == 'other') {
            document.forms['invitation']['source-alt'].placeholder = "Please Specify";
        } else {
            document.forms['invitation']['source-alt'].placeholder = "Which " + this.value + "?";
        }
    }
}

// Swaps an element's innerHTML with the value of its alt attribute
function swapWithAltText(element) {
    element.innerHTML = element.getAttribute('alt');
}

var triggerPad = 150;

// Fades in elements when they are first seen
function fadeInSectionImages() {
    var distFromTop = $(window).scrollTop();
    var viewPortSize = $(window).height();
    //console.log("distFromTop: " + distFromTop + ", "
                //+ "viewPortSize: " + viewPortSize);
    $('.fade-in').each(function (i) {
        if (distFromTop >= $(this).offset().top - viewPortSize + triggerPad) {
            $(this).removeClass('fade-in');
            $(this).css('visibility', 'visible').hide().fadeIn();
        }
    });
}
