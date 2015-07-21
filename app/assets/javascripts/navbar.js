$(document).ready(function() {
    $(".nav-ind").mouseenter( function (e) {
        $(e.target).addClass('underline'); 
        });
    $(".nav-ind").mouseleave( function (e) {
         $(e.target).removeClass('underline');
    });
});
