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
{extends file=$layout}

{block name='content'}

  <section id="main">
    <h1 class="text-center mb-5 products-section-title">{l s='Shopping Cart' d='Shop.Theme.Checkout'}</h1>
    <div class="cart-grid row">
      <!-- Left Block: cart product informations & shpping -->
      <div class="cart-grid-body col-12 col-lg-8 offset-lg-2">

        <!-- cart products detailed -->
        <div class="cart-container">
          {block name='cart_overview'}
            {include file='checkout/_partials/cart-detailed.tpl' cart=$cart}
          {/block}
        </div>

        <!-- shipping informations -->
        {block name='hook_shopping_cart_footer'}
          {hook h='displayShoppingCartFooter'}
        {/block}
      </div>

      <div class="cart-grid-bottom col-12 col-lg-8 offset-lg-2">

        {block name='cart_summary'}
          <div class="cart-summary mb-3">

            {block name='hook_shopping_cart'}
              {hook h='displayShoppingCart'}
            {/block}

            <div class="row mb-5">
              <div class="col-12">
                {block name='cart_totals'}
                  {include file='checkout/_partials/cart-detailed-totals.tpl' cart=$cart}
                {/block}
              </div>
            </div>

            <div class="row">
              <div class="col">
                {block name='continue_shopping'}
                  <a class="btn btn-secondary btn-md mb-3" href="{$urls.pages.index}">
                    {l s='Continue shopping' d='Shop.Theme.Actions'}
                  </a>
                {/block}
              </div>
              <div class="col-auto">
                {block name='cart_actions'}
                  {include file='checkout/_partials/cart-detailed-actions.tpl' cart=$cart}
                {/block}
              </div>
            </div>
          </div>
        {/block}

        {block name='hook_reassurance'}
          {hook h='displayReassurance'}
        {/block}

      </div>

    </div>
  </section>
{/block}
