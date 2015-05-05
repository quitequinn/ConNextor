// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require undefined_prototypes
//= require private_pub
//= require_tree .

Turbolinks.enableProgressBar();

// Fade out loading screen when page is loaded
function fadeOutLoadingScreen() {
  // Loading screen fadeout
  $('.loading-screen').fadeOut();
}

function hidePopUps() {
  var popUps = document.getElementsByClassName('pop-up-container');
  Array.prototype.forEach.call(popUps, function (element) {
    element.style.display = 'none';
  });
}

function toggleLogInPopUp() {
  var popUp = document.getElementById('pop-up-container');
  if (popUp.style.display == null || popUp.style.display == '' || popUp.style.display == 'none') {
    popUp.style.display = 'table';
  } else {
    popUp.style.display = 'none';
  }
}

// Log-in Pop-up

function hideLogInPopUp() {
  var popUp = document.getElementById('log-in-pop-up-container');
  popUp.style.display = 'none';
}

function showLogInPopUp() {
  var popUp = document.getElementById('log-in-pop-up-container');
  popUp.style.display = 'table';
}

// Sign-up Pop-up

function hideSignUpPopUp() {
  var popUp = document.getElementById('sign-up-pop-up-container');
  popUp.style.display = 'none'
}

function showSignUpPopUp() {
  var popUp = document.getElementById('sign-up-pop-up-container');
  popUp.style.display = 'table'
}

function switchLogInForSignUpPopUp() {
  hidePopUps();
  showSignUpPopUp();
}

function switchSignUpForRequest() {
  hidePopUps();
  scrollToInvitation();
}

function logthatshit() {
  // implement name change, and escape too.
  console.log('I HVAE BEEN TOUCHED');
}
