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
{if $cart.vouchers.allowed}
  {block name='cart_voucher'}
    <div class="block-promo">
      <div class="cart-voucher">
        {if $cart.discounts|count > 0}
          <div class="promo-highlighted">
            <h4>
              {l s='Take advantage of our exclusive offers:' d='Shop.Theme.Actions'}
            </h4>
            <ul class="js-discount">
              {foreach from=$cart.discounts item=discount}
                <li>
                  <span class="label"><span class="code">{$discount.code}</span> - {$discount.name}</span>
                </li>
              {/foreach}
            </ul>
            <hr class="my-2">
          </div>
        {/if}
        {if $cart.vouchers.added}
          {block name='cart_voucher_list'}
            <ul class="promo-name list-style-disk">
              {foreach from=$cart.vouchers.added item=voucher}
                <li class="d-flex align-items-center">
                  <span class="label mr-2">{$voucher.name}</span>
                  <span class="value">{$voucher.reduction_formatted}</span>
                  <a class="close ml-2" href="{$voucher.delete_url}" data-link-action="remove-voucher"><i class="linearicons-cross2"></i></a>
                </li>
              {/foreach}
            </ul>
          {/block}
        {/if}

        <p{if $cart.discounts|count > 0} class="d-none"{/if}>
          <a class="promo-code-button btn btn-sm btn-primary" data-toggle="collapse" href="#promo-code" aria-expanded="false" aria-controls="promo-code">
            {l s='Have a promo code?' d='Shop.Theme.Checkout'}
          </a>
        </p>

        <div class="promo-code collapse{if $cart.discounts|count > 0} show{/if}" id="promo-code">
          <div class="pt-3">
            {block name='cart_voucher_notifications'}
              <div class="js-error" >
                <div class="alert alert-danger js-error-text mb-3" role="alert"></div>
              </div>
            {/block}
            {block name='cart_voucher_form'}
              <form class="input-group input-group-sm" action="{$urls.pages.cart}" data-link-action="add-voucher" method="post">
                <span class="input-group-btn">
                  <button type="submit" class="btn btn-sm btn-dark">{l s='Add' d='Shop.Theme.Actions'}</button>
                </span>
                <input type="hidden" name="token" value="{$static_token}">
                <input type="hidden" name="addDiscount" value="1">
                <input class="form-control" type="text" name="discount_name" placeholder="{l s='Promo code' d='Shop.Theme.Checkout'}">
              </form>
            {/block}
          </div>
        </div>
        <hr class="my-2">
      </div>
    </div>
  {/block}

{/if}
