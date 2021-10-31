{*
* 2017-2018 Zemez
*
* JX Featured Products
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
* @copyright  2017-2018 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{extends file="helpers/form/form.tpl"}

{block name="field"}
  {if $input.type == 'custom_categories'}
    {if $input.categories}
      <div class="col-lg-9">
        <div class="panel">
          {if $input.categories}
            <ul id="categories-tree" class="cattree tree">
              {foreach from=$input.categories item='category'}
                {include file='./_tree/tree-branch.tpl' category=$category}
              {/foreach}
            </ul>
          {/if}
        </div>
      </div>
    {else}
      <div class="col-lg-5">
        <div class="alert alert-warning">
          {l s='There are no posts to select' mod='jxfeaturedposts'}
        </div>
      </div>
    {/if}
    <input type="hidden" name="id_shop" value="{$id_shop}" />
  {/if}
  {$smarty.block.parent}
{/block}