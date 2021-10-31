{*
* 2017-2020 Zemez
*
* JX Search
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
* @copyright  2017-2020 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div class="js-dropdown">
  <div class="js-dropdown-toggle linearicons-magnifier search-toggle"></div>
  <div class="dropdown-menu search-wrapper d-flex align-items-center justify-content-between">
      <button type="button" class="dropdown-close close linearicons-cross2 position-static order-2"></button>
      <div id="jxsearchblock" class="order-1">
        <div class="tab-content{if isset($search_blog_categories) && $search_blog_categories} pl-3{/if}">
          <div id="jxsearchbox" class="tab-pane show {if !isset($blog_search_query) || !$blog_search_query} active{/if}" role="tabpanel" aria-labelledby="catalog-tab">
            <form method="get" action="{Jxsearch::getJXSearchLink('jxsearch')|escape:'htmlall':'UTF-8'}" class="jxsearchform">
              {if !Configuration::get('PS_REWRITING_SETTINGS')}
                <input type="hidden" name="fc" value="module"/>
                <input type="hidden" name="controller" value="jxsearch"/>
                <input type="hidden" name="module" value="jxsearch"/>
              {/if}
              <div class="d-flex align-items-center mr-md-1 mr-xl-3">
                <select name="search_categories" class="custom-select">
                  {foreach from=$search_categories item=category}
                    <option {if isset($active_category) && $active_category == $category.id}selected="selected"{/if} value="{$category.id|escape:'htmlall':'UTF-8'}">{if $category.id == 2}{l s='All Categories' mod='jxsearch'}{else}{$category.name|escape:'htmlall':'UTF-8'}{/if}</option>
                  {/foreach}
                </select>
                <span class="divider-line"></span>
                <input class="jx_search_query form-control" type="text" id="jx_search_query" name="search_query" placeholder="{l s='Search...' mod='jxsearch'}" value="{if isset($search_query)}{$search_query|escape:'htmlall':'UTF-8'|stripslashes}{/if}"/>
                <button type="submit" name="jx_submit_search" class="search-icon">
                  <i class="linearicons-magnifier"></i>
                  <span class="d-none">{l s='Search' mod='jxsearch'}</span>
                </button>
              </div>
            </form>
          </div>
          {if isset($search_blog_categories) && $search_blog_categories}
            <div id="jxsearchbox-blog" class="tab-pane {if isset($blog_search_query) && $blog_search_query} active{/if}" role="tabpanel" aria-labelledby="blog-tab">
              <form method="get" action="{Jxsearch::getJXBlogSearchLink()|escape:'htmlall':'UTF-8'}" class="jxsearchform">
                <div class="d-flex align-items-center mr-md-1 mr-xl-3">
                  <select  name="search_blog_categories" class="custom-select">
                    <option value="0">{l s='Blog Categories' mod='jxsearch'}</option>
                    {foreach from=$search_blog_categories item='blog_category'}
                      <option {if isset($active_blog_category) && $active_blog_category == $blog_category.id}selected="selected"{/if} value="{$blog_category.id}">{$blog_category.name}</option>
                    {/foreach}
                  </select>
                  <span class="divider-line"></span>
                  <input class="jx_blog_search_query form-control" type="text" id="jx_blog_search_query" name="blog_search_query" placeholder="{l s='Search through the blog...' mod='jxsearch'}" value="{if isset($blog_search_query)}{$blog_search_query}{/if}"/>
                  <button type="submit" name="jx_submit_search" class="search-icon">
                    <i class="linearicons-magnifier"></i>
                    <span class="d-none">{l s='Search' mod='jxsearch'}</span>
                  </button>
                </div>
              </form>
            </div>
          {/if}
        </div>
        <ul class="{if isset($search_blog_categories) && $search_blog_categories}nav{else}d-none{/if}" id="jxsearch-tab" role="tablist">
          <li class="nav-item">
            <a class="{if !isset($blog_search_query) || !$blog_search_query} active{/if}" id="catalog-tab" data-toggle="tab" href="#jxsearchbox" role="tab" aria-controls="jxsearchbox" aria-selected="true"><i class="linearicons-tab" aria-hidden="true"></i></a>
          </li>
          {if isset($search_blog_categories) && $search_blog_categories}
            <li class="nav-item">
              <a class="{if isset($blog_search_query) && $blog_search_query} active{/if}" id="blog-tab" data-toggle="tab" href="#jxsearchbox-blog" role="tab" aria-controls="jxsearchbox-blog" aria-selected="false"><i class="linearicons-tab" aria-hidden="true"></i></a>
            </li>
          {/if}
        </ul>
      </div>
{*    </div>*}
  </div>
</div>