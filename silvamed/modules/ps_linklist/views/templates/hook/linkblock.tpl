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
{foreach $linkBlocks as $linkBlock}
  <div class="link-block{if !$linkBlock@last} mb-4{/if}{if $linkBlock.hook === 'displayFooter'} footer-links{/if}">
    <h3 class="{if $linkBlock.hook !== 'displayNav' && $linkBlock.hook !== 'displayTop'}d-none title-block{else}d-none{/if} link_block_{$linkBlock.hook}">{$linkBlock.title}</h3>
    <h3 class="{if $linkBlock.hook !== 'displayNav' && $linkBlock.hook !== 'displayTop'}d-flex justify-content-between align-items-center collapsed d-md-none title-block{else}d-none{/if} link_block_{$linkBlock.hook}" data-target="#link_block_{$linkBlock.hook}" data-toggle="collapse">
      {$linkBlock.title}
      <i class="fa fa-angle-down" aria-hidden="true"></i>
    </h3>
    <ul id="link_block_{$linkBlock.hook}" class="{if $linkBlock.hook !== 'displayNav' && $linkBlock.hook !== 'displayTop'}list-default collapse d-md-block{else}mb-0 d-flex flex-column flex-xxl-row flex-wrap mt-3 mt-xxl-0{/if}">
      {foreach $linkBlock.links as $link}
        <li>
          <a
                  id="{$link.id}-{$linkBlock.id}"
                  class="{$link.class}"
                  href="{$link.url}"
                  title="{$link.description}">
            {$link.title}
          </a>
        </li>
      {/foreach}
    </ul>
  </div>
{/foreach}
