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

<div class="block-newsletter">
  <h4 class="mb-3">{l s='Subscribe to Newsletter' d='Modules.Emailsubscription.Shop'}</h4>
  {if $conditions}
    <p id="block-newsletter-label">{$conditions}</p>
  {/if}
  {if $msg}
    <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
      {$msg}
    </p>
  {/if}

  <form action="{$urls.pages.index}#footer" method="post" class="mx-auto">
    <input type="hidden" name="action" value="0">
    <input
      class="form-control form-control-lg"
      name="email"
      type="email"
      value="{$value}"
      placeholder="{l s='Your e-mail' d='Modules.Emailsubscription.Shop'}"
      aria-labelledby="block-newsletter-label"
    >
    <input
        class="btn btn-default btn-lg w-100"
        name="submitNewsletter"
        type="submit"
        value="{l s='Subscribe' d='Modules.Emailsubscription.Shop'}"
    >
    {if isset($id_module)}
      <div class="mt-3">
        {hook h='displayGDPRConsent' id_module=$id_module}
      </div>
    {/if}
  </form>
</div>
