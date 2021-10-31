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

{block name='cart_detailed_actions'}
  <div class="checkout cart-detailed-actions">
    {if $cart.minimalPurchaseRequired}
      <div class="alert alert-warning" role="alert">
        {$cart.minimalPurchaseRequired}
      </div>
      <button type="button" class="btn btn-default btn-md disabled" disabled>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</button>
    {elseif empty($cart.products) }
      <button type="button" class="btn btn-default btn-md disabled" disabled>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</button>
    {else}
      <a href="{$urls.pages.order}" class="btn btn-default btn-md">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
      {hook h='displayExpressCheckout'}
    {/if}
  </div>
{/block}
