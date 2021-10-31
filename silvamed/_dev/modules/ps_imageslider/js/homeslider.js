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

var psImageSlider = new Swiper('#ps-image-slider', {
  autoplay: {
    delay: $('#ps-image-slider').attr('data-autoplay')
  },
  loop: $('#ps-image-slider').data('loop'),
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
    type: 'bullets'
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev'
  }
});

if ($('#ps-image-slider').attr('data-pause')) {
  $('#ps-image-slider').off('mouseenter').on('mouseenter', function () {
    if ('ontouchstart' in document.documentElement) {
      return;
    } else {
      psImageSlider.autoplay.stop();
    }
  });
  $('#ps-image-slider').off('mouseleave').on('mouseleave', function () {
    psImageSlider.autoplay.start();
  });
}