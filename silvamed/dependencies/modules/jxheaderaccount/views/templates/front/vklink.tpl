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
{extends file=$layout}
{block name='breadcrumb'}
  <nav class="breadcrumb hidden-sm-down">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList">
      <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
        <a href="{$link->getPageLink('my-account', true)}" title="{l s='Manage my account' mod='jxheaderaccount'}" rel="nofollow">{l s='My account' mod='jxheaderaccount'}</a>
      </li>
      <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <span>
            <span itemprop="name">{l s='VK account' mod='jxheaderaccount'}</span>
          </span>
      </li>
    </ol>
  </nav>
{/block}
{block name="content"}
<div class="sociallogininfo">
  {if $vk_status == 'error'}
    <div class="alert alert-danger">
      {$vk_massage}
    </div>
    <div class="box clearfix">
      {if isset($vk_picture)}
        <div class="social-avatar"><img class="img-responsive" src="{$vk_picture}"></div>
      {/if}
      <h4 class="social-name">{$vk_name}<strong></strong>
    </div>
  {elseif $vk_status == 'linked' || $vk_status == 'confirm'}
    <div class="alert alert-success">
      {$vk_massage}
    </div>
    <div class="box clearfix">
      {if isset($vk_picture)}
        <div class="social-avatar"><img class="img-responsive" src="{$vk_picture}"></div>
      {/if}
      <h4 class="social-name">{$vk_name}</h4>
    </div>
  {else}
    <div class="alert alert-danger">
      {l s='Sorry, there was error with VK Profile Connect.' mod='jxheaderaccount'}
    </div>
  {/if}
</div>
{/block}