
$(document).ready(function () {
    // Add event listener when
    $('.scroll-to-invite').on('click', function () {
        var scrollPoint = $('#invite').offset().top;
        $('body,html').animate({scrollTop: scrollPoint}, 400);
        return false;
    });

    // Form submit listener
    document.forms['invitation'].onsubmit = function post() {
        var name = document.forms['invitation'].name.value,
            email = document.forms['invitation'].email.value,
            //interest = document.forms['invitation'].interest.value,
            //altinterest = document.forms['invitation'].altinterest.value;
            source = document.forms['invitation'].source.value,
            altsource = document.forms['invitation']['source-alt'].value;

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
        postEmailToServer(name, email, "", "", source, altsource);
        $('form[name="invitation"]').fadeOut();
        $('#form-subtext').fadeOut();
        swapWithAltText(title);
        return false;
    };

    $('form[name="invitation"] select[name="source"]').change(function(){
        if(this.value == 'friend'){
            $('form[name="invitation"] input[name="source-alt"]').prop('disabled', true);
            $('form[name="invitation"] input[name="source-alt"]').val('');
        } else {
            $('form[name="invitation"] input[name="source-alt"]').prop('disabled', false);
            if (this.value == 'other') {
                document.forms['invitation']['source-alt'].placeholder = "Please Specify";
            } else {
                document.forms['invitation']['source-alt'].placeholder = "Which " + this.value + "?";
            }
        }
    });
});

// Swaps an element's innerHTML with the value of its alt attribute
function swapWithAltText(element) {
    element.innerHTML = element.getAttribute('alt');
}

var triggerPad = 150;

// Fades in elements when they are first seen
$(window).scroll(function () {
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
});
