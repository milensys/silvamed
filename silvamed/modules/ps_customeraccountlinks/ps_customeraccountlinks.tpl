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

<div class="block_myaccount_infos{if isset($original_hook_name) && ($original_hook_name == 'displayFooter' || $original_hook_name == 'displayFooterBefore')} footer-links{/if}">
  <h3 class="d-none title-block">
    <a href="{$urls.pages.my_account}" rel="nofollow">
        {l s='Your account' d='Shop.Theme.Customeraccount'}
    </a>
  </h3>
  <h3 class="h4 d-flex justify-content-between align-items-center collapsed d-md-none title-block" data-target="#account-list-block" data-toggle="collapse">
      {l s='Your account' d='Shop.Theme.Customeraccount'}
    <i class="fa fa-angle-down" aria-hidden="true"></i>
  </h3>
  <ul id="account-list-block" class="list-default collapse d-md-block">
      {foreach from=$my_account_urls item=my_account_url}
        <li>
          <a href="{$my_account_url.url}" title="{$my_account_url.title}" rel="nofollow">
              {$my_account_url.title}
          </a>
        </li>
      {/foreach}
      {hook h='displayMyAccountBlock'}
  </ul>
</div>