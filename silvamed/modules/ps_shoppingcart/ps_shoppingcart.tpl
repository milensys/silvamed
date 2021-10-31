{**
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
 *}

<div class="ps_shoppingcart js-dropdown dropdown">
  <a class="shoopingcart-toggle d-flex align-items-center dropdown-toggle" rel="nofollow" href="#" title="{l s='View Cart' d='Shop.Theme.Actions'}" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class="linearicons-bag2" aria-hidden="true"></i>
    <span class="cart-products-label">{l s='Cart' d='Shop.Theme.Checkout'}</span>
    <span class="blockcart" data-refresh-url="{$refresh_url}">
      <span class="cart-products-count">{$cart.products_count}</span>
      <span class="cart-products-count-text"> {if $cart.products_count != 1}{l s='Items' d='Shop.Theme.Checkout'}{else}{l s='Item' d='Shop.Theme.Checkout'}{/if}</span>
    </span>
  </a>
  <div class="dropdown-menu dropdown-menu-right">
    <button type="button" class="dropdown-close close linearicons-cross2"></button>
      <div class="block-cart-body">
        <h2 class="cart-summary-header title-block">{l s='Cart' d='Shop.Theme.Actions'}</h2>
        {if $cart.products}
          <ul id="cart-summary-product-list">
            {foreach from=$cart.products item=product}
              <li class="cart-summary-product-item">
                {include 'module:ps_shoppingcart/ps_shoppingcart-product-line.tpl' product=$product}
              </li>
            {/foreach}
          </ul>
        {else}
          <div class="no-items alert alert-info">{l s='There are no more items in your cart' d='Shop.Theme.Checkout'}</div>
        {/if}
        <div class="cart-subtotals">
          {foreach from=$cart.subtotals item="subtotal"}
            {if isset($subtotal) && $subtotal}
              <div class="cart-{$subtotal.type} d-flex flex-wrap justify-content-between">
                <span class="label">{$subtotal.label}</span>
                <span class="value">{$subtotal.value}</span>
                {if $subtotal.type == 'discount'}
                  {if $cart.vouchers.added}
                    <ul class="list-group mb-2 w-100">
                      {foreach from=$cart.vouchers.added item='voucher'}
                        <li class="list-group-item d-flex flex-wrap justify-content-between">
                          <span>{$voucher.name}({$voucher.reduction_formatted})</span><a data-link-action="remove-voucher" href="{$voucher.delete_url}" class="close" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                          </a>
                        </li>
                      {/foreach}
                    </ul>
                  {/if}
                {/if}
              </div>
            {/if}
          {/foreach}
        </div>
        <div class="cart-total d-flex flex-wrap justify-content-between">
          <strong class="label">{$cart.totals.total.label}</strong>
          <strong class="value">{$cart.totals.total.value}</strong>
        </div>
        <div class="cart-footer mt-3 mt-md-4">
          {if $cart.products}
            <a class="btn btn-default btn-lg d-block px-2" href="{$cart_url}" title="{l s='Proceed to checkout' d='Shop.Theme.Actions'}">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
          {/if}
          <span class="dropdown-close btn btn-secondary btn-lg d-block px-2 mt-2">{l s='Continue shopping' d='Shop.Theme.Actions'}</span>
        </div>
      </div>
  </div>
</div>