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
<div class="product-line-grid row align-items-center">
  <!--  product left content: image-->
  {if !isset($product.is_gift) || !$product.is_gift}
    <div class="cart-line-product-actions col-auto pr-0 mb-3 mb-sm-0">
      <a
        class="remove-from-cart close"
        rel="nofollow"
        href="{$product.remove_from_cart_url}"
        data-link-action="delete-from-cart"
        data-id-product="{$product.id_product|escape:'javascript'}"
        data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
        data-id-customization="{$product.id_customization|escape:'javascript'}"
      >
        <i class="linearicons-cross2"></i>
      </a>
      {block name='hook_cart_extra_product_actions'}
        {hook h='displayCartExtraProductActions' product=$product}
      {/block}
    </div>
  {/if}
  <div class="product-line-grid-left col-4 col-sm mb-3 mb-sm-0">
    <a class="product-thumbnail" href="{$product.url}" data-id_customization="{$product.id_customization|intval}">
      <img class="img-fluid" src="{$product.cover.bySize.medium_default.url}" alt="{$product.name|escape:'quotes'}">
    </a>
  </div>

  <!--  product left body: description -->
  <div class="product-line-grid-body col-6 col-sm-3 mb-3 mb-sm-0">
    <h3 class="product-title"><a class="label" href="{$product.url}" data-id_customization="{$product.id_customization|intval}">{$product.name}</a></h3>

    <div class="product-line-info">
      {foreach from=$product.attributes key="attribute" item="value" name="attribute"}
        <small>
          <span class="label">{$attribute}:</span>
          <span class="value">{$value}</span>
        </small>
        {if !$smarty.foreach.attribute.last}, {/if}
      {/foreach}
    </div>

    {if is_array($product.customizations) && $product.customizations|count}
      <br>
      {block name='cart_detailed_product_line_customization'}
        {foreach from=$product.customizations item="customization"}
          <a class="btn btn-sm btn-dark" href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
          <div class="modal fade customization-modal modal-close-inside" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
              <div class="modal-content">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span class="linearicons-cross2"></span>
                </button>
                <div class="modal-header">
                  <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                </div>
                <div class="modal-body">
                  {foreach from=$customization.fields item="field" name="field"}
                    <div class="product-customization-line row">
                      <div class="col-sm-3 col-4 label">
                        {$field.label}
                      </div>
                      <div class="col-sm-9 col-8 value">
                        {if $field.type == 'text'}
                          {if (int)$field.id_module}
                            {$field.text nofilter}
                          {else}
                            {$field.text}
                          {/if}
                        {elseif $field.type == 'image'}
                          <img src="{$field.image.small.url}">
                        {/if}
                      </div>
                    </div>
                  {/foreach}
                </div>
              </div>
            </div>
          </div>
        {/foreach}
      {/block}
    {/if}
  </div>

  <div class="product-line-grid-price col-4 col-sm-2">
    <div class="product-price-sm">
      <span class="price">{$product.price}</span>
      {if $product.unit_price_full}
        <small class="unit-price-cart">({$product.unit_price_full})</small>
      {/if}
    </div>
  </div>

  <!--  product left body: description -->
  <div class="product-line-grid-right product-line-actions col-4 col-sm-2">
    <div class="qty">
      {if isset($product.is_gift) && $product.is_gift}
        <span class="gift-quantity">{$product.quantity}</span>
      {else}
        <input
          class="js-cart-line-product-quantity"
          data-down-url="{$product.down_quantity_url}"
          data-up-url="{$product.up_quantity_url}"
          data-update-url="{$product.update_quantity_url}"
          data-product-id="{$product.id_product}"
          type="text"
          value="{$product.quantity}"
          name="product-quantity-spin"
          min="{$product.minimal_quantity}"
        />
      {/if}
    </div>
  </div>

  <!--  product left body: description -->
  <div class="col-4 col-sm-2">
    <span class="product-price">
      {if isset($product.is_gift) && $product.is_gift}
        <h5 class="gift mb-0">{l s='Gift' d='Shop.Theme.Checkout'}</h5>
      {else}
      <span class="price">{$product.total}</span>
      {/if}
    </span>
  </div>
</div>
