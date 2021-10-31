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

{extends file=$layout}

{block name='head_seo_description'}{$page.meta.description}{/block}
{block name='head_seo_keywords'}{$page.meta.keywords}{/block}

{block name='content'}
  <section id="main">
    <div id="blog-category-{$category.id_jxblog_category}" class="blog-category">
      <div class="blog-category-info">
        <h1 class="products-section-title text-center">{$category.name} <span class="badge badge-primary">{$category.badge}</span></h1>
        {if $category.description}
          <div class="blog-category-description text-center">
            {$category.description nofilter}
          </div>
        {/if}
      </div>
    </div>

    <hr class="my-5">

    {if $posts}
      <section class="blog-posts row">
        {foreach from=$posts item='post' name="post"}
          {block name='blog_post_miniature'}
            <article class="bp-miniature col-12 col-sm-6 col-lg-4 mb-4 mb-md-6">
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
                    <div class="author">{$post.author}</div>
                  </div>
                  <h1 class="bp-name mb-0">
                    <a href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
                      {$post.name}
                    </a>
                  </h1>
                </div>
                {if $post.short_description}
                  <div class="bp-short-description mt-3 d-none">
                    {$post.short_description nofilter}
                  </div>
                {/if}
                <div class="text-center mt-3">
                  <a class="btn btn-primary btn-lg" href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
                    {l s='Read more' d='Shop.Theme.Actions'}
                  </a>
                </div>
              </div>
            </article>
          {/block}
        {/foreach}
      </section>
      {if $pagination}
        {include file="module:jxblog/views/templates/front/_partials/pagination.tpl"}
      {/if}
    {else}
      <p class="alert alert-info">{l s='There are no posts in the category' mod='jxblog'}</p>
    {/if}
  </section>
{/block}
