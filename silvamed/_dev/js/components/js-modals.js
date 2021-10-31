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

export default class JsModals {
  constructor(el) {
    this.el = el;
  }
  init() {
    this.el.click(function () {
      let self = $(this);
      let jsModal = $('.' + self.attr('class').match(/js-modal-(\S+)/i)[1]);
      let jsModalPosition =  self.attr('class').match(/position-(\S+)/i) !== null ? self.attr('class').match(/position-(\S+)/i)[1] : '';
      let jsModalSize =  self.attr('class').match(/size-(\S+)/i) !== null ? self.attr('class').match(/size-(\S+)/i)[1] : '';
      let jsModalDestroy =  self.attr('class').match(/destroy-up-(\S+)/i) !== null ? self.attr('class').match(/destroy-up-(\S+)/i)[1] : false;
      jsModal.addClass('modal fade ' + jsModalPosition).wrapInner('<div class="modal-dialog ' + jsModalSize + '"><div class="modal-content"><div class="modal-body">')
        .modal('show')
        .on('hidden.bs.modal', function () {
          jsModal.removeAttr('style aria-hidden').removeClass('modal fade ' + jsModalPosition).find('.modal-body').children().unwrap('<div class="modal-body">').unwrap('<div class="modal-content">').unwrap('<div class="modal-dialog">');
        });
      $(window).resize(function() {
        if (jsModalDestroy && (window.innerWidth > jsModalDestroy)) {
          jsModal.modal('hide');
        }
      });
    });
  }
}
