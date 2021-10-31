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

import './components/responsive';
import 'bootstrap';
import 'flexibility';
import 'bootstrap-touchspin';
import 'jquery-range';
import 'stickUp';
import 'material-scrolltop';

import './partials/checkout';
import './partials/customer';
import './partials/listing';
import './partials/cart';

import './components/block-cart';
import Form from './components/form';
import JsModals from './components/js-modals';
import DropDown from './components/drop-down';
import UniversalCarousel from './components/carousels';

import EventEmitter from 'events';

// "inherit" EventEmitter
for (var i in EventEmitter.prototype) {
  prestashop[i] = EventEmitter.prototype[i];
}

$(document).ready(() => {
  const form = new Form();
  const jsModals = new JsModals($('[class*=js-modal-]'));
  const dropDown = new DropDown($('.js-dropdown'));
  const universalCarousel = new UniversalCarousel($('[class*="u-carousel"]'));
  form.init();
  jsModals.init();
  dropDown.init();
  universalCarousel.init();

  // Init Tooltips
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
});