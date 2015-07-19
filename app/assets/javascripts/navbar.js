// $(".nav-ind").on("click",function(){
//    var button = $(this);
//    var contentDiv= $("#contentDiv");
//   if (button.val() == "Bold"){
//     contentDiv.css("font-weight","bold");
//     button.val("UnBold");
//   } else {
//       contentDiv.css("font-weight","normal");
//        button.val("Bold");
//  }
// });​

$("#tabs").tabs({
    create: function(event, ui){
        $(this).tabs({'select': $(this).find("ul").index($(this).find('a[href="' + window.location.hash + '"]').parent())});
    },
    activate: function(event, ui){
        window.location.hash = $(ui.newTab[0]).find('a[href^="#Tab"]').attr("href");
    }
});