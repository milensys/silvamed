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

<div id="search_filters">

  {foreach from=$facets item="facet"}
    {if $facet.displayed}
      <section class="facet">
        <h1 class="h6 facet-title d-none d-md-block">{$facet.label}</h1>
        {assign var=_expand_id value=10|mt_rand:100000}
        {assign var=_collapse value=true}
        {foreach from=$facet.filters item="filter"}
          {if $filter.active}{assign var=_collapse value=false}{/if}
        {/foreach}
        <h1 class="h6 facet-title d-flex justify-content-between align-items-center d-md-none{if $_collapse} collapsed{/if}" data-target="#facet_{$_expand_id}" data-toggle="collapse"{if !$_collapse} aria-expanded="true"{/if}>
          <span>{$facet.label}</span>
          <i class="fa fa-angle-down ml-1" aria-hidden="true"></i>
        </h1>
          {if $facet.widgetType !== 'dropdown'}

            {block name='facet_item_other'}
              <ul id="facet_{$_expand_id}" class="facet-list">
                {foreach from=$facet.filters key=filter_key item="filter"}
                  {if $filter.displayed}
                    <li>
                      {if $facet.type == 'price'}
                        {block name='facet_item_slider'}
                          {foreach from=$facet.filters item="filter"}
                            <ul id="facet_{$_expand_id}"
                              class="faceted-slider"
                              data-slider-min="{$facet.properties.min}"
                              data-slider-max="{$facet.properties.max}"
                              data-slider-id="{$_expand_id}"
                              data-slider-values="{$filter.value|@json_encode}"
                              data-slider-unit="{$facet.properties.unit}"
                              data-slider-label="{$facet.label}"
                              data-slider-specifications="{$facet.properties.specifications|@json_encode}"
                              data-slider-encoded-url="{$filter.nextEncodedFacetsURL}"
                            >
                              <li>
                                <p id="facet_label_{$_expand_id}">
                                  {$filter.label}
                                </p>

                                <div id="slider-range_{$_expand_id}"></div>
                              </li>
                            </ul>
                          {/foreach}
                        {/block}
                      {elseif $facet.multipleSelectionAllowed}
                        <div class="custom-control custom-checkbox">
                          <input
                            id="facet_input_{$_expand_id}_{$filter_key}"
                            class="custom-control-input"
                            data-search-url="{$filter.nextEncodedFacetsURL}"
                            type="checkbox"
                            {if $filter.active } checked {/if}
                          >
                          <label class="facet-label custom-control-label{if $filter.active} active{/if}" for="facet_input_{$_expand_id}_{$filter_key}">
                            {if isset($filter.properties.color) && !$filter.active}<em class="color-box" style="background-color:{$filter.properties.color}"></em>{/if}
                            {if isset($filter.properties.texture) && !$filter.active}<em class="color-box" style="background-image:url({$filter.properties.texture})"></em>{/if}
                            <span {if !$js_enabled}class="ps-shown-by-js"{/if}>
                              <a href="{$filter.nextEncodedFacetsURL}" class="search-link js-search-link" rel="nofollow">
                                {$filter.label}
                                {if $filter.magnitude}
                                  <span class="magnitude">({$filter.magnitude})</span>
                                {/if}
                              </a>
                            </span>
                          </label>
                        </div>
                      {else}
                        <div class="custom-control custom-radio">
                          <input
                            id="facet_input_{$_expand_id}_{$filter_key}"
                            class="custom-control-input"
                            data-search-url="{$filter.nextEncodedFacetsURL}"
                            type="radio"
                            name="filter {$facet.label}"
                            {if $filter.active } checked {/if}
                          >
                          <label class="facet-label custom-control-label{if $filter.active} active{/if}" for="facet_input_{$_expand_id}_{$filter_key}">
                            <span {if !$js_enabled}class="ps-shown-by-js"{/if}>
                              <a href="{$filter.nextEncodedFacetsURL}" class="search-link js-search-link" rel="nofollow">
                                {$filter.label}
                                {if $filter.magnitude}
                                  <span class="magnitude">({$filter.magnitude})</span>
                                {/if}
                              </a>
                            </span>
                          </label>
                        </div>
                      {/if}
                    </li>
                  {/if}
                {/foreach}
              </ul>
            {/block}

          {else}

            {block name='facet_item_dropdown'}
              <ul id="facet_{$_expand_id}" class="facet-list collapse{if !$_collapse} in{/if} d-md-block">
                <li>
                  <div class="facet-dropdown dropdown">
                    <button class="custom-select" rel="nofollow" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      {$active_found = false}
                      {foreach from=$facet.filters item="filter"}
                        {if $filter.active}
                          {$filter.label}
                          {if $filter.magnitude}
                            ({$filter.magnitude})
                          {/if}
                          {$active_found = true}
                        {/if}
                      {/foreach}
                      {if !$active_found}
                        {l s='(no filter)' d='Shop.Theme.Global'}
                      {/if}
                    </button>
                    <div class="dropdown-menu">
                      {foreach from=$facet.filters item="filter"}
                        {if !$filter.active}
                          <a
                            rel="nofollow"
                            href="{$filter.nextEncodedFacetsURL}"
                            class="select-list js-search-link dropdown-item"
                          >
                            {$filter.label}
                            {if $filter.magnitude}
                              ({$filter.magnitude})
                            {/if}
                          </a>
                        {/if}
                      {/foreach}
                    </div>
                  </div>
                </li>
              </ul>
            {/block}

          {/if}
      </section>
    {/if}
  {/foreach}
</div>