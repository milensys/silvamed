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

* @author     Zemez (Alexander Grosul)
* @copyright  2017-2020 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div class="jx-header-account{if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'dropdown'} dropdown js-dropdown dropdown{/if}">
  <a href="#" role="button"{if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'dropdown'} data-toggle="dropdown" class="dropdown-toggle"{else} data-toggle="modal" data-target="#jxha-modal-{$hook}"{/if}>
    <i class="linearicons-user" aria-hidden="true"></i>
    <span>
      {if $customer.is_logged}
        {l s='Your Account' mod='jxheaderaccount'}
      {else}
        {l s='Sign in' mod='jxheaderaccount'}
      {/if}
    </span>
  </a>
  {if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'dropdown'}
    <div class="dropdown-menu dropdown-menu-right">
      <button type="button" class="dropdown-close close linearicons-cross2"></button>
      {include file="../default/jxheaderaccount-content.tpl"}
    </div>
  {else}
    <div id="jxha-modal-{$hook}" class="modal fade modal-close-inside{if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'leftside'} left{elseif $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'rightside'} right{/if}" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          <button type="button" class="close linearicons-cross2" data-dismiss="modal" aria-label="Close"></button>
          <div class="modal-body">
            {include file="../default/jxheaderaccount-content.tpl"}
          </div>
        </div>
      </div>
    </div>
  {/if}
</div>