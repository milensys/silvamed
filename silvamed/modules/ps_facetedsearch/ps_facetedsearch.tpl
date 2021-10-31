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

{if isset($listing.rendered_facets) && $page.page_name == 'category'}
  <div id="search_filters_wrapper" class="filter to-hide d-md-block {if $page.canonical == $urls.current_url}is-default-filter{/if}">
    {block name='facets_title'}
      <h3 class="facets-title">{l s='Filter By' d='Shop.Theme.Actions'}</h3>
    {/block}
    <div id="_desktop_active_filter"></div>
    {$listing.rendered_facets nofilter}
  </div>
{/if}
