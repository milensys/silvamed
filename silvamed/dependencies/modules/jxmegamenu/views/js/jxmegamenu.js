/*
* 2017-2019 Zemez
*
* JX Mega Menu
*
* NOTICE OF LICENSE
*
* This source file is subject to the General Public License (GPL 2.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/GPL-2.0
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade the module to newer
* versions in the future.
*
* @author     Zemez (Alexander Grosul)
* @copyright  2017-2019 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*/

var responsiveflagJXMenu = false;
var JxCategoryMenu = $('ul.jxmegamenu');
var JxCategoryGrover = $('.default-menu .menu-title');

$(document).ready(function(){
	JxCategoryMenu = $('ul.jxmegamenu');
	JxCategoryGrover = $('.default-menu .menu-title');
	setColumnClean();
	responsiveJxMenu();
	$(window).resize(responsiveJxMenu);
});

// check resolution
function responsiveJxMenu()
{
   if ($(document).width() <= 767 && responsiveflagJXMenu == false)
	{
		menuChange('enable');
		responsiveflagJXMenu = true;
	}
	else if ($(document).width() >= 768)
	{
		menuChange('disable');
		responsiveflagJXMenu = false;
	}
}

function JxdesktopInit()
{
	JxCategoryGrover.off();
	JxCategoryGrover.removeClass('active');
	$('.jxmegamenu > li > ul, .jxmegamenu > li > ul.is-simplemenu ul, .jxmegamenu > li > div.is-megamenu').removeClass('menu-mobile').parent().find('.menu-mobile-grover').remove();
	$('.jxmegamenu').removeAttr('style');
	JxCategoryMenu.superfish('init');
	//add class for width define
	$('.jxmegamenu > li > ul').addClass('submenu-container clearfix');
    $(".top-level-menu-li-span").each(function() {
        if($(this).parent().children().length > 1) {
            $(this).addClass('sf-with-ul');
        }
    });
}

function JxmobileInit()
{
	var JxclickEventType=((document.ontouchstart!==null)?'click':'touchstart');
	JxCategoryMenu.superfish('destroy');
	$('.jxmegamenu').removeAttr('style');

	JxCategoryGrover.on(JxclickEventType, function(e){
		$(this).toggleClass('active').parent().find('ul.jxmegamenu').stop().slideToggle('medium');
		return false;
	});

	$('.jxmegamenu > li > ul, .jxmegamenu > li > div.is-megamenu, .jxmegamenu > li > ul.is-simplemenu ul').addClass('menu-mobile clearfix').parent().prepend('<span class="menu-mobile-grover"></span>');

	$(".jxmegamenu .menu-mobile-grover").on(JxclickEventType, function(e){
		var catSubUl = $(this).next().next('.menu-mobile');
		if (catSubUl.is(':hidden'))
		{
			catSubUl.slideDown();
			$(this).addClass('active');
		}
		else
		{
			catSubUl.slideUp();
			$(this).removeClass('active');
		}
		return false;
	});

	$('.default-menu > ul:first > li > a, .block_content > ul:first > li > a').on(JxclickEventType, function(e){
		var parentOffset = $(this).prev().offset(); 
	   	var relX = parentOffset.left - e.pageX;
		if ($(this).parent('li').find('ul').length && relX >= 0 && relX <= 20)
		{
			e.preventDefault();
			var mobCatSubUl = $(this).next('.menu-mobile');
			var mobMenuGrover = $(this).prev();
			if (mobCatSubUl.is(':hidden'))
			{
				mobCatSubUl.slideDown();
				mobMenuGrover.addClass('active');
			}
			else
			{
				mobCatSubUl.slideUp();
				mobMenuGrover.removeClass('active');
			}
		}
	});

    $(".top-level-menu-li-span").each(function() {
        if($(this).parent().children().length > 1) {
            $(this).removeClass('sf-with-ul');
        }
    });
}

// change the menu display at different resolutions
function menuChange(status)
{
	status == 'enable' ? JxmobileInit(): JxdesktopInit();
}
function setColumnClean()
{
	$('.jxmegamenu div.is-megamenu > div').each(function(){
		i = 1;
       	$(this).children('.megamenu-col').each(function(index, element) {
           if(i % 3 == 0)
		   {
                $(this).addClass('first-in-line-sm');
		   }
			i++; 
        });
    });	
}