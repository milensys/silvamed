{*
* 2017-2020 Zemez
*
* JX Search
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
  <div class="jxsearch-inner-row" data-href="{$product.url}">
    {if $jxsearchsettings.jxsearch_image}<img src="{if $product.cover.bySize.small_default.url}{$product.cover.bySize.small_default.url}{elseif $search_no_image}{$search_no_image.bySize.small_default.url}{/if}" alt="{$product.name}" />{/if}
    {if $product.reference && $jxsearchsettings.jxsearch_reference}<div class="reference">{$product.reference}</div>{/if}
    {if $product.quantity_all_versions}
      <div class="quantity">
        {$product.quantity_all_versions}
        {if $product.quantity_all_versions > 1}{l s='Items' mod='jxsearch'}{elseif $product.quantity_all_versions == 1}{l s='Item' mod='jxsearch'}{/if}
      </div>
    {/if}
    {if $product.available_now}<div class="availability">{$product.available_now}</div>{elseif $product.available_later}{$product.available_later}{/if}
    {if $product.name}<span class="name">{$product.name}</span>{/if}
    {if $jxsearchsettings.jxsearch_price}
      <div class="price{if $product.specific_prices} new-price{/if}">{$product.price}</div>
    {/if}
    {if $product.description_short && $jxsearchsettings.jxsearch_description}<div class="description-short">{$product.description_short nofilter}</div>{/if}
    {if $product.manufacturer_name && $jxsearchsettings.jxsearch_manufacturer}<div class="manufacturer-name">{$product.manufacturer_name}</div>{/if}
    {if $product.supplier_name && $jxsearchsettings.display_supplier}<div class="supplier-name">{$product.supplier_name}</div>{/if}
  </div>
{/if}