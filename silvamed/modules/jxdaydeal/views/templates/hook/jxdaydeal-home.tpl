{*
* 2017-2020 Zemez
*
* JX Deal of Day
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
*  @author    Zemez (Sergiy Sakun)
*  @copyright 2017-2020 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<section class="daydeal-products">
  <h2 class="h2 products-section-title text-center mb-3 mb-md-5">{l s='Deal of the day' mod='jxdaydeal'}</h2>
  <div class="products">
    {if isset($daydeal_products) && $daydeal_products}
      {foreach from=$daydeal_products item=product name=product}
        {include file="catalog/_partials/miniatures/product.tpl" product=$product.info daydeal_label=$daydeal_products_extra[$product.info.id_product]["label"]}
      {/foreach}
    {else}
      <p class="alert alert-info">{l s='No special products at this time.' mod='jxdaydeal'}</p>
    {/if}
  </div>
</section>