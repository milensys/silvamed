{*
* 2017-2019 Zemez
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
* @author     Zemez (Alexander Grosul)
* @copyright  2017-2019 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div id="_desktop_user_info">
  <div class="jx-header-account{if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'dropdown'} dropdown js-dropdown{/if}">
    <a href="#" role="button"{if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'dropdown'} data-toggle="dropdown" class="dropdown-toggle"{else} data-toggle="modal" data-target="#jxha-modal-{$hook}"{/if}>
      <i class="fa fa-user-o" aria-hidden="true"></i>
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
        {include file="../default/jxheaderaccount-content.tpl"}
      </div>
    {else}
      <div id="jxha-modal-{$hook}" class="modal fade{if $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'leftside'} left{elseif $configs.JXHEADERACCOUNT_DISPLAY_TYPE == 'rightside'} right{/if}" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              {include file="../default/jxheaderaccount-content.tpl"}
            </div>
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>