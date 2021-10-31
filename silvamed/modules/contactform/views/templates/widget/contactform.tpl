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
<section class="contact-form">
  <form action="{$urls.pages.contact}" method="post" {if $contact.allow_file_upload}enctype="multipart/form-data"{/if}>

    {if $notifications}
      <div class="col-xs-12 alert {if $notifications.nw_error}alert-danger{else}alert-success{/if} alert-dismissible fade show">
        <ul class="mb-0">
          {foreach $notifications.messages as $notif}
            <li>{$notif}</li>
          {/foreach}
        </ul>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <i class="linearicons-cross2" aria-hidden="true"></i>
        </button>
      </div>
    {/if}

    {if !$notifications || $notifications.nw_error}
      <section class="form-fields">

        <h1 class="mb-3 products-section-title">{l s='Contact us' d='Shop.Theme.Global'}</h1>

        <div class="form-group row no-gutters align-items-center">
          <label class="label-auto-width col-12 col-xxl-2 mr-xxl-1">{l s='Subject' d='Shop.Forms.Labels'}</label>
          <div class="form-control-content col">
            <select name="id_contact" class="custom-select w-100">
              {foreach from=$contact.contacts item=contact_elt}
                <option value="{$contact_elt.id_contact}">{$contact_elt.name}</option>
              {/foreach}
            </select>
          </div>
        </div>

        <div class="form-group row no-gutters align-items-center">
          <label class="label-auto-width col-12 col-xxl-2 mr-xxl-1">{l s='Email address' d='Shop.Forms.Labels'}</label>
          <div class="form-control-content col">
            <input
              class="form-control"
              name="from"
              type="email"
              value="{$contact.email}"
              placeholder="{l s='your@email.com' d='Shop.Forms.Help'}"
              required
            >
          </div>
        </div>

        {if $contact.orders}
          <div class="form-group row no-gutters align-items-center">
            <label class="label-auto-width col-12 col-xxl-2 mr-xxl-1">{l s='Order reference' d='Shop.Forms.Labels'}</label>
            <div class="form-control-content col">
              <select name="id_order" class="custom-select w-100">
                <option value="">{l s='Select reference' d='Shop.Forms.Help'}</option>
                {foreach from=$contact.orders item=order}
                  <option value="{$order.id_order}">{$order.reference}</option>
                {/foreach}
              </select>
            </div>
          </div>
        {/if}

        {if $contact.allow_file_upload}
          <div class="form-group row no-gutters align-items-center">
            <label class="label-auto-width col-12 col-xxl-2 mr-xxl-1">{l s='Attachment' d='Shop.Forms.Labels'}</label>
            <div class="form-control-content col">
              <div class="custom-file-wrapper">
                <label class="custom-file">
                  <span class="input-group">
                    <span class="form-control js-file-name">{l s='No selected file' d='Shop.Theme.Actions'}</span>
                    <div class="input-group-append">
                      <span class="btn btn-default btn-md">{l s='Choose file' d='Shop.Theme.Actions'}</span>
                    </div>
                  </span>
                  <input class="file-input js-file-input form-control custom-file-input" type="file" name="fileUpload" data-buttonText="{l s='Choose file' d='Shop.Theme.Actions'}">
                </label>
              </div>
            </div>
          </div>
        {/if}

        <div class="form-group row no-gutters">
          <label class="label-auto-width col-12 col-xxl-2 mr-xxl-1 textarea-label">{l s='Message' d='Shop.Forms.Labels'}</label>
          <div class="form-control-content col">
            <textarea
              class="form-control"
              name="message"
              placeholder="{l s='How can we help?' d='Shop.Forms.Help'}"
              rows="3"
            >{if $contact.message}{$contact.message}{/if}</textarea>
          </div>
        </div>

        {if isset($id_module)}
          <div class="form-group row">
            <div class="offset-md-3">
              {hook h='displayGDPRConsent' id_module=$id_module}
            </div>
          </div>
        {/if}

      </section>

      <footer class="form-footer">
        <input class="d-none" type="text" name="url" value=""/>
        <input type="hidden" name="token" value="{$token}" />
        <input class="btn btn-default btn-md" type="submit" name="submitMessage" value="{l s='Send' d='Shop.Theme.Actions'}">
      </footer>
    {/if}

  </form>
</section>
