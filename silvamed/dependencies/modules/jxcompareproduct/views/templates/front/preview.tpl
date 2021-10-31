{*
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

{if isset($products) && $products}
  {foreach from=$products item=product name=product}
    <li class="compare-product-element mb-0" data-id-product="{$product.info.id_product}">
      <a href="#" class="js-compare-button" data-action="remove-product" data-id-product="{$product.info.id_product}"><span aria-hidden="true">&times;</span></a>
      {if $product.info.cover}
        <img
          class="img-fluid"
          src="{$product.info.cover.bySize.small_default.url}"
          alt="{if !empty($product.info.cover.legend)}{$product.info.cover.legend}{else}{$product.info.name|truncate:30:'...'}{/if}"
        >
      {else}
        <img
          class="img-fluid"
          src="{$no_picture_image.bySize.small_default.url}"
        >
      {/if}
    </li>
  {/foreach}
{else}
  <li class="no-products mb-0">{l s='No products to compare' mod='jxcompareproduct'}</li>
{/if}


