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

$(document).ready(function () {
  prestashop.blockcart = prestashop.blockcart || {};
  prestashop.blockcart.ajax = true;

  var showModal = prestashop.blockcart.showModal || function (modal) {
    $('body').append(modal);
    $('#blockcart-modal').modal('show').on('hidden.bs.modal', function () {
      $('#blockcart-modal').remove();
    });
  };

  $(document).ready(function () {
    $(document).on('click', '#product .product-add-to-cart .add-to-cart', function (e) {
      $(e.target).addClass('loading');
    });
    prestashop.on(
      'updateCart',
      function (event) {
        var refreshURL = $('.blockcart').data('refresh-url');
        var requestData = {};

        if (event && event.reason) {
          requestData = {
            id_product_attribute: event.reason.idProductAttribute,
            id_product: event.reason.idProduct,
            action: event.reason.linkAction
          };
        }

        $.post(refreshURL, requestData).then(function (resp) {
          $('.blockcart').replaceWith($(resp.preview).find('.blockcart'));
          $('.block-cart-body').replaceWith($(resp.preview).find('.block-cart-body'));
          if (resp.modal) {
            showModal(resp.modal);
          }
          $('#product .product-add-to-cart .add-to-cart').removeClass('loading');
        }).fail(function (resp) {
          prestashop.emit('handleError', {eventType: 'updateShoppingCart', resp: resp});
        });
      }
    );
  });
});
