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

prestashop.responsive = prestashop.responsive || {};

prestashop.responsive.current_width = window.innerWidth;

prestashop.responsive.min_width = 768;
prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;

prestashop.responsive.min_tablet_width = 1780;
prestashop.responsive.tablet = prestashop.responsive.current_width < prestashop.responsive.min_tablet_width;

toggleTabletStyles();
toggleMobileStyles();

$(window).on('resize', function () {
  var _cw = prestashop.responsive.current_width;
  var _mwt = prestashop.responsive.min_tablet_width;
  var _mw = prestashop.responsive.min_width;
  var _w = window.innerWidth;

  var _toggle_tablet = (_cw >= _mwt && _w < _mwt) || (_cw < _mwt && _w >= _mwt);
  var _toggle = (_cw >= _mw && _w < _mw) || (_cw < _mw && _w >= _mw);

  prestashop.responsive.current_width = _w;
  prestashop.responsive.tablet = prestashop.responsive.current_width < prestashop.responsive.min_tablet_width;
  prestashop.responsive.mobile = prestashop.responsive.current_width < prestashop.responsive.min_width;

  if (_toggle_tablet) {
    toggleTabletStyles();
  }
  if (_toggle) {
    toggleMobileStyles();
  }
});

function swapChildren(obj1, obj2) {
  var temp = obj2.children().detach();
  obj2.empty().append(obj1.children().detach());
  obj1.append(temp);
}

function toggleMobileStyles() {
  if (prestashop.responsive.mobile) {
    $("*[class*='desktop_for_']").each(function (idx, el) {
      var target = $(('.' + el.className.match(/desktop_for_(\S+)/i)).replace('desktop_for_', 'mobile_for_'));
      if (target.length) {
        swapChildren($(el), target);
      }
    });
    $("*[id^='_desktop_']").each(function (idx, el) {
      var target = $('#' + el.id.replace('_desktop_', '_mobile_'));
      if (target.length) {
        swapChildren($(el), target);
      }
    });
  } else {
    $("*[class*='mobile_for_']").each(function (idx, el) {
      var target = $(('.' + el.className.match(/mobile_for_(\S+)/i)).replace('mobile_for_', 'desktop_for_'));
      if (target.length && target[0].children.length === 0) {
        swapChildren($(el), target);
      }
    });
    $("*[id^='_mobile_']").each(function (idx, el) {
      var target = $('#' + el.id.replace('_mobile_', '_desktop_'));
      if (target.length && target[0].children.length === 0) {
        swapChildren($(el), target);
      }
    });
  }

  prestashop.emit('responsive update', {
    mobile: prestashop.responsive.mobile
  });
}

function toggleTabletStyles() {
  if (prestashop.responsive.tablet) {
    $("*[class*='tablet_up_']").each(function (idx, el) {
      let target = $(('.' + el.className.match(/tablet_up_(\S+)/i)).replace('tablet_up_', 'tablet_down_'));
      if (target.length) {
        swapChildren($(el), target);
      }
    });
  } else {
    $("*[class*='tablet_down_']").each(function (idx, el) {
      let target = $(('.' + el.className.match(/tablet_down_(\S+)/i)).replace('tablet_down_', 'tablet_up_'));
      if (target.length && target[0].children.length === 0) {
        swapChildren($(el), target);
      }
    });
  }

  prestashop.emit('responsive update', {
    tablet: prestashop.responsive.tablet
  });
}

