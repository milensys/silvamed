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

<div class="block-contact">
  <h3 class="h5 title-block d-none">
    <a href="{$urls.pages.stores}">{l s='Store information' d='Shop.Theme.Global'}</a>
  </h3>
  <h3 class="h4 title-block d-flex justify-content-between align-items-center collapsed d-md-none" data-target="#contact-info-block" data-toggle="collapse">
      {l s='Store information' d='Shop.Theme.Global'}
    <i class="fa fa-angle-down" aria-hidden="true"></i>
  </h3>
  <ul id="contact-info-block" class="list-default collapse d-md-block">
    {if $contact_infos.address.address1 || $contact_infos.address.address2}
      <li>
        {$contact_infos.address.address1 nofilter}{if $contact_infos.address.address1 && $contact_infos.address.address2}, {/if}{$contact_infos.address.address2 nofilter}
      </li>
    {else}
      <li>
        {$contact_infos.address.formatted nofilter}
      </li>
    {/if}
    {if $contact_infos.phone}
      <li class="mt-2 mt-md-3">
        {* [1][/1] is for a HTML tag. *}
        {l s='[1]Call us: [/1][2]%phone%[/2]'
          sprintf=[
          '[1]' => '<span class="d-none">',
          '[/1]' => '</span>',
          '[2]' => '<a href="tel:'|cat:$contact_infos.phone|cat:'" class="number">',
          '[/2]' => '</a>',
          '%phone%' => $contact_infos.phone
          ]
          d='Shop.Theme.Global'
        }
      </li>
    {/if}
    {if $contact_infos.fax}
      <li class="mt-2">
        {* [1][/1] is for a HTML tag. *}
        {l
          s='[1]Fax: [/1][2]%fax%[/2]'
          sprintf=[
            '[1]' => '<span class="d-none">',
            '[/1]' => '</span>',
            '[2]' => '<a href="tel:'|cat:$contact_infos.fax|cat:'" class="number">',
            '[/2]' => '</a>',
            '%fax%' => $contact_infos.fax
          ]
          d='Shop.Theme.Global'
        }
      </li>
    {/if}
    {if $contact_infos.email}
      <li class="mt-2">
        {* [1][/1] is for a HTML tag. *}
        {l
          s='[1]Email us: [/1][2]%email%[/2]'
          sprintf=[
            '[1]' => '<span class="d-none">',
            '[/1]' => '</span>',
            '[2]' => '<a href="mailto:'|cat:$contact_infos.email|cat:'" class="mail">',
            '[/2]' => '</a>',
            '%email%' => $contact_infos.email
          ]
        d='Shop.Theme.Global'
        }
      </li>
    {/if}
  </ul>
</div>
