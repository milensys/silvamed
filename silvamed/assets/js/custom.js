/**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */

/**
 * Init stickUp navigation(menu, search, cart etc)
 */
var stickyLastScrollTop = 0;
$('.sticky-menu').stickUp({
  scrollHide: false,
  disableOn: function(){
    var stickyScrollDir = $(document).scrollTop();
    if (stickyScrollDir < stickyLastScrollTop && stickyScrollDir > window.innerHeight * 0.5){
      $('.sticky-menu').addClass('active');
    } else {
      $('.sticky-menu').removeClass('active');
    }
    stickyLastScrollTop = stickyScrollDir;
    return true;
  }
});

/**
 * Init stickUp sidebars(product page, checkout and other columns)
 */
$(".sidebar").stickUp({
  keepInWrapper: !0,
  topMargin: 20,
  lazyHeight: $(".sticky-menu").outerHeight(),
  wrapperSelector: ".sidebar-wrapper"
});

/**
 * Init to top button(class "enableToTopButton" - activates the toTop button)
 */
if ($('.enableToTopButton').length) {
  $('body').append('<button class="material-scrolltop" type="button"><i class="fa fa-angle-up" aria-hidden="true"></i></button>').materialScrollTop();
}

/**
 * Init features counter
 */
$(function () {
  $('.count').each(function () {
    $(this).prop('Counter', 0).animate({
      Counter: $(this).text()
    }, {
      duration: 4000,
      easing: 'swing',
      step: function (now) {
        $(this).text(Math.ceil(now));
      }
    });
  });
});

/**
 * Init "Accordion" for wysiwyg editor
 */
$('.accordion_current').click(function () {
  if ($(this).hasClass('active')) {
    $(this).removeClass('active');
  } else {
    $(this).addClass('active');
  }
});