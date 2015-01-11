$(document).ready(function(){
    start();

});

$(window).scroll(function() {
    if($(window).scrollTop() + $(window).height() > $(document).height()/2) {
        console.log("hi");
    }
});

function start(){
    $("#lightbulb").fadeIn(3000);
}