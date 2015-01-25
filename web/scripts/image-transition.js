


$(window).scroll(function () {
    var distanceFromTop = $(window).scrollTop(),
        windowHeight = $(window).height();



    // prevent light bulb from loading first.
    if (!lightBulbVisible) {
        $(".light-bulb")[0].style.visibility = "visible";
        lightBulbVisible = true;
    }


    if (Math.abs(currentSection - currentDisplayingPicture) > offset) {
        changeSection(Math.round(currentSection));
        //drawLine($(window).width()/2.5,200, $(window).width()/2.5+160, 200);
        //$("#section1").css("position","fixed");
        //drawLine($(window).width()/2.5,500, $(window).width()/2.5+160, 500);
    }
});