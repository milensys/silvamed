{*
* 2017-2020 Zemez
*
* JX Wishlist
*
* NOTICE OF LICENSE
*
* This source file is subject to the General Public License (GPL 2.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/GPL-2.0
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade the module to newer
* versions in the future.
*
*  @author    Zemez
*  @copyright 2017-2020 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
{if isset($wishlists)}
  {foreach from=$wishlists item=wishlist name=wishlist}
    {assign var='productsAdd' value=ClassJxWishlist::getProductByIdWishlist($wishlist.id_wishlist)}
    {foreach from=$productsAdd item=productAdd name=productAdd}
      {if $productAdd.id_product == $product.id_product}
        {assign var='productSelected' value=true}
        {break}
      {/if}
    {/foreach}
    {if isset($productSelected)}{break}{/if}
  {/foreach}
{/if}

{if isset($wishlists)}
  {if $wishlists|count == 1 || $wishlists|count == 0}
    <a href="#" class="wishlist_button_nopop jx-wishlist-button{if isset($productSelected)} added-to-wishlist{/if}" onclick="AddProductToWishlist(event, 'action_add', '{$product.id_product|intval}', '{$product.name|escape:'quotes':'UTF-8'}', '{Product::getDefaultAttribute($product.id_product)}', 1); return false;" rel="nofollow" title="{l s='Add to my wishlist' mod='jxwishlist'}">
      <i class="linearicons-heart" aria-hidden="true"></i>
      <span>{l s='Add to wishlist' mod='jxwishlist'}</span>
    </a>
  {else}
    <a class="wishlist_button jx-wishlist-button{if isset($productSelected)} added-to-wishlist{/if}" tabindex="0" data-toggle="popover" title="{l s='Wishlist' mod='jxwishlist'}" data-placement="bottom">
      <i class="linearicons-heart" aria-hidden="true"></i>
      <span>{l s='Add to wishlist' mod='jxwishlist'}</span>
    </a>
    <div hidden class="popover-content-wishlist">
      {foreach from=$wishlists item=wishlist  name=cl}
        <div class="popover-item-wishlist" title="{$wishlist.name|escape:'html':'UTF-8'}" value="{$wishlist.id_wishlist|escape:'htmlall':'UTF-8'}" onclick="AddProductToWishlist(event, 'action_add', '{$product.id_product|intval}', '{$product.name|escape:'quotes':'UTF-8'}', '{Product::getDefaultAttribute($product.id_product)}', 1, '{$wishlist.id_wishlist|intval}');">
          {l s='Add to %s' sprintf=[$wishlist.name] mod='jxwishlist'}
        </div>
      {/foreach}
    </div>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        $(".wishlist_button").popover({
          html: true,
          content: function () {
            return $(this).next().html();
          }
        }).on('show.bs.popover', function (e) {
          $(e.currentTarget).closest('.product-miniature-container').addClass('hover');
        }).on('hidden.bs.popover', function (e) {
          $(e.currentTarget).closest('.product-miniature-container').removeClass('hover');
        });
      });
    </script>
  {/if}
{else}
  <a href="#" class="wishlist_button_nopop jx-wishlist-button" onclick="AddProductToWishlist(event, 'action_add', '{$product.id_product|intval}', '{$product.name|escape:'quotes':'UTF-8'}', '{Product::getDefaultAttribute($product.id_product)}', 1); return false;" rel="nofollow" title="{l s='Add to my wishlist' mod='jxwishlist'}">
    <i class="linearicons-heart" aria-hidden="true"></i>
    <span>{l s='Add to wishlist' mod='jxwishlist'}</span>
  </a>
{/if}

