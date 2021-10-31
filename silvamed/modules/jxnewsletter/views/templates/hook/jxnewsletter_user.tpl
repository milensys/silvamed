{*
* 2017-2020 Zemez
*
* JX Newsletter
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
* @author   Zemez (Alexander Grosul)
* @copyright  2017-2020 Zemez
* @license  http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div id="newsletter_popup" class="jxnewsletter jxnewsletter-autorized d-flex align-items-center justify-content-center justify-content-md-end">
  <div class="jxnewsletter-inner">
    <div class="jxnewsletter-close icon"></div>
    <div class="jxnewsletter-header">
      <h5>{l s='Make your inbox beautiful' mod='jxnewsletter'}</h5>
      <h4>{$title|escape:'htmlall':'UTF-8'}</h4>
    </div>
    <div class="jxnewsletter-content">
      <div class="status-message"></div>
      <div class="description">{$content|escape:'quotes':'UTF-8'}</div>
      <div class="form-group mt-1 mt-md-3">
        <div class="form-control-content">
          <div class="input-group">
            <label class="d-none">{l s='Your E-Mail' mod='jxnewsletter'}</label>
            <input class="form-control form-control-lg" placeholder="{l s='Enter your e-mail'  mod='jxnewsletter'}" type="email" name="email"/>
            <div class="input-group-append">
              <button class="btn btn-default btn-lg jxnewsletter-submit">{l s='Subscribe' mod='jxnewsletter'}</button>
            </div>
          </div>
        </div>
      </div>
      {if isset($id_module)}
        {hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}
      {/if}
    </div>
    <div class="jxnewsletter-footer">
      <div class="custom-control custom-checkbox my-md-1">
        <label>
          <input class="custom-control-input" type="checkbox" name="disable_popup">
          <span class="custom-control-label">{l s='Do not show again' mod='jxnewsletter'}</span>
        </label>
      </div>
      <button class="btn-link p-0 jxnewsletter-close mt-1 mt-lg-4">{l s='No, thanks' mod='jxnewsletter'}</button>
    </div>
  </div>
</div>