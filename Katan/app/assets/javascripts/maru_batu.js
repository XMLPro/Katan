$(() =>{
var flag = true;

for(var i = 0; i < 10; i ++){
$(".f" +i).click(function(){
	if(flag == true){
	 $(this).text("○");
	 }else{
	 $(this).text("×");
	 }
	 console.log(flag);
});
}


/*$("div").click(function(e){
  $(".elipse").animate({"left": e.clientX , "top":e.pageY}, "100");
});*/

$("div").click(function () {
  $("p").toggle();
  flag = !flag;
});


})
