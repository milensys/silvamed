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
{block name='product_miniature_item'}
  <article class="product-miniature product-miniature-custom js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
    <div class="product-miniature-container">
      <div class="product-miniature-thumbnail">
        <div class="product-thumbnail">
          {block name='product_thumbnail'}
            {if $product.cover}
              <a href="{$product.url}" class="product-thumbnail-link">
                <img
                        class="img-fluid"
                        src = "{$product.cover.bySize.home_default.url}"
                        alt = "{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                        data-full-size-image-url = "{$product.cover.large.url}"
                >
              </a>
            {else}
              <a href="{$product.url}" class="thumbnail product-thumbnail">
                <img class="img-fluid" src = "{$urls.no_picture_image.bySize.home_default.url}">
              </a>
            {/if}
          {/block}
          {block name='product_flags'}
            {if $product.flags || (isset($daydeal_label) && $daydeal_label)}
              <ul class="product-flags">
                {if isset($daydeal_label) && $daydeal_label}
                  <li class="product-flag label-daydeal">
                    {$daydeal_label}
                    {if $product.has_discount}
                      {if $product.discount_type === 'percentage'}
                        <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                      {elseif $product.discount_type === 'amount'}
                        <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                      {/if}
                    {/if}
                  </li>
                {/if}
                {foreach from=$product.flags item=flag}
                  {if isset($daydeal_label) && $daydeal_label && ($flag.type == 'discount' || $flag.type == 'on-sale')}
                    {continue}
                  {/if}
                  <li class="product-flag {$flag.type}">{$flag.label}</li>
                {/foreach}
              </ul>
            {/if}
          {/block}
        </div>
      </div>

      <div class="product-miniature-information">
        {block name='product_name'}
          {if $page.page_name == 'index'}
            <h3 class="product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
          {else}
            <h3 class="product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h3>
          {/if}
        {/block}

        {block name='product_description_short'}
          <div class="product-description-short mt-2">{$product.description_short|strip_tags|truncate:120:'...' nofilter}</div>
        {/block}

        {block name='product_variants'}
          {if $product.main_variants}
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
          {/if}
        {/block}

        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$product}
        {/block}
        {block name='product_price_and_shipping'}
          {if $product.show_price && !$configuration.is_catalog}
            <div class="product-price d-xl-none mb-0{if $product.has_discount} with-discount{/if}">
              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span itemprop="price" class="price">{$product.price}</span>
              {hook h='displayProductPriceBlock' product=$product type="before_price"}
              {hook h='displayProductPriceBlock' product=$product type='unit_price'}
              {hook h='displayProductPriceBlock' product=$product type='weight'}
            </div>
          {/if}
        {/block}
        <div class="product-buttons">
          {if $product.add_to_cart_url && !$configuration.is_catalog && ({$product.minimal_quantity} < 2)}
            <a class="add-to-cart" href="{$product.add_to_cart_url}" rel="nofollow" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" data-link-action="add-to-cart">
              <span>{l s='Add to cart' d='Shop.Theme.Actions'}</span>
              {if $product.show_price && !$configuration.is_catalog}
                <span itemprop="price" class="price d-none d-xl-inline-block"> - {$product.price}</span>
                {hook h='displayProductPriceBlock' product=$product type="before_price"}
                {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                {hook h='displayProductPriceBlock' product=$product type='weight'}
              {/if}
            </a>
          {else}
            {if $product.customizable == 0}
              <a itemprop="url" class="view-product" href="{$product.url}" title="{l s='View product' d='Shop.Theme.Actions'}">
                <span>{l s='View product' d='Shop.Theme.Actions'}</span>
                {if $product.show_price && !$configuration.is_catalog}
                  <span itemprop="price" class="price d-none d-xl-inline-block"> - {$product.price}</span>
                    {hook h='displayProductPriceBlock' product=$product type="before_price"}
                    {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                    {hook h='displayProductPriceBlock' product=$product type='weight'}
                {/if}
              </a>
            {else}
              <a itemprop="url" class="customize" href="{$product.url}" title="{l s='Customize' d='Shop.Theme.Actions'}">
                <span>{l s='Customize' d='Shop.Theme.Actions'}</span>
                {if $product.show_price && !$configuration.is_catalog}
                  <span itemprop="price" class="price d-none d-xl-inline-block"> - {$product.price}</span>
                  {hook h='displayProductPriceBlock' product=$product type="before_price"}
                  {hook h='displayProductPriceBlock' product=$product type='unit_price'}
                  {hook h='displayProductPriceBlock' product=$product type='weight'}
                {/if}
              </a>
            {/if}
          {/if}
        </div>
      </div>
    </div>
  </article>
{/block}
