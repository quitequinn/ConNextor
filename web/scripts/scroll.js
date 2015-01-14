var numOfSections = 5;
var fadeTime = 1000;
var lightBulbVisible = false;
var currentSection,
	currentDisplayingPicture = 0,
	offset = 0.5;
	
var canvas = document.getElementById('myCanvas');
var context = canvas.getContext('2d');	
$(document).ready(function(){
});


$(window).scroll(function () {
	var distanceFromTop = $(window).scrollTop(),
		windowHeight = $(window).height();
	currentSection = distanceFromTop / windowHeight;
	//console.log('Currently in: ' + currentSection + ' (int): ' + parseInt(currentSection));

	// prevent light bulb from loading first.
	if (!lightBulbVisible) {
		$(".light-bulb")[0].style.visibility = "visible";
		lightBulbVisible = true;
	}

	if (Math.abs(currentSection - currentDisplayingPicture) > offset) {
		changeSection(Math.round(currentSection));
		//drawLine($(window).width()/2.5,200, $(window).width()/2.5+160, 200);
		$("#section1").css("position","fixed"); 
		//drawLine($(window).width()/2.5,500, $(window).width()/2.5+160, 500);
	}

});

function drawLine(startX,startY,endX,endY){
	var amount = 0;
	setInterval(function() {
		amount += 0.05; 
		if (amount > 1) amount = 1;
		context.clearRect(0, 0, canvas.width, canvas.height);
		context.strokeStyle = "black";
		context.moveTo(startX, startY);
		context.lineTo(startX + (endX - startX) * amount, startY + (endY - startY) * amount);
		context.lineWidth=2;
		context.stroke();
	}, 30);
}


function changeSection(newPicture) {
	if (currentDisplayingPicture == newPicture) return;
	//console.log('changed to ' + newPicture);

	//if (currentDisplayingPicture) { // is not zero
	//	document.getElementsByClassName()
	//}

	document.getElementById("light_bulb_image").className = "light_bulb_image"+(newPicture);
	$("#light_bulb_image_container").hide().fadeIn(fadeTime);
	$("#section"+newPicture+"text").fadeIn(fadeTime);
	currentDisplayingPicture = newPicture;
	
}

