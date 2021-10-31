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
{extends file='page.tpl'}

{block name='page_title'}
  {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <form action="{$urls.pages.password}" class="forgotten-password mx-auto" method="post">

    <div class="help-block">
      <ul>
        {foreach $errors as $error}
          <li class="alert alert-danger">
            {$error}
          </li>
        {/foreach}
      </ul>
    </div>

    <header>
      <p class="send-renew-password-link">{l s='Please enter the email address you used to register. You will receive a temporary link to reset your password.' d='Shop.Theme.Customeraccount'}</p>
    </header>

    <section class="form-fields">
      <div class="form-group center-email-fields">
        <label class="form-control-label required d-none">{l s='Email address' d='Shop.Forms.Labels'}</label>
        <div class="email">
          <input type="email" name="email" id="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" class="form-control" placeholder="{l s='Email address' d='Shop.Forms.Labels'}" required>
        </div>
      </div>
    </section>
    <footer class="form-footer clearfix text-center mt-3 d-flex flex-column align-items-center justify-content-center">
      <button class="form-control-submit btn btn-default btn-md" name="submit" type="submit">
        {l s='Send reset link' d='Shop.Theme.Actions'}
      </button>
      <a href="{$urls.pages.authentication}" class="btn btn-secondary btn-md mt-2">
        {l s='Back to login' d='Shop.Theme.Actions'}
      </a>
    </footer>

  </form>
{/block}
