{*
* 2017-2019 Zemez
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
*  @copyright 2017-2019 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{extends file="helpers/list/list_header.tpl"}


{block name=override_header}
	<ul class="breadcrumb cat_bar2">
		{assign var=i value=0}
		{foreach $categories_tree key=key item=category}
		<li>
			{if $i++ == 0}
				<i class="icon-home"></i>
				{assign var=params_url value=""}
			{elseif isset($category.id_jxblog_category)}
				{assign var=params_url value="&id_jxblog_category={$category.id_jxblog_category|intval}&viewcategory"}
			{/if}
			{if isset($category.id_jxblog_category) && $category.id_jxblog_category == $categories_tree_current_id}
				{$category.name|escape:'html':'UTF-8'}
        <a class="edit" href="{$category.edit_link}" title="{l s='Edit' d='Admin.Global'}">
          &nbsp;<i class="icon-pencil"></i> {l s='Edit' d='Admin.Global'}
        </a>
			{else}
				<a href="{$current|escape:'html':'UTF-8'}{$params_url|escape:'html':'UTF-8'}&amp;token={$token|escape:'html':'UTF-8'}">{$category.name|escape:'html':'UTF-8'}</a>
			{/if}
		</li>
		{/foreach}
	</ul>
{/block}
