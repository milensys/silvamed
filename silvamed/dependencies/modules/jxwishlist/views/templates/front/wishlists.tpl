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

{extends file=$layout}

{block name="content"}
  <section id="main">
    <div id="mywishlists">
      <header class="page-header">
        <h1>{l s='My wishlists' mod='jxwishlist'}</h1>
      </header>
      {if isset($confirmation_add)}
        <p class="alert alert-success">{l s='Add new wishlist - "%s"' sprintf=[$confirmation_name] mod='jxwishlist'}</p>
      {/if}
      {if isset($confirmation_change)}
        <p class="alert alert-success">{l s='This name is change' mod='jxwishlist'}</p>
      {/if}
      {if $id_customer|intval neq 0}
        <section class="page-content card card-block">
          <form method="post" class="std box" id="form_wishlist">
            <fieldset>
              <h3 class="page-subheading">{l s='New wishlist' mod='jxwishlist'}</h3>
              <div class="form-group row">
                <label class="col-md-3 form-control-label" for="name">{l s='Name' mod='jxwishlist'}</label>
                <div class="col-md-6">
                  <input autocomplete="off" type="text" id="name_wishlist" name="name" class="inputTxt form-control" value="{if isset($smarty.post.name)}{$smarty.post.name|escape:'html':'UTF-8'}{/if}"/>
                  <input type="hidden" name="token" value="{$token|escape:'html':'UTF-8'}"/>
                </div>
              </div>
              <footer class="form-footer clearfix">
                <button id="submitWishlists" class="btn btn-primary form-control-submit pull-xs-right" name="submitWishlists" type="submit">
                  <span>{l s='Save' mod='jxwishlist'}</span>
                </button>
                <input id="id_wishlist" type="hidden" name="id_wishlist" value=""/>
              </footer>
            </fieldset>
          </form>
        </section>
        {if $wishlists}
          <ul class="all-wishlist">
            {foreach from=$wishlists item=wishlist name=wishlist}
              <li data-wishlist-id="{$wishlist.id_wishlist|intval}" id="wishlist_{$wishlist.id_wishlist|intval}" data-wishlist-name="{$wishlist.name|truncate:22:'...'|escape:'html':'UTF-8'}">
                <h3>
                  <span>{$wishlist.name|truncate:50:'...'|escape:'html':'UTF-8'}</span>
                  <a class="delete-wishlist" href="#" onclick="javascript:event.preventDefault();return (WishlistDelete('wishlist_{$wishlist.id_wishlist|intval}', '{$wishlist.id_wishlist|intval}', '{l s='Do you really want to delete this wishlist ?' mod='jxwishlist' js=1}'));">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                  </a>
                  <a class="edit-wishlist" href="#" onclick="WishlistEdit('{$wishlist.id_wishlist|intval}');">
                    <i class="fa fa-pencil" aria-hidden="true"></i>
                  </a>
                </h3>
                <div class="wishlist-products-container">
                  {assign var='products' value=ClassJxWishlist::getProductByIdWishlist($wishlist.id_wishlist)}
                  {if $products}
                    <ul class="row">
                      {foreach from=$products item=product name=product}
                        {if $product.id_wishlist == $wishlist.id_wishlist}
                          <li class="clp_{$product.id_product|escape:'htmlall':'UTF-8'}_{$product.id_product_attribute|escape:'htmlall':'UTF-8'} col-xs-12 col-sm-4 col-md-3">
                            <div class="product_image">
                              <img class="img-fluid" src="{$link->getImageLink($product.link_rewrite, $product.cover, 'home_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}"/>
                              <a class="lnkdel" href="javascript:;" onclick="DeleteProduct('{$wishlist.id_wishlist|intval}', '{$product.id_product|intval}', '{$product.id_product_attribute|intval}')" title="{l s='Delete' mod='jxwishlist'}">
                                <span aria-hidden="true">&times;</span>
                              </a>
                            </div>
                            <h5>
                              <a class="product-name" href="{$link->getProductlink($product.id_product, $product.link_rewrite)|escape:'html':'UTF-8'}" title="{$product.name|escape:'html':'UTF-8'}">
                                <span class="quantity-formated"><span class="quantity">{$product.quantity|intval}</span> x </span>{$product.name|truncate:25:'...'|escape:'html':'UTF-8'}
                              </a>
                            </h5>
                          </li>
                        {/if}
                      {/foreach}
                    </ul>
                  {else}
                    <p class="alert alert-warning">{l s='No products in this wishlist.' mod='jxwishlist'}</p>
                  {/if}
                </div>
                <div class="clearfix wishlist-row-bottom">
                  <a target="_blank" href="{$link->getModuleLink('jxwishlist', 'wishlist', ['token' => $wishlist.token])|escape:'htmlall':'UTF-8'}" class="btn btn-view-wishlist button">
                    {l s='View wishlist' mod='jxwishlist'}
                  </a>
                  {if $products}
                    <button type="button" id="add-new-layout" class="btn"><span>{l s='Share' mod='jxwishlist'}</span>
                    </button>
                  {/if}
                  <span class="btn-product-wishlist" href="#">
                  <i class="fa fa-eye right-space" aria-hidden="true"></i>
                    {l s='View products' mod='jxwishlist'}
                </span>
                </div>
              </li>
            {/foreach}
          </ul>
        {/if}
        <div id="block-order-detail">&nbsp;</div>
      {/if}
      <footer class="page-footer">
        <a class="account-link" href="{$urls.pages.my_account}">
          <i class="fa fa-angle-left" aria-hidden="true"></i>
          <span>{l s='Back to Your Account' mod='jxwishlist'}</span>
        </a>
        <a href="{$urls.pages.index}" class="account-link">
          <i class="fa fa-angle-left" aria-hidden="true"></i>
          <span>{l s='Home' mod='jxwishlist'}</span>
        </a>
      </footer>
  </section>
{/block}
