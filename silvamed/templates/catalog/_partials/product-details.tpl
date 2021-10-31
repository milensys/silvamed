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

<div class="tab-pane fade{if !$product.description} active show{/if}"
     id="product-details"
     data-product="{$product.embedded_attributes|json_encode}"
     role="tabpanel"
>

  <a class="d-flex justify-content-between align-items-center d-md-none{if $product.description} collapsed{/if}" data-toggle="collapse" href="#product-details-collapse" role="button" {if !$product.description}aria-expanded="true"{else}aria-expanded="false"{/if}>
    {l s='Product Details' d='Shop.Theme.Catalog'}
    <i class="fa fa-angle-down" aria-hidden="true"></i>
  </a>
  <div id="product-details-collapse" class="collapse d-md-block">
    <div class="product-details-top mb-3 d-flex flex-wrap align-items-center justify-content-center">
      {block name='product_condition'}
        {if $product.condition}
          <div class="product-condition mr-3">
            <label class="label">{l s='Condition' d='Shop.Theme.Catalog'} </label>
            <link itemprop="itemCondition" href="{$product.condition.schema_url}"/>
            <span>{$product.condition.label}</span>
          </div>
        {/if}
      {/block}

      {block name='product_reference'}
        {if isset($product.reference_to_display) && $product.reference_to_display neq ''}
          <div class="product-reference mr-3">
            <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
            <span itemprop="sku">{$product.reference_to_display}</span>
          </div>
        {/if}
      {/block}

      {block name='product_quantities'}
        {if $product.show_quantities}
          <div class="product-quantities mr-3">
            <label class="label">{l s='In stock' d='Shop.Theme.Catalog'}</label>
            <span>{$product.quantity} {$product.quantity_label}</span>
          </div>
        {/if}
      {/block}

      {block name='product_availability_date'}
        {if $product.availability_date}
          <div class="product-availability-date mr-3">
            <label>{l s='Availability date:' d='Shop.Theme.Catalog'} </label>
            <span>{$product.availability_date}</span>
          </div>
        {/if}
      {/block}
      {block name='product_manufacturer'}
        {if isset($product_manufacturer->id)}
          <div class="product-manufacturer mr-3">
            <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
            <span><a href="{$product_brand_url}">{$product_manufacturer->name}</a></span>
          </div>
        {/if}
      {/block}
    </div>

    {block name='product_features'}
      {if $product.grouped_features}
        <section class="product-features mb-3">
          <dl class="data-sheet">
            {foreach from=$product.grouped_features item=feature}
              <dt class="name">{$feature.name}</dt>
              <dd class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
            {/foreach}
          </dl>
        </section>
      {/if}
    {/block}

    {* if product have specific references, a table will be added to product details section *}
    {block name='product_specific_references'}
      {if !empty($product.specific_references)}
        <section class="product-features mb-3">
          <p class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</p>
          <dl class="data-sheet">
            {foreach from=$product.specific_references item=reference key=key}
              <dt class="name">{$key}</dt>
              <dd class="value">{$reference}</dd>
            {/foreach}
          </dl>
        </section>
      {/if}
    {/block}

    {block name='product_out_of_stock'}
      <div class="product-out-of-stock">
        {hook h='actionProductOutOfStock' product=$product}
      </div>
    {/block}
  </div>
</div>
