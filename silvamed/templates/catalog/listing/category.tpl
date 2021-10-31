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
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  {include file='catalog/_partials/category-header.tpl' listing=$listing category=$category}
{/block}

{block name='product_list_subcategories'}
  {if isset($subcategories) && $subcategories}
    <!-- Subcategories -->
    <div id="subcategories" class="u-carousel uc-el-subcategories-items uc-nav my-3">
      <h2 class="subcategory-title mb-2">{l s='Subcategory' d='Shop.Theme.Actions'}</h2>
      <div class="row">
        {foreach from=$subcategories item=subcategory}
          <article class="subcategories-items col-4 col-xl-3 col-xxl-2">
            <div class="subcategories-items-inner">
              {if $subcategory.id_image}
                <div class="product-thumbnail text-center mb-2">
                  <a href="{$subcategory.url}" title="{$subcategory.name}">
                    <img class="img-fluid" src="{$subcategory.image.small.url}" alt="{$subcategory.image.legend}">
                  </a>
                </div>
                <h2 class="h5 text-center mb-0"><a class="subcategory-name" href="{$subcategory.url}">{$subcategory.name|truncate:20:'...'}</a></h2>
              {else}
                <h2><a class="subcategory-name mb-0" href="{$subcategory.url}">{$subcategory.name|truncate:20:'...'}</a></h2>
              {/if}
            </div>
          </article>
        {/foreach}
      </div>
    </div>
  {/if}
{/block}
