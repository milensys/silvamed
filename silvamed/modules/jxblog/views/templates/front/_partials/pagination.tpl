{*
* 2017-2020 Zemez
*
* JX Blog
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
*  @author    Zemez (Alexander Grosul)
*  @copyright 2017-2020 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
<div class="row align-items-center flex-wrap mt-2">
  <div class="showing my-2 col-12 text-center{if isset($pagination.steps) && $pagination.steps} col-md-6 order-md-2 text-md-right{/if}">
    {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.from ,'%to%' => $pagination.to, '%total%' => $pagination.total]}
  </div>

  {if isset($pagination.steps) && $pagination.steps}
    <div class="my-2 col-12 col-md-6 order-md-1">
      <nav class="pagination justify-content-center justify-content-md-start">
        <ul class="page-list d-flex flex-wrap align-items-center mb-0">
          {foreach from=$pagination.steps item='step'}
            <li class="{if $step.active}current{/if}">
              <a href="{$step.url}"
                 class="{if $step.type === 'previous'}previous {elseif $step.type === 'next'}next {else}{/if}{if $step.active}disabled{/if}">
                {if $step.type === 'previous'}
                  <i class="linearicons-arrow-left"></i>
                  <span class="d-none">{l s='Previous' d='Shop.Theme.Actions'}</span>
                {elseif $step.type === 'next'}
                  <span class="d-none">{l s='Next' d='Shop.Theme.Actions'}</span>
                  <i class="linearicons-arrow-right"></i>
                {else}
                  {$step.name}
                {/if}
              </a>
            </li>
          {/foreach}
        </ul>
      </nav>
    </div>
  {/if}
</div>
