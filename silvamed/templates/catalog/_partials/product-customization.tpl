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
<section class="product-customization my-3">
  {if !$configuration.is_catalog}
    <h3 class="subpage-title mb-2">{l s='Product customization' d='Shop.Theme.Catalog'}</h3>
    <div class="alert alert-warning">{l s='Don\'t forget to save your customization to be able to add to cart' d='Shop.Forms.Help'}</div>
    {block name='product_customization_form'}
      <form id="product-customization" method="post" action="{$product.url}" enctype="multipart/form-data">
        <ul class="row">
          {foreach from=$customizations.fields item="field" name=field}
            <li class="product-customization-item col-12 {if $field.type == 'text'}col-xl mt-3 mt-xl-0{else}col-xl-auto{/if}">
              <label> {$field.label}</label>
              {if $field.type == 'text'}
                <textarea placeholder="{l s='Your message here' d='Shop.Forms.Help'}" class="form-control form-control-sm product-message" maxlength="250" {if $field.required} required {/if} name="{$field.input_name}"></textarea>
                <small class="float-right">{l s='250 char. max' d='Shop.Forms.Help'}</small>
                {if $field.text !== ''}
                  <h6 class="customization-message">{l s='Your customization:' d='Shop.Theme.Catalog'}
                    <label>{$field.text}</label>
                  </h6>
                {/if}
              {elseif $field.type == 'image'}
                {if $field.is_customized}
                  <br>
                  <img src="{$field.image.small.url}">
                  <a class="remove-image" href="{$field.remove_image_url}" rel="nofollow">{l s='Remove Image' d='Shop.Theme.Actions'}</a>
                {/if}
                <div class="custom-file-wrapper">
                  <label class="custom-file">
                    <span class="input-group">
                      <span class="form-control form-control-sm js-file-name">{l s='No selected file' d='Shop.Forms.Help'}</span>
                      <span class="input-group-append">
                        <span class="btn btn-default btn-sm">{l s='Choose file' d='Shop.Theme.Actions'}</span>
                      </span>
                    </span>
                    <input class="file-input js-file-input form-control custom-file-input" {if $field.required} required {/if} type="file" name="{$field.input_name}">
                  </label>
                </div>
                <small>{l s='.png .jpg .gif' d='Shop.Forms.Help'}</small>
              {/if}
              {if $smarty.foreach.field.last}
                <div class="clearfix text-right mt-3">
                  <button class="btn btn-primary btn-md" type="submit" name="submitCustomizedData">{l s='Save Customization' d='Shop.Theme.Actions'}</button>
                </div>
              {/if}
            </li>
          {/foreach}
        </ul>
      </form>
    {/block}
  {/if}
</section>