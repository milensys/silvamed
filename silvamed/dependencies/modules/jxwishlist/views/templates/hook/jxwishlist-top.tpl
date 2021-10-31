{*
* 2017-2018 Zemez
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
*  @copyright 2017-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
<div id="jxwishlist-link">
  <a href="{$link->getModuleLink('jxwishlist', 'wishlists', array(), true)|escape:'htmlall':'UTF-8'}">
    <i class="fa fa-heart right-space" aria-hidden="true"></i>
    <span>{l s='My wishlists' mod='jxwishlist'}</span>
    {if $jx_wishlist_display_total}
      (<span class="counter">{if $jx_wishlist_total}{$jx_wishlist_total|escape:'htmlall':'UTF-8'}{else}0{/if}</span>)
    {/if}
  </a>
</div>