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

{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}

  {hook h='displayPaymentTop'}

  {* used by javascript to correctly handle cart updates when we are on payment step (eg vouchers added) *}
  <div style="display:none" class="js-cart-payment-step-refresh"></div>

  {if !empty($display_transaction_updated_info)}
    <p class="cart-payment-step-refreshed-info">
      {l s='Transaction amount has been correctly updated' d='Shop.Theme.Checkout'}
    </p>
  {/if}

  {if $is_free}
    <p>{l s='No payment needed for this order' d='Shop.Theme.Checkout'}</p>
  {/if}
  <div class="payment-options{if $is_free} d-none{/if}">
    {foreach from=$payment_options item="module_options"}
      {foreach from=$module_options item="option"}
        <div id="{$option.id}-container" class="payment-option clearfix custom-control custom-radio">
          {* This is the way an option should be selected when Javascript is enabled *}
          <input class="custom-control-input{if $option.binary} binary{/if}" id="{$option.id}" data-module-name="{$option.module_name}" name="payment-option" type="radio" required {if $selected_payment_option == $option.id || $is_free} checked {/if}>
          <label class="ps-shown-by-js custom-control-label" for="{$option.id}">
            {if $option.logo}
              <img class="img-fluid" src="{$option.logo}">
            {/if}
            {$option.call_to_action_text}
          </label>
          {* This is the way an option should be selected when Javascript is disabled *}
          <form method="GET" class="ps-hidden-by-js">
            {if $option.id === $selected_payment_option}
              {l s='Selected' d='Shop.Theme.Checkout'}
            {else}
              <button class="ps-hidden-by-js" type="submit" name="select_payment_option" value="{$option.id}">
                {l s='Choose' d='Shop.Theme.Actions'}
              </button>
            {/if}
          </form>

          <label class="ps-hidden-by-js" for="{$option.id}">
            <span>{$option.call_to_action_text}</span>
            {if $option.logo}
              <img src="{$option.logo}">
            {/if}
          </label>

        </div>
        {if $option.additionalInformation}
          <div id="{$option.id}-additional-information" class="js-additional-information definition-list additional-information{if $option.id != $selected_payment_option} ps-hidden {/if}">
            {$option.additionalInformation nofilter}
          </div>
        {/if}
        <div
                id="pay-with-{$option.id}-form"
                class="js-payment-option-form {if $option.id != $selected_payment_option} ps-hidden {/if}"
        >
          {if $option.form}
            {$option.form nofilter}
          {else}
            <form id="payment-form-{$option.id}" method="POST" action="{$option.action nofilter}">
              {foreach from=$option.inputs item=input}
                <input type="{$input.type}" name="{$input.name}" value="{$input.value}">
              {/foreach}
              <button style="display:none" id="pay-with-{$option.id}" type="submit"></button>
            </form>
          {/if}
        </div>
      {/foreach}
      {foreachelse}
      <p class="alert alert-danger">{l s='Unfortunately, there are no payment method available.' d='Shop.Theme.Checkout'}</p>
    {/foreach}
  </div>
  {if $conditions_to_approve|count}
    <p class="ps-hidden-by-js">
      {* At the moment, we're not showing the checkboxes when JS is disabled
         because it makes ensuring they were checked very tricky and overcomplicates
         the template. Might change later.
      *}
      {l s='By confirming the order, you certify that you have read and agree with all of the conditions below:' d='Shop.Theme.Checkout'}
    </p>
    <form id="conditions-to-approve" method="GET">
      <ul>
        {foreach from=$conditions_to_approve item="condition" key="condition_name"}
          <li class="custom-control custom-checkbox">
            <input id="conditions_to_approve[{$condition_name}]" name="conditions_to_approve[{$condition_name}]" required type="checkbox" value="1" class="custom-control-input ps-shown-by-js">
            <label class="js-terms custom-control-label" for="conditions_to_approve[{$condition_name}]">{$condition nofilter}</label>
          </li>
        {/foreach}
      </ul>
    </form>
  {/if}

  {if $show_final_summary}
    {include file='checkout/_partials/order-final-summary.tpl'}
  {/if}
  <div id="payment-confirmation" class="pt-5">
    <div class="ps-shown-by-js">
      {if $show_final_summary}
        <article class="alert alert-danger mt-2 js-alert-payment-conditions" role="alert" data-alert="danger">
          {l
          s='Please make sure you\'ve chosen a [1]payment method[/1] and accepted the [2]terms and conditions[/2].'
          sprintf=[
          '[1]' => '<a href="#checkout-payment-step">',
          '[/1]' => '</a>',
          '[2]' => '<a href="#conditions-to-approve">',
          '[/2]' => '</a>'
          ]
          d='Shop.Theme.Checkout'
          }
        </article>
      {/if}
      <button type="submit" {if !$selected_payment_option} disabled {/if} class="btn btn-primary btn-md center-block">
        {l s='Order with an obligation to pay' d='Shop.Theme.Checkout'}
      </button>
    </div>
    <div class="ps-hidden-by-js">
      {if $selected_payment_option and $all_conditions_approved}
        <label for="pay-with-{$selected_payment_option}">{l s='Order with an obligation to pay' d='Shop.Theme.Checkout'}</label>
      {/if}
    </div>
  </div>
  {hook h='displayPaymentByBinaries'}

  <div id="modal" class="modal fade modal-close-inside">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <button type="button" class="close linearicons-cross2" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
        <div class="modal-body js-modal-content"></div>
      </div>
    </div>
  </div>
{/block}