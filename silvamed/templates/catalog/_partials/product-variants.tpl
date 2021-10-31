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
<div class="product-variants mt-3">
  {foreach from=$groups key=id_attribute_group item=group}
    {if !empty($group.attributes)}
      {if $group.attributes}
        <div class="product-variants-item">
          <h3>{$group.name}</h3>
          {if $group.group_type == 'select'}
            <select class="custom-select" id="group_{$id_attribute_group}" data-product-attribute="{$id_attribute_group}" name="group[{$id_attribute_group}]">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                <option value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
              {/foreach}
            </select>
          {else}
            <ul id="group_{$id_attribute_group}" class="variant-links">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                <li class="variant-links-item{if $group_attribute.selected} active{/if}">
                  <label{if $group.group_type == 'color'} class="color"{/if}{if $group.group_type == 'color'}{if $group_attribute.html_color_code} style="background-color: {$group_attribute.html_color_code}"{/if}{if $group_attribute.texture} style="background-image: url({$group_attribute.texture})"{/if}{/if}>
                    <input type="radio" data-product-attribute="{$id_attribute_group}" name="group[{$id_attribute_group}]" value="{$id_attribute}"{if $group_attribute.selected} checked="checked"{/if}>
                    <span>{$group_attribute.name}</span>
                    <span class="sr-only">{$group_attribute.name}</span>
                  </label>
                </li>
              {/foreach}
            </ul>
          {/if}
        </div>
      {/if}
    {/if}
  {/foreach}
</div>
