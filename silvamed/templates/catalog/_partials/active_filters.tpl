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

<section id="js-active-search-filters" class="{if $activeFilters|count}active_filters{else}d-none{/if}">
  <h5>{l s='Enabled filters:' d='Shop.Theme.Actions'}</h5>
  <div class="active_filters_wrapper">
    {if $activeFilters|count}
      <ul>
        {foreach from=$activeFilters item="filter"}
          {block name='active_filters_item'}
            <li class="filter-block">
              <span>{l s='%1$s: ' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]}</span>
              {$filter.label}
              <a class="js-search-link" href="{$filter.nextEncodedFacetsURL}"><i class="linearicons-cross2"></i></a>
            </li>
          {/block}
        {/foreach}
      </ul>
      {block name='facets_clearall_button'}
        <button data-search-url="{$clear_all_link}" class="btn btn-sm btn-default js-search-filters-clear-all">{l s='Clear all' d='Shop.Theme.Actions'}</button>
      {/block}
    {/if}
  </div>
</section>
