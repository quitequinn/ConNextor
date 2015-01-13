var numOfSections=5;
var adjustment=120;
var section=$(document).height()/numOfSections;
var trackSection;
var fadeTime=2000;
var seen=[numOfSections];

$(document).ready(function(){
	start();
});

$(window).scroll(function() {
   console.log(trackSection);
   if($(window).scrollTop() > ($(window).height())*(trackSection)-adjustment) {
	 console.log("changed!");
	 changeSection();
	 trackSection+=1;
   }
   else{
	   if (($(window).height())*(trackSection)-$(window).scrollTop()>$(window).height()*1.5){
			console.log("up!");
			trackSection-=2;
			if (trackSection<1){
				trackSection=1;
			}
			changeSection();
		}
	}
});

function changeSection(){
    document.getElementById("light_bulb_image").className = "light_bulb_image"+(trackSection);
	$("#light_bulb_image_container").hide().fadeIn(fadeTime);
}

function start(){
	for (i = 0; i < seen.length; i++) {
		seen[i]=false;
	}
	trackSection=1;
}


// Function taken from http://stackoverflow.com/questions/487073/check-if-element-is-visible-after-scrolling

function isScrolledIntoView(elem) {
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    //return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
    return ((docViewTop < elemTop) && (docViewBottom > elemBottom));
}




