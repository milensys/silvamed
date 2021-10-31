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
<!doctype html>
<html lang="{$language.iso_code}">

  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{$page.body_classes|classnames}">
    <main>
      <header id="header">
        {block name='header'}
          {include file='checkout/_partials/header.tpl'}
        {/block}
      </header>

      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}

      <section id="wrapper">
        {hook h="displayWrapperTop"}
        <div class="container">

        {block name='content'}
          <section id="content">
            <div class="row sidebar-wrapper">
              <div class="col-12 col-md-7 col-lg-8">
                {block name='cart_summary'}
                  {render file='checkout/checkout-process.tpl' ui=$checkout_process}
                {/block}
              </div>
              <div class="col-12 col-md-5 col-lg-4 mt-6 mt-md-0">
                <div class="sidebar">
                  {block name='cart_summary'}
                    {include file='checkout/_partials/cart-summary.tpl' cart = $cart}
                  {/block}

                  {capture name='displayReassurance'}{hook h='displayReassurance'}{/capture}
                  {if $smarty.capture.displayReassurance}
                    <hr>
                    {hook h='displayReassurance'}
                  {/if}
                </div>
              </div>
            </div>
          </section>
        {/block}
        </div>
        {hook h="displayWrapperBottom"}
      </section>

      <footer id="footer">
        <div class="container border-top-black py-4 py-md-5">
          {block name='footer'}
            {include file='checkout/_partials/footer.tpl'}
          {/block}
        </div>
      </footer>

      {block name='javascript_bottom'}
        {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
      {/block}
    </main>
  </body>

</html>
