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

<ul class="variant-links">
  {foreach from=$variants item=variant}
    <li class="variant-links-item">
      <a href="{$variant.url}"
         class="{$variant.type}"
         title="{$variant.name}"
        {if $variant.html_color_code} style="background-color: {$variant.html_color_code}" {/if}
        {if $variant.texture} style="background-image: url({$variant.texture})" {/if}
      ><span class="sr-only">{$variant.name}</span></a>
    </li>
  {/foreach}
  <span class="js-count count"></span>
</ul>
