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

{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      <ul class="list-inline m-0" data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="list-inline-item {$node.type}">
            {assign var=_counter value=$_counter+1}
              <a class="btn btn-sm btn-secondary{if $node.current} active{/if}" href="{$node.url}" data-depth="{$depth}"{if $node.open_in_new_window} target="_blank"{/if}>
                {$node.label}
              </a>
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

<div class="menu">
    {menu nodes=$menu.children}
</div>
