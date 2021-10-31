{**
* 2017-2020 Zemez
*
* JX Compare Product
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
*  @author    Zemez
*  @copyright 2017-2020 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div class="compare-header"
     data-refresh-url="{$jxcompareproduct_url}"
     data-compare-max="{$jxcompareproduct_max}"
     data-empty-text="{l s='No products to compare' mod='jxcompareproduct'}"
     data-max-alert-message="{l s='Only' mod='jxcompareproduct'} {$jxcompareproduct_max} {l s="products can be compared" mod='jxcompareproduct'}">
  <a href="#" class="compare-products">
    <i class="linearicons-repeat" aria-hidden="true"></i>
    <span>{l s="Compare" mod="jxcompareproduct"}(</span><span class="compare-counter"></span><span>)</span>
  </a>
</div>
