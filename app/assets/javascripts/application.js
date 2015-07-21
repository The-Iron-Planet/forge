// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require moment
//= require jquery_ujs
//= require_tree .
//= require jquery-ui
//= require dialog
//= require navbar
//= require magnific-popup.min.js


// var header = document.getElementById("#dir-header");
// var searchbox = document.getElementById("#search-box");
// var stuck = false;
// var stickPoint = header.offsetTop;
// getDistance();

// function getDistance() {
//   var topDist = header.offsetTop;
//   return topDist;
// }

// window.onscroll = function(e) {
//   var distance = getDistance() - window.pageYOffset;
//   var offset = window.pageYOffset;
//   readout.innerHTML = stickPoint + '   ' + distance + '   ' + offset + '   ' + stuck;
//   if ( (distance <= 0) && !stuck) {
//     header.style.position = 'fixed';
//     header.style.top = '0px';
//     stuck = true;
//   } else if (stuck && (offset <= stickPoint)){
//     header.style.position = 'static';
//     stuck = false;
//   }
// }

$(function () {
  $('.collapse-card').paperCollapse()
})
