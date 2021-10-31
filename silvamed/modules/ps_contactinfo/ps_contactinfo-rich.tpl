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

<div class="contact-rich mt-4 mt-lg-0">
  <h1 class="mb-3 products-section-title">{l s='Store information' d='Shop.Theme.Global'}</h1>
  <ul class="row">
    {if $contact_infos.address.address1}
      <li class="col-12 col-sm-6">
        <h3>
          <i class="fa fa-map-marker" aria-hidden="true"></i>
          {l s='Address 1' d='Shop.Theme.Global'}
        </h3>
        <p>
          {$contact_infos.address.address1 nofilter}
        </p>
      </li>
    {/if}
    {if $contact_infos.address.address2}
      <li class="col-12 col-sm-6">
        <h3>
          <i class="fa fa-map-marker" aria-hidden="true"></i>
          {l s='Address 2' d='Shop.Theme.Global'}
        </h3>
        <p>
          {$contact_infos.address.address2 nofilter}
        </p>
      </li>
    {/if}
    {if $contact_infos.phone}
      <li class="col-12 col-sm-6">
        <h3>
          <i class="fa fa-phone" aria-hidden="true"></i>
          {l s='Call us:' d='Shop.Theme.Global'}
        </h3>
        <p class="number">
          <a href="tel:{$contact_infos.phone}">{$contact_infos.phone}</a>
        </p>
      </li>
    {/if}
    {if $contact_infos.address.postcode}
      <li class="col-12 col-sm-6">
        <h3>
          <i class="fa fa-fax" aria-hidden="true"></i>
          {l s='Post code:' d='Shop.Theme.Global'}
        </h3>
        <p class="number">
          {$contact_infos.address.postcode}
        </p>
      </li>
    {/if}
    {if $contact_infos.fax}
      <li class="col-12 col-sm-6">
        <h3>
          <i class="fa fa-fax" aria-hidden="true"></i>
          {l s='Fax:' d='Shop.Theme.Global'}
        </h3>
        <p class="number">
          {$contact_infos.fax}
        </p>
      </li>
    {/if}
    {if $contact_infos.email}
      <li class="col-12 col-sm-6">
        <h3>
          <i class="fa fa-envelope" aria-hidden="true"></i>
          {l s='Email us:' d='Shop.Theme.Global'}
        </h3>
        <p>
          <a href="mailto:{$contact_infos.email}">{$contact_infos.email}</a>
        </p>
      </li>
    {/if}
  </ul>
</div>
