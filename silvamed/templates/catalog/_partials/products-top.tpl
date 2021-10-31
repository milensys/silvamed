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
<div id="js-product-list-top" class="products-selection row align-items-center flex-wrap mb-4 pb-1">
  {if !empty($listing.rendered_facets)}
    <div class="d-md-none filter-button col">
      <button type="button" class="btn btn-default btn-md js-modal-filter position-left size-modal-sm destroy-up-768">
        <span>{l s='Filter' d='Shop.Theme.Actions'}</span>
      </button>
    </div>
  {/if}
  {block name='sort_by'}
    {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
  {/block}
  <ul id="grid-list-buttons" class="col text-right my-1">
    <li>
      <a id="grid" rel="nofollow" href="#" title="Grid">
        <i class="fa fa-th" aria-hidden="true"></i>
      </a>
    </li>
    <li>
      <a id="list" rel="nofollow" href="#" title="List">
        <i class="fa fa-th-list" aria-hidden="true"></i>
      </a>
    </li>
  </ul>
</div>
