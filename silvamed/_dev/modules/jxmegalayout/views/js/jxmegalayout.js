/**
 * 2017-2020 Zemez
 *
 * JX Mega Layout
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
 *  @author    Zemez (Alexander Grosul & Alexander Pervakov)
 *  @copyright 2017-2020 Zemez
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */

$('[id*="jxml-slider-"]').each(function () {
  var swiperOptions = $(this).data('options');
  var jxmlSlider = new Swiper($(this).find('.jxml-swiper-container'), swiperOptions);
});

$('.custom-tabs').each(function () {
  var navLink = $(this).find('.custom-tab-links > div');
  var navContent = $(this).find('.custom-tab-contents > div');
  $(navLink).on('click', function (e) {
    var eventItem = $(e.currentTarget);
    eventItem.addClass('active').siblings().removeClass('active');
    navContent.removeClass('active').eq($(this).index()).addClass('active');
  });
});