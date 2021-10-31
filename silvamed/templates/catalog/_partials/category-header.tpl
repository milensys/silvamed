{**
 * 2007-2020 PrestaShop.
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
<div id="js-product-list-header">
  {if $listing.pagination.items_shown_from == 1}
    <div class="block-category">
      {if $category.description}
        <div id="category-description">
          <h2 class="h1 category-name">{$category.name}</h2>
          <div class="row d-none">
            {if $category.image.small.url}
              <div class="category-cover col-3">
                <img class="img-fluid" src="{$category.image.small.url}" alt="{if !empty($category.image.legend)}{$category.image.legend}{else}{$category.name}{/if}">
              </div>
            {/if}
            {if $category.description|count_characters > 350}
              <div class="col-12">
                <div class="category-description-wrap">
                  <button type="button" class="btn btn-dark btn-sm" data-toggle="button" aria-pressed="false" autocomplete="off">
                    <span>{l s='Show' d='Shop.Theme.Actions'}</span>
                    <span>{l s='Hide' d='Shop.Theme.Actions'}</span>
                  </button>
                  <div class="category-description-short mb-3">{$category.description|strip_tags|truncate:"350" nofilter}</div>
                  <div class="category-description-full">{$category.description nofilter}</div>
                </div>
              </div>
            {elseif $category.description}
              <div class="col-9">{$category.description nofilter}</div>
            {/if}
          </div>
        </div>
      {/if}
    </div>
  {/if}
</div>
