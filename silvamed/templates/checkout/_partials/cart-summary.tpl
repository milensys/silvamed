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

<section id="js-checkout-summary" class="js-cart cart-summary" data-refresh-url="{$urls.pages.cart}?ajax=1&action=refresh">
  {block name='hook_checkout_summary_top'}
    {hook h='displayCheckoutSummaryTop'}
  {/block}

  {block name='cart_summary_products'}
    <div class="cart-summary-products">
      {block name='cart_summary_product_list'}
        <ul id="cart-summary-product-list">
          {foreach from=$cart.products item=product}
            <li class="cart-summary-product-item">{include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}</li>
          {/foreach}
        </ul>
      {/block}
    </div>
  {/block}

  {block name='cart_summary_subtotals'}
    <div class="row">
      {foreach from=$cart.subtotals item="subtotal"}
        {if $subtotal && $subtotal.type !== 'tax'}
          <div class="cart-summary-line cart-summary-subtotals col-auto" id="cart-subtotal-{$subtotal.type}">
            <span class="label">{$subtotal.label}</span>
            <span class="value">{$subtotal.value}</span>
          </div>
        {/if}
      {/foreach}
    </div>
  {/block}

  <hr class="my-3">

  {block name='cart_summary_totals'}
    {include file='checkout/_partials/cart-summary-totals.tpl' cart=$cart}
  {/block}
</section>
