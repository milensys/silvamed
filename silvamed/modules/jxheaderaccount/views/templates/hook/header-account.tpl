{*
* 2017-2020 Zemez
*
* JX Header Account
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
* @author     Zemez
* @copyright  2017-2020 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{assign var=back_page value = $link->getPageLink('index')}
{if $f_status || $g_status || $vk_status}
  <div class="clearfix social-login-buttons row align-items-center justify-content-center mt-3">
    {if $f_status}
      <div class="col-auto">
        <a href="{$link->getModuleLink('jxheaderaccount', 'facebooklogin', [], true)}" title="{l s='Login with Your Facebook Account' mod='jxheaderaccount'}">
          <i class="fa fa-facebook" aria-hidden="true"></i><span class="d-none">{l s='Facebook Login' mod='jxheaderaccount'}</span>
        </a>
      </div>
    {/if}
    {if $g_status}
      <div class="col-auto">
        <a {if isset($back) && $back}href="{$link->getModuleLink('jxheaderaccount', 'googlelogin', ['back' => $back], true)}" {else}href="{$link->getModuleLink('jxheaderaccount', 'googlelogin', ['back' => $back_page], true)}"{/if} title="{l s='Login with Your Google Account' mod='jxheaderaccount'}">
          <i class="fa fa-google-plus" aria-hidden="true"></i><span class="d-none">{l s='Google Login' mod='jxheaderaccount'}</span>
        </a>
      </div>
    {/if}
    {if $vk_status}
      <div class="col-auto">
        <a {if isset($back) && $back}href="{$link->getModuleLink('jxheaderaccount', 'vklogin', ['back' => $back], true)}" {else}href="{$link->getModuleLink('jxheaderaccount', 'vklogin', ['back' => $back_page], true)}"{/if} title="{l s='Login with Your VK Account' mod='jxheaderaccount'}">
          <i class="fa fa-vk" aria-hidden="true"></i><span class="d-none">{l s='VK Login' mod='jxheaderaccount'}</span>
        </a>
      </div>
    {/if}
  </div>
{/if}