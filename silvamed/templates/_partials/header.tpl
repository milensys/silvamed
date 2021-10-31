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

{assign var='displayMegaHeader' value={hook h='jxMegaLayoutHeader'}}
{if $displayMegaHeader}
  {$displayMegaHeader nofilter}
{else}
  {block name='header_banner'}
    <div class="header-banner">
      {hook h='displayBanner'}
    </div>
  {/block}

  {block name='header_nav'}
    <nav class="header-nav">
      <div class="container">
        <div class="row">
          <div class="col">
            {hook h='displayNav1'}
          </div>
          <div class="col-auto justify-content-end">
            {hook h='displayNav2'}
          </div>
        </div>
      </div>
    </nav>
  {/block}

  {block name='header_top'}
    <div class="header-top">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-12 col-xl-3 text-center text-xl-left mb-md-2 mb-xl-0">
            {if $page.page_name == 'index'}
              <h1>
                <a href="{$urls.base_url}">
                  <img class="logo img-responsive" src="{$shop.logo}" alt="{$shop.name}">
                </a>
              </h1>
            {else}
              <a href="{$urls.base_url}">
                <img class="logo img-responsive" src="{$shop.logo}" alt="{$shop.name}">
              </a>
            {/if}
          </div>
          <div class="col-12 col-xl-9 d-flex justify-content-center justify-content-xl-end align-items-center">
            {hook h='displayTop'}
          </div>
        </div>
      </div>
    </div>
  {/block}
{/if}
