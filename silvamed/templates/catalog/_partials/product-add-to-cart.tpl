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
<div class="product-add-to-cart mt-3">
  {if !$configuration.is_catalog}
    {block name='product_quantity'}
      <div class="product-quantity">
        <div class="title-wrapper d-flex align-items-baseline mb-1">
          <h3 class="d-none">{l s='Quantity' d='Shop.Theme.Actions'}</h3>
          {block name='product_availability'}
            <span id="product-availability">
            {if $product.show_availability && $product.availability_message}
              <span class="text-uppercase {if $product.availability == 'available'}product-available{elseif $product.availability == 'last_remaining_items'}product-last-items{else}product-unavailable{/if}">
                {$product.availability_message}
              </span>
            {/if}
          </span>
          {/block}
        </div>
        {block name='product_minimal_quantity'}
          {if $product.minimal_quantity > 1}
            <p class="product-minimal-quantity alert alert-warning">
              {l
              s='The minimum purchase order quantity for the product is %quantity%.'
              d='Shop.Theme.Checkout'
              sprintf=['%quantity%' => $product.minimal_quantity]
              }
            </p>
          {/if}
        {/block}
        <div class="product-add-to-cart-wrapper">
          <div class="qty">
            <input
                    type="text"
                    name="qty"
                    id="quantity_wanted"
                    value="{$product.quantity_wanted}"
                    class="input-group input-group-lg"
                    min="{$product.minimal_quantity}"
                    aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
            >
          </div>

          <div class="add">
            <button
                    class="btn btn-default btn-lg add-to-cart"
                    data-button-action="add-to-cart"
                    type="submit"
                    {if !$product.add_to_cart_url}
                      disabled
                    {/if}
            >
              <span>{l s='Add to cart' d='Shop.Theme.Actions'}</span>
            </button>
          </div>
        </div>
      </div>
    {/block}
  {/if}
</div>
