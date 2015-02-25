
$(document).ready(function () {
    // Loading screen fadeout
    $('.loading-screen').fadeOut();

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
            source = document.forms['invitation'].source.value;

        var title = document.getElementById('form-title');

        postEmailToServer(name, email, null, null, source);
        $('form[name="invitation"]').fadeOut();
        $('#form-subtext').fadeOut();
        swapWithAltText(title);
        return false;
    };
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
    $('.fade-in').each(function (i) {
        if (distFromTop >= $(this).offset().top - viewPortSize + triggerPad) {
            $(this).removeClass('fade-in');
            $(this).css('visibility', 'visible').hide().fadeIn();
        }
    });
});
