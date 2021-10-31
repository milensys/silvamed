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
<div id="order-items" class="col-12">

  <div class="order-confirmation-table">

    {block name='order_confirmation_table'}
      {foreach from=$products item=product}
        <div class="bg-light p-3 mb-5">
          <div class="order-line row align-items-center">
            <div class="col-sm-2 col-3">
            <span class="product-thumbnail">
              <img class="img-fluid" src="{$product.cover.medium.url}"/>
            </span>
            </div>
            <div class="col-sm-4 col-9 details">
              <h3 class="product-title">
                {if $add_product_link}<a href="{$product.url}" target="_blank">{/if}
                  {$product.name}
                {if $add_product_link}</a>{/if}
              </h3>
              {if is_array($product.customizations) && $product.customizations|count}
                {foreach from=$product.customizations item="customization"}
                  <div class="customizations mt-3">
                    <a class="btn btn-sm btn-success" href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                  </div>
                  <div class="modal fade customization-modal modal-close-inside" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-sm" role="document">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                          </button>
                          <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                        </div>
                        <div class="modal-body">
                          {foreach from=$customization.fields item="field"}
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
              {/if}
              {hook h='displayProductPriceBlock' product=$product type="unit_price"}
            </div>
            <div class="col-sm-6 col-12 qty">
              <div class="row">
                <div class="col-5 text-center">{$product.price}</div>
                <div class="col-1 px-1 text-center">{$product.quantity}</div>
                <div class="col-6 product-price justify-content-end"><span class="price">{$product.total}</span></div>
              </div>
            </div>
          </div>
        </div>
      {/foreach}

      <div class="cart-summary">
        <div class="row align-items-baseline">
          {foreach $subtotals as $subtotal}
            <div class="cart-summary-line col-auto">
              {if $subtotal.type !== 'tax' && $subtotal.label !== null}
                <span class="label">{$subtotal.label}</span>
                <span class="value">{$subtotal.value}</span>
              {/if}
            </div>
          {/foreach}
          {if $subtotals.tax.label !== null}
            <div class="cart-summary-line col-auto">
              <span class="label">{$subtotals.tax.label}</span>
              <span class="value">{$subtotals.tax.value}</span>
            </div>
          {/if}
          <div class="cart-summary-line col-auto cart-total">
            <span class="label">{$totals.total.label}<small>{$labels.tax_short}</small></span>
            <span class="value">{$totals.total.value}</span>
          </div>
        </div>
      </div>
    {/block}

  </div>
</div>
