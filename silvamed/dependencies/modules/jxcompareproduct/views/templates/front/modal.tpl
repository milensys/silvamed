{**
* 2017-2019 Zemez
*
* JX Compare Product
*
* NOTICE OF LICENSE
*
* This source file is subject to the General Public License (GPL 2.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/GPL-2.0
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade the module to newer
* versions in the future.
*
*  @author    Zemez
*  @copyright 2017-2019 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div id="modal-compare" class="modal fade{if isset($products) && $products} with-products{/if}" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
  <div class="modal-dialog{if isset($products) && $products} modal-lg{else} modal-sm{/if}">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-content-compare">
        {if isset($products) && $products}
          <div id="compare-products">
            <div class="empty-element">
              <div></div>
            </div>
            {foreach from=$products item='product'}
              <div class="compare-product-element" data-id-product="{$product.info.id_product}">
                {block name='product_thumbnail'}
                  <div class="product-thumbnail mb-2">
                    <a href="#" class="js-compare-button close" data-action="remove-product" data-id-product="{$product.info.id_product}"><span aria-hidden="true">&times;</span></a>
                    {if $product.info.cover}
                      <img
                        class="img-fluid"
                        src="{$product.info.cover.bySize.home_default.url}"
                        alt="{if !empty($product.info.cover.legend)}{$product.info.cover.legend}{else}{$product.info.name|truncate:30:'...'}{/if}"
                        data-full-size-image-url="{$product.info.cover.large.url}"
                      >
                    {else}
                      <img
                        class="img-fluid"
                        src="{$no_picture_image.bySize.home_default.url}"
                      >
                    {/if}
                    {block name='product_flags'}
                      <ul class="product-flags">
                        {foreach from=$product.info.flags item=flag}
                          <li class="product-flag {$flag.type}">{$flag.label}</li>
                        {/foreach}
                      </ul>
                    {/block}
                  </div>
                {/block}
                <div class="p-1">
                  {block name='product_name'}
                    <h5 class="product-title" itemprop="name"><a href="{$product.info.url}">{$product.info.name|truncate:25:'...'}</a></h5>
                  {/block}
                </div>
              </div>
            {/foreach}
          </div>
            <div id="compare-features">
              <div class="features-toggle"><span>{l s='Features' mod='jxcompareproduct'}</span><i class="fa fa-caret-right" aria-hidden="true"></i></div>
              <div class="compare-features-row">
                <div class="compare-features-title">{l s='Price' mod='jxcompareproduct'}</div>
                {foreach from=$products item='product'}
                  <div class="compare-features-item compare-product-element">
                    {block name='product_price_and_shipping'}
                      {if $product.info.show_price}
                        <div class="product-prices m-0">
                          {if $product.info.has_discount}
                            {hook h='displayProductPriceBlock' product=$product type="old_price"}
                            <span class="sr-only">{l s='Regular price' mod='jxcompareproduct'}</span>
                            <span class="regular-price">{$product.info.regular_price}</span>
                            {if $product.info.discount_type === 'percentage'}
                              <span class="discount discount-percentage">{$product.info.discount_percentage}</span>
                            {/if}
                          {/if}

                          {hook h='displayProductPriceBlock' product=$product type="before_price"}

                          <span class="sr-only">{l s='Price' mod='jxcompareproduct'}</span>
                          <span itemprop="price" class="price">{$product.info.price}</span>

                          {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                          {hook h='displayProductPriceBlock' product=$product type='weight'}
                        </div>
                      {/if}
                    {/block}
                  </div>
                {/foreach}
              </div>
              {if $features_fields_value}
                {foreach from=$features_fields_value[$product.info.id_product] key=name item='value'}
                  <div class="compare-features-row">
                    <div class="compare-features-title">{$name}</div>
                    {foreach from=$products item='product'}
                      <div class="compare-features-item compare-product-element" data-id-product="{$product.info.id_product}">{if $features_fields_value[$product.info.id_product][$name]}{$features_fields_value[$product.info.id_product][$name]}{else}-{/if}</div>
                    {/foreach}
                  </div>
                {/foreach}
              {/if}
              {if !(isset($configuration.is_catalog) && $configuration.is_catalog)}
                <div class="compare-features-row">
                  <div class="compare-features-title"></div>
                  {foreach from=$products item='product'}
                    <div class="compare-features-item compare-product-element" data-id-product="{$product.info.id_product}">
                      <a itemprop="url" class="customize btn btn-sm btn-secondary my-2" href="{$product.info.url}" title="{l s='Customize' mod='jxcompareproduct'}">
                        <span>{l s='More' mod='jxcompareproduct'}</span>
                      </a>
                    </div>
                  {/foreach}
                </div>
              {/if}
            </div>

        {else}
          <div class="modal-body"><p class="no-products m-0">{l s='No products to compare' mod='jxcompareproduct'}</p></div>
        {/if}
      </div>
    </div>
  </div>
</div>