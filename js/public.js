jQuery(function(){
//选项卡滑动切换通用
jQuery(function(){jQuery(".hoverTag .chgBtn").hover(function(){jQuery(this).parent().find(".chgBtn").removeClass("chgCutBtn");jQuery(this).addClass("chgCutBtn");var cutNum=jQuery(this).parent().find(".chgBtn").index(this);jQuery(this).parents(".hoverTag").find(".chgCon").hide();jQuery(this).parents(".hoverTag").find(".chgCon").eq(cutNum).show();})})

//选项卡点击切换通用
jQuery(function(){jQuery(".clickTag .chgBtn").click(function(){jQuery(this).parent().find(".chgBtn").removeClass("chgCutBtn");jQuery(this).addClass("chgCutBtn");var cutNum=jQuery(this).parent().find(".chgBtn").index(this);jQuery(this).parents(".clickTag").find(".chgCon").hide();jQuery(this).parents(".clickTag").find(".chgCon").eq(cutNum).show();})})

$(".ser_int").focus(function(){
	if($(".ser_int").val()=="请输入关键词"){$(this).val("")}
	});
$(".ser_int").blur(function(){
	if($(".ser_int").val()==""){$(this).val("请输入关键词")}
	});
	
$(".Rlay li").hover(function(){$(this).find(".Rlay_show").fadeIn(200)},function(){$(this).find(".Rlay_show").fadeOut(200)});
$(window).scroll(function(){
if($(document).scrollTop()>10){
	$(".mbackTop").fadeIn(200);
}else{
	$(".mbackTop").fadeOut(200);
}
});
$(".mbackTop").click(function(){$("body,html").animate({"scrollTop":0},300)});
$(".mc1_tab tr:not('.mc1_th'):even").find("td").css("background","#fff");

var lhobj=$(".m2L").height();
var rhobj=$(".m2R").height();
if(lhobj>rhobj){
	$(".m2R").height(lhobj);
}else{
	$(".m2L").height(rhobj);
}

//二级菜单.attr("href","javascript:void(-1)")
for(i=0; i<$(".m2menu li").size(); i++){
	if($(".m2menu li").eq(i).find("dd").size()>0){
		$(".m2menu li").eq(i).find(".m2menu_a1").addClass("m2menu_a2");
	}
}
$(".m2menu_a1").click(function(){
	if($(this).next("dl").css('display')=='block'){
		$(".m2menu dl").slideUp(200);
	}else{
		$(".m2menu dl").slideUp(200);$(this).next("dl").slideDown(200);
	}
	
	//$(".m2menu dl").slideUp(200);$(this).next("dl").slideDown(200);
	//$(".m2menu_a1").removeClass("m2menu_cuta1");$(this).addClass("m2menu_cuta1");
	});
	
$(".m2imgPage li:nth-child(3n)").addClass("m2img_even");
$(".m2imgPage li").hover(function(){$(".m2imgPage li").css("z-index",0);$(this).css("z-index",10);$(this).find(".m2imgLay").show();},function(){$(this).find(".m2imgLay").hide();});

//2014-09-01
$(".navBox li").hover(function(){$(this).addClass("nav_hoverLi");},function(){$(this).removeClass("nav_hoverLi");});

})
//屏蔽页面错误
jQuery(window).error(function(){
  return true;
});
jQuery("img").error(function(){
  $(this).hide();
});
