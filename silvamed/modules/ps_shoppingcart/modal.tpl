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

<div id="blockcart-modal" class="modal fade modal-close-inside" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <button type="button" class="close linearicons-cross2" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
      <div class="modal-body">
        <div class="row">
          <div class="col-12">
            <h3 class="blockcart-title"><i class="linearicons-check" aria-hidden="true"></i>{l s='Product successfully added to your shopping cart' d='Shop.Theme.Checkout'}</h3>
            <div class="product-thumbnail">
              <a href="{$product.url}" title="{$product.name}"><img class="img-fluid" src="{$product.cover.bySize.medium_default.url}" alt="{$product.name}"/></a>
            </div>
            <h3 class="product-title"><a href="{$product.url}" title="{$product.name}">{$product.name}</a></h3>
            <div class="product-attributes">
              {foreach from=$product.attributes item="property_value" key="property"}
                <div>{$property}: <span>{$property_value}</span></div>
              {/foreach}
            </div>
            <div class="total-wrap">
              <div class="product-quantity">{l s='Quantity' d='Shop.Theme.Checkout'}: <span>{$product.cart_quantity}</span></div>
              <div class="product-total">{$cart.totals.total.label}: <span class="price">{$product.total}</span></div>
            </div>
          </div>
          <div class="col-12">
            <div class="d-flex flex-column justify-content-center h-100">
              <div class="modal-bottom pt-3 mt-3">
                {if $cart.products_count > 1}
                  <h3 class="blockcart-title"><i class="linearicons-cart" aria-hidden="true"></i>{l s='There are %products_count% items in your cart.' sprintf=['%products_count%' => $cart.products_count] d='Shop.Theme.Checkout'}</h3>
                {else}
                  <h3 class="blockcart-title"><i class="linearicons-cart" aria-hidden="true"></i>{l s='There is %product_count% item in your cart.' sprintf=['%product_count%' =>$cart.products_count] d='Shop.Theme.Checkout'}</h3>
                {/if}
                <div class="total-wrap">
                  {foreach from=$cart.subtotals item="subtotal"}
                    {if $subtotal.type}
                      <div class="modal-cart-{$subtotal.type}">{$subtotal.label} <span class="price">{$subtotal.value}</span></div>
                    {/if}
                  {/foreach}
                  <div class="modal-cart-total">{$cart.totals.total.label} <span class="price">{$cart.totals.total.value} <small>{$cart.labels.tax_short}</small></span></div>
                </div>
                <div class="modal-cart-buttons d-flex align-items-center justify-content-md-between mt-3">
                  <button type="button" class="btn btn-md btn-primary m-1 px-2" data-dismiss="modal">{l s='Continue shopping' d='Shop.Theme.Actions'}</button>
                  <a class="btn btn-default btn-md m-1 px-2" href="{$cart_url}" title="{l s='Proceed to checkout' d='Shop.Theme.Actions'}">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
