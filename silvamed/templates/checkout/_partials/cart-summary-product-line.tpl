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
{block name='cart_summary_product_line'}
  <div class="media">
    <a class="product-thumbnail mr-3" href="{$product.url}" title="{$product.name}">
      <img class="img-fluid" src="{$product.cover.medium.url}" alt="{$product.name}">
    </a>
    <div class="media-body">
      <h3 class="product-title"><a href="{$product.url}" title="{$product.name}">{$product.name}</a></h3>
      <div class="product-price mb-1">
        <span class="price">{$product.price}</span>
        {hook h='displayProductPriceBlock' product=$product type="unit_price"}
      </div>
      {if isset($product.attributes) && $product.attributes}
        <div class="product-attributes d-flex align-items-center flex-wrap">
          <p class="cart-product-quantity mr-1">{$product.quantity} x</p>
          {foreach from=$product.attributes key="attribute" item="value" name="value"}
            <p>{$attribute}:{$value}{if !$smarty.foreach.value.last}, {/if}</p>
          {/foreach}
        </div>
      {/if}
    </div>
  </div>
{/block}
