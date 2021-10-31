{*
* 2017-2019 Zemez
*
* JX Product List Gallery
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
* @author   Zemez
* @copyright 2017-2019 Zemez
* @license  http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if $smarty_settings.st_display && !($smarty_settings.st_type == 'slideshow' && !$smarty_settings.st_slider_pager && !$smarty_settings.st_slider_controls)}
  {if $smarty_settings.st_type == 'rollover'}
    <div class="thumbnails-rollover {$smarty_settings.st_rollover_animation}">
      {foreach from=$product.images item=image name=image}
        {if $image.cover}
          <img
            class="img-fluid"
            src = "{$image.bySize.home_default.url}"
            alt = "{if !empty($image.legend)}{$image.legend}{else}{$product.name|truncate:30:'...'}{/if}"
            data-full-size-image-url = "{$image.large.url}"
          >
          {assign var="isCover" value=true}
        {/if}
      {/foreach}
      {foreach from=$product.images item=image name=image}
        {if $image.cover}{assign var="isCoverDuplicate" value=true}{continue}{/if}
        <img
          class="img-fluid"
          src = "{$image.bySize.home_default.url}"
          alt = "{if !empty($image.legend)}{$image.legend}{else}{$product.name|truncate:30:'...'}{/if}"
          data-full-size-image-url = "{$image.large.url}"
        >
        {if (isset($isCover) && $isCover && !isset($isCoverDuplicate) && $smarty.foreach.image.first) || $smarty.foreach.image.iteration == 2}{break}{/if}
      {/foreach}
    </div>
  {else}
    <div class="thumbnails-carousel slide {$smarty_settings.st_type}">
      <div class="carousel-inner">
        {foreach from=$product.images item=image name=image}
          <div class="carousel-item{if $image.cover} active{/if}">
            <img
              class="img-fluid"
              src = "{$image.bySize.home_default.url}"
              alt = "{if !empty($image.legend)}{$image.legend}{else}{$product.name|truncate:30:'...'}{/if}"
              data-full-size-image-url = "{$image.large.url}"
            >
          </div>
          {if $smarty.foreach.image.iteration == $smarty_settings.st_nb_items}
            {break}
          {/if}
          {if $smarty_settings.st_type == 'gallery' && !$smarty_settings.st_gall_carousel && $smarty.foreach.image.iteration == $smarty_settings.st_visible}
            {break}
          {/if}
        {/foreach}
      </div>
      {if ($smarty_settings.st_type == 'gallery') || ($smarty_settings.st_type == 'slideshow' && $smarty_settings.st_slider_pager)}
        <ol class="carousel-indicators">
          {foreach from=$product.images item=image name=image}
            <li data-slide-to="{$smarty.foreach.image.iteration - 1}"{if $image.cover} class="active"{/if}{if $smarty_settings.st_type == 'gallery'} style="width: calc(100%/{$smarty_settings.st_visible})"{/if}>
              {if $smarty_settings.st_type == 'gallery'}
                <img
                  class="img-fluid"
                  src = "{$image.small.url}"
                  alt = "{if !empty($image.legend)}{$image.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                >
              {/if}
            </li>
            {if $smarty.foreach.image.iteration == $smarty_settings.st_nb_items}
              {break}
            {/if}
            {if $smarty_settings.st_type == 'gallery' && !$smarty_settings.st_gall_carousel && $smarty.foreach.image.iteration == $smarty_settings.st_visible}
              {break}
            {/if}
          {/foreach}
        </ol>
      {/if}
      {if ($smarty_settings.st_type == 'slideshow' && $smarty_settings.st_slider_controls)}
        <span class="left carousel-control">
          <i class="fa fa-chevron-left" aria-hidden="true"></i>
        </span>
        <span class="right carousel-control">
          <i class="fa fa-chevron-right" aria-hidden="true"></i>
        </span>
      {/if}
    </div>
  {/if}
{/if}