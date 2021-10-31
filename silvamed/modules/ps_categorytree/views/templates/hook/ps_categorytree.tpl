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

{function name="categories" nodes=[] depth=0}
    {strip}
        {if $nodes|count}
          <ul class="list-default">
              {foreach from=$nodes item=node}
                <li data-depth="{$depth}">
                  <a href="{$node.link}">{$node.name}</a>
                    {if $node.children}
                      <span class="collapsed" data-toggle="collapse" data-target="#exCollapsingNavbar{$node.id}">
                <i class="fa fa-angle-down" aria-hidden="true"></i>
              </span>
                      <div class="collapse" id="exCollapsingNavbar{$node.id}">
                          {categories nodes=$node.children depth=$depth+1}
                      </div>
                    {/if}
                </li>
              {/foreach}
          </ul>
        {/if}
    {/strip}
{/function}

{if $categories.children}
  <div class="block-categories hidden-md-down{if isset($original_hook_name) && ($original_hook_name == 'displayFooter' || $original_hook_name == 'displayFooterBefore')} footer-links{/if}">
    <h3 class="d-none title-block">{l s='Categories' d='Shop.Theme.Catalog'}</h3>
    <h3 class="d-flex justify-content-between align-items-center collapsed d-md-none title-block" data-target="#category-top-menu" data-toggle="collapse">
        {l s='Categories' d='Shop.Theme.Catalog'}
      <i class="fa fa-angle-down" aria-hidden="true"></i>
    </h3>
    <ul id="category-top-menu" class="category-top-menu collapse d-md-block list-default">
      <li class="home-category d-none"><a class="h5 mb-0" href="{$categories.link nofilter}">{$categories.name}</a></li>
      <li>{categories nodes=$categories.children}</li>
    </ul>
  </div>
{/if}

