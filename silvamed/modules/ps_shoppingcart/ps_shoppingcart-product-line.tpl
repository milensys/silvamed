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

<div class="media">
  <a class="product-thumbnail" href="{$product.url}" title="{$product.name}">
    <img src="{$product.cover.medium.url}" class="img-fluid" alt="{$product.name}"/>
  </a>
  <div class="media-body">
    <h3 class="product-title"><a href="{$product.url}">{$product.name|truncate:'30'}</a></h3>
    <div class="product-price mb-1">
      <span class="price">{$product.price}</span>
      {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    </div>

    {if $product.attributes}
      <div class="product-attributes d-flex align-items-center flex-wrap">
        <p class="cart-product-quantity mr-1">{$product.quantity} x</p>
        {foreach from=$product.attributes name='attribute' item='attribute'}
          <p>{$attribute}{if !$smarty.foreach.attribute.last}, {/if}</p>
        {/foreach}
      </div>
    {/if}
    <a class="remove-from-cart close mt-1"
       rel="nofollow"
       href="{$product.remove_from_cart_url}"
       data-link-action="remove-from-cart"
       aria-label="Close"
    >{l s='Delete' d='Shop.Theme.Catalog'}
    </a>
  </div>
</div>
{if $product.customizations|count}
  <div class="customizations-toggle mt-2">
    {foreach from=$product.customizations item="customization"}
      <a class="btn btn-sm btn-dark" data-toggle="collapse" href="#customization-{$customization.id_customization}" aria-expanded="false" aria-controls="customization-{$customization.id_customization}">
        {l s='Product customization' d='Shop.Theme.Catalog'}
      </a>
    {/foreach}
  </div>
{/if}
{if $product.customizations|count}
  {foreach from=$product.customizations item="customization"}
    <div id="customization-{$customization.id_customization}" class="customization collapse mt-3">
      <ul class="list-group">
        {foreach from=$customization.fields item="field"}
          <li class="list-group-item">
            <label>{$field.label}</label>
            <div>
              {if $field.type == 'text'}
                <small>{$field.text}</small>
              {elseif $field.type == 'image'}
                <img src="{$field.image.small.url}" class="img-fluid">
              {/if}
            </div>
          </li>
        {/foreach}
      </ul>
    </div>
  {/foreach}
{/if}