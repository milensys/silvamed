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

{if isset($is_slider) && $is_slider}{else}
<section class="blog-posts row">{/if}
  {foreach from=$posts item='post'}
    {block name='blog_post_miniature'}
      <article class="bp-miniature {if isset($is_slider) && $is_slider}bp-slide{else}col-12 col-sm-6 mb-3{/if}">
        <div class="bp-miniature-container">
          <div class="bp-thumbnail mb-3">
            <a href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
              <img class="img-fluid" src="{JXBlogImageManager::getImage('post_thumb', $post.id_jxblog_post, 'post_listing')}" alt="{$post.name}">
            </a>
          </div>
          <div class="bp-info text-center">
            <div class="d-flex flex-wrap align-items-center justify-content-center post-meta mb-2">
              <div class="date-post">{$post.date_start|date_format:'%d %B, %Y'}</div>
              {if $post.views}
                <div class="views-post">{l s='Views' mod='jxblog'} {$post.views}</div>
              {/if}
            </div>
            <h1 class="bp-name mb-0 d-none d-xl-block{if $page.page_name != 'index'} h4{/if}">
              <a href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
                {$post.name}
              </a>
            </h1>
            <h3 class="bp-name mb-0 d-xl-none">
              <a href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
                {$post.name}
              </a>
            </h3>
            {if $post.short_description}
              <div class="bp-short-description mt-3 d-none">
                {$post.short_description nofilter}
              </div>
            {/if}
            <a class="btn btn-primary btn-lg d-none mt-3" href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
              {l s='Read more' d='Shop.Theme.Actions'}
            </a>
          </div>
        </div>
      </article>
    {/block}
  {/foreach}
  {if isset($is_slider) && $is_slider}{else}</section>{/if}
