{*
* 2017-2020 Zemez
*
* JX Mega Menu
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
* @author     Zemez (Alexander Grosul)
* @copyright  2017-2020 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if isset($product) && $product}
  <li {if isset($selected) && $selected}{$selected nofilter}{/if}>
    <div class="product product-{$product.id_product}">
      <div class="product-thumbnail">
        <a href="{$product.url}" title="{$product.name}">
          {if $product.cover}
            <img class="img-fluid" src="{$product.cover.bySize.home_default.url}" alt="{$product.cover.legend}"/>
          {else}
            <img src = "{$urls.no_picture_image.bySize.home_default.url}">
          {/if}
        </a>
      </div>
      <div class="pt-3 text-center">
        <h3 class="product-title">
          <a href="{$product.url}" title="{$product.name}">
            {$product.name|truncate:"40"}
          </a>
        </h3>
        <div class="product-price-sm{if $product.has_discount} with-discount{/if}">
          <span class="price">{$product.price}</span>
          {if $product.has_discount}
            <span class="regular-price">{$product.regular_price}</span>
            {if $product.discount_type === 'percentage'}
              <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
            {/if}
          {/if}
        </div>
      </div>
    </div>
  </li>
{/if}
