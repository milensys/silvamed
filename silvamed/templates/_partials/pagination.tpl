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

<div class="row align-items-center flex-wrap">
  <div class="showing my-2 col-12 text-center{if $pagination.should_be_displayed} col-md-6 order-md-2 text-md-right{/if}">
    {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=[
    '%from%' => $listing.pagination.items_shown_from ,
    '%to%' => $listing.pagination.items_shown_to,
    '%total%' => $listing.pagination.total_items
    ]}
  </div>

  {if $pagination.should_be_displayed}
    <div class="my-2 col-12 col-md-6 order-md-1">
      <nav class="pagination justify-content-center justify-content-md-start">
        {block name='pagination_page_list'}
          <ul class="page-list d-flex flex-wrap align-items-center mb-0">
            {foreach from=$pagination.pages item="page"}
              <li class="{if $page.current} current{/if}">
                {if $page.type === 'spacer'}
                  <span class="spacer">&hellip;</span>
                {else}
                  <a
                    rel="{if $page.type === 'previous'}prev{elseif $page.type === 'next'}next{else}nofollow{/if}"
                    href="{$page.url}"
                    class="{if $page.type === 'previous'}previous {elseif $page.type === 'next'}next {else}{/if}{['disabled' => !$page.clickable, 'js-search-link' => true]|classnames}"
                  >
                    {if $page.type === 'previous'}
                      <i class="linearicons-arrow-left"></i>
                      <span class="d-none">{l s='Previous' d='Shop.Theme.Actions'}</span>
                    {elseif $page.type === 'next'}
                      <span class="d-none">{l s='Next' d='Shop.Theme.Actions'}</span>
                      <i class="linearicons-arrow-right"></i>
                    {else}
                      {$page.page}
                    {/if}
                  </a>
                {/if}
              </li>
            {/foreach}
          </ul>
        {/block}
      </nav>
    </div>
  {/if}
</div>
