
function toggle_finalists() {
	Element.toggle('finalists');
  if (Element.visible('finalists')) {
		Element.update('toggle_finalists','hide');
		Element.writeAttribute('toggle_finalists', 'flag', 'hide')
	}
	else {
		Element.update('toggle_finalists','show');
		Element.writeAttribute('toggle_finalists', 'flag', 'show')
	}
}

function set_finalists() {
	var toggle_text = Element.readAttribute('toggle_finalists', 'flag')
	if (toggle_text == "hide") {
		Element.toggle('finalists')
	}
}

/*********************
//* jQuery Multi Level CSS Menu (horizontal)- By Dynamic Drive DHTML code library: http://www.dynamicdrive.com
//* Menu instructions page: http://www.dynamicdrive.com/dynamicindex1/ddlevelsmenu/
//* Last modified: Sept 6th, 08'. Usage Terms: http://www.dynamicdrive.com/style/csslibrary/tos/
*********************/

//Specify full URL to down and right arrow images (25 is padding-right to add to top level LIs with drop downs):
var arrowimages={down:['downarrowclass', 'arrow-down.gif', 25], right:['rightarrowclass', 'arrow-right.gif']}

var jquerycssmenu={

fadesettings: {overduration: 350, outduration: 100}, //duration of fade in/ out animation, in milliseconds

buildmenu:function(menuid, arrowsvar){
	jQuery(document).ready(function($){
		var $mainmenu=$("#"+menuid+">ul")
		var $headers=$mainmenu.find("ul").parent()
		$headers.each(function(i){
			var $curobj=$(this)
			var $subul=$(this).find('ul:eq(0)')
			this._dimensions={w:this.offsetWidth, h:this.offsetHeight, subulw:$subul.outerWidth(), subulh:$subul.outerHeight()}
			this.istopheader=$curobj.parents("ul").length==1? true : false
			$subul.css({top:this.istopheader? this._dimensions.h+"px" : 0})
			$curobj.children("a:eq(0)").css(this.istopheader? {paddingRight: arrowsvar.down[2]} : {}).append(
				'<img src="'+ (this.istopheader? arrowsvar.down[1] : arrowsvar.right[1])
				+'" class="' + (this.istopheader? arrowsvar.down[0] : arrowsvar.right[0])
				+ '" style="border:0;" />'
			)
			$curobj.hover(
				function(e){
					var $targetul=$(this).children("ul:eq(0)")
					this._offsets={left:$(this).offset().left, top:$(this).offset().top}
					var menuleft=this.istopheader? 0 : this._dimensions.w
					menuleft=(this._offsets.left+menuleft+this._dimensions.subulw>$(window).width())? (this.istopheader? -this._dimensions.subulw+this._dimensions.w : -this._dimensions.w) : menuleft
					$targetul.css({left:menuleft+"px"}).fadeIn(jquerycssmenu.fadesettings.overduration)
				},
				function(e){
					$(this).children("ul:eq(0)").fadeOut(jquerycssmenu.fadesettings.outduration)
				}
			) //end hover
		}) //end $headers.each()
		$mainmenu.find("ul").css({display:'none', visibility:'visible'})
	}) //end document.ready
}
}

//build menu with ID="myjquerymenu" on page:
jquerycssmenu.buildmenu("myjquerymenu", arrowimages)