<li class="tree-folder">
  -
  <span class="tree-folder-name">
    <i class="icon-folder-open"></i>
    <label class="tree-toggler">-{$category.name}</label>
  </span>
  {if isset($category.children) && $category.children}
    <ul class="tree">
      {foreach from=$category.children item='category'}
        {include file='./tree-branch.tpl' category=$category}
      {/foreach}
    </ul>
  {/if}
  {if isset($category.posts) && $category.posts}
    {foreach from=$category.posts item='post'}
      <li class="tree-item">
        <span class="tree-item-name">
          {if !$fields_value.id_post}
            {assign var="selected_post" value=false}
          {else}
            {assign var="selected_post" value=$fields_value.id_post}
          {/if}
          {if !$selected_post}
            {assign var="selected_post" value=$post.id_jxblog_post}
          {/if}
          <label class="tree-toggler"><input name="id_post" value="{$post.id_jxblog_post}" {if $post.id_jxblog_post == $selected_post}checked{/if} type="radio">{$post.name}</label>
        </span>
      </li>
    {/foreach}
  {else}
    <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- <i><small>{l s='no related posts' mod='jxfeaturedposts'}</small></i></li>
  {/if}
</li>
