
$(document).ready(function () {
    $('.scroll-to-invite').on('click', function () {
        var scrollPoint = $('#invite').offset().top;
        $('body,html').animate({scrollTop: scrollPoint}, 400);
        return false;
    });

    document.forms['invitation'].onsubmit = function post() {
        var name = document.forms['invitation'].name.value,
            email = document.forms['invitation'].email.value;
            //interest = document.forms['invitation'].interest.value,
            //altinterest = document.forms['invitation'].altinterest.value;
        var title = document.getElementById('form-title');

        postEmailToServer(name, email, null, null);
        $('form[name="invitation"]').fadeOut();
        $('#form-subtext').fadeOut();
        swapWithAltText(title);
        return false;
    };

    //$('#altInterestInput').hide();
    //
    //$('#interestInput').change(function(){
    //    if($('#interestInput').val() == 'other'){
    //        $('#altInterestInput').show();
    //    } else {
    //        $('#altInterestInput').hide();
    //    }
    //});

});

function swapWithAltText(element) {
    element.innerHTML = element.getAttribute('alt');
}

var triggerPad = 150;

$(window).scroll(function () {
    var distFromTop = $(window).scrollTop();
    var viewPortSize = $(window).height();
    $('.fade-in').each(function (i) {
        if (distFromTop >= $(this).offset().top - viewPortSize + triggerPad) {
            $(this).removeClass('fade-in');
            $(this).css('visibility', 'visible').hide().fadeIn();
        }
    })

    //var topDivHeight = $(".topdiv").height();
    //var viewPortSize = $(window).height();
    //
    //var triggerHeight = (topDivHeight - viewPortSize) + triggerAt;
    //
    //if ($(window).scrollTop() >= triggerHeight) {
    //    $('.fadethisdiv').css('visibility', 'visible').hide().fadeIn();
    //    $(this).off('scroll');
    //}
});