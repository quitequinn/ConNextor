var numOfSections = 5;
var fadeTime = 1000;

var lightBulbVisible = false;
var currentSection,
	currentDisplayingPicture = 0,
	offset = 0.5;


$(window).scroll(function () {
	var distanceFromTop = $(window).scrollTop(),
		windowHeight = $(window).height();
	currentSection = distanceFromTop / windowHeight;
	console.log('Currently in: ' + currentSection + ' (int): ' + parseInt(currentSection));

	// prevent light bulb from loading first.
	if (!lightBulbVisible) {
		$(".light-bulb")[0].style.visibility = "visible";
		lightBulbVisible = true;
	}

	if (Math.abs(currentSection - currentDisplayingPicture) > offset) {
		changeSection(Math.round(currentSection));
	}

});

function changeSection(newPicture) {
	if (currentDisplayingPicture == newPicture) return;
	console.log('changed to ' + newPicture);

	//if (currentDisplayingPicture) { // is not zero
	//	document.getElementsByClassName()
	//}

	document.getElementById("light_bulb_image").className = "light_bulb_image"+(newPicture);
	$("#light_bulb_image_container").hide().fadeIn(fadeTime);
	$("#section"+newPicture+"text").fadeIn(fadeTime);
	currentDisplayingPicture = newPicture;
	
}

