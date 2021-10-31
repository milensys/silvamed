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
{block name='pack_miniature_item'}
  <article class="pack-miniature col-6 col-md-4">
    <div class="product-thumbnail">
      <img class="img-fluid" src="{$product.cover.small.url}" alt="{$product.cover.legend}" data-full-size-image-url="{$product.cover.large.url}" title="{$product.name}">
    </div>
    <div class="pack-miniature-right">
      <h3 class="product-title mb-1"><a href="{$product.url}">{$product.pack_quantity} x {$product.name|truncate:'20'}</a></h3>
      <div class="product-price-sm">
        <span class="price">{$product.price}</span>
      </div>
    </div>
  </article>
{/block}
