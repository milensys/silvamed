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
            <span itemprop="name">{l s='VK registration' mod='jxheaderaccount'}</span>
          </span>
      </li>
    </ol>
  </nav>
{/block}
{block name="content"}
<form action="{$link->getModuleLink('jxheaderaccount', 'vkregistration', array(), true)}" method="post" class="box">
  <div class="row">
    <div class="form-group col-lg-6">
      <img class="img-responsive" src="{$profile_image_url}" alt="{$user_name}"/>
    </div>
    <div class="col-lg-6">
      <div class="form-group">
        <label>{l s='First name' mod='jxheaderaccount'}</label>
        <input type="text" class="form-control" name="given_name" value="{$given_name}"/>
      </div>
      <div class="form-group">
        <label>{l s='Last name' mod='jxheaderaccount'}</label>
        <input type="text" class="form-control" name="family_name" value="{$family_name}"/>
      </div>
      <div class="form-group">
        <label>{l s='Gender' mod='jxheaderaccount'}</label>
        <label class="radio-inline">
          <input type="radio" value="2" name="gender" {if $gender == 'male' || $gender == 2}checked{/if} />{l s='Male' mod='jxheaderaccount'}
        </label>
        <label class="radio-inline">
          <input type="radio" value="1" name="gender" {if $gender == 'famale' || $gender == 1}checked{/if} />{l s='Famale' mod='jxheaderaccount'}
        </label>
      </div>
      <div class="form-group">
        <label>{l s='Email' mod='jxheaderaccount'}</label>
        <input class="form-control" name="user_email" value="{$email}" disabled/>
      </div>
    </div>
  </div>
  <input type="hidden" name="user_id" value="{$user_id}"/>
  <input type="hidden" name="profile_image_url" value="{$profile_image_url}"/>
  <input type="hidden" name="email" value="{$email}"/>
  <input type="hidden" name="done" value="1"/>
  {hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}
  <div class="text-right">
    <button class="btn btn-primary" type="submit">{l s='Register' mod='jxheaderaccount'}</button>
  </div>
</form>
{/block}