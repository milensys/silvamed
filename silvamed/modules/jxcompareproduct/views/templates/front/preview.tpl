{*
* 2017-2020 Zemez
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
*  @copyright 2017-2020 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if isset($products) && $products}
  {foreach from=$products item=product name=product}
    <li class="compare-product-element" data-id-product="{$product.info.id_product}">
      <div class="product-thumbnail">
        <img class="img-fluid" src="{$product.info.cover.small.url}" alt="{$product.info.cover.legend}" />
        <a href="#" class="js-compare-button close-product" data-action="remove-product" data-id-product="{$product.info.id_product}"><span aria-hidden="true">&times;</span></a>
      </div>
    </li>
  {/foreach}
{else}
  <li class="no-products">{l s='No products to compare' mod="tmcompareproduct"}</li>
{/if}


