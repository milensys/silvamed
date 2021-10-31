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
<div class="products-sort-order dropdown col">
  <div class="row align-items-center flex-nowrap">
    <div class="col-auto d-none d-lg-block">
      <label class="mb-0">{l s='Sort by:' d='Shop.Theme.Actions'}</label>
    </div>
    <div class="col">
      <button
              class="custom-select"
              rel="nofollow"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false">
        {if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Select' d='Shop.Theme.Actions'}{/if}
      </button>
      <div class="dropdown-menu">
        {foreach from=$listing.sort_orders item=sort_order}
          <a
                  rel="nofollow"
                  href="{$sort_order.url}"
                  class="select-list dropdown-item {['current' => $sort_order.current, 'js-search-link' => true]|classnames}"
          >
            {$sort_order.label}
          </a>
        {/foreach}
      </div>
    </div>
  </div>
</div>
