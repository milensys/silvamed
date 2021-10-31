{**
* 2017-2019 Zemez
*
* JX Mega Layout
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
*  @author    Zemez (Alexander Grosul & Alexander Pervakov)
*  @copyright 2017-2019 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
<script>
  // override default icon path because it isn't there any more
  $.fn.mColorPicker.defaults.imageFolder = baseDir + 'img/admin/';
</script>

<script type="text/javascript">
  if (typeof(address_token) == 'undefined' ) {
    address_token = '{getAdminToken tab='AdminAddresses'}';
  }
</script>

{addJsDefL name='jxml_row_classese_text'}{l s='Enter row classes' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_sp_class_text'}{l s='Specific class' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_sp_css_text'}{l s='Existed extra styles' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_confirm_text'}{l s='Confirm' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_class_validate_error'}{l s='One of specific classes is invalid' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_id_validate_error'}{l s='ID must be an integer' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_cols_validate_error'}{l s='At least one column size must be checked' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_loading_text'}{l s='Loading...' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_layout_validate_error_text'}{l s='Layout name is invalid. Only latin letters, arabic numbers and "-"(not first symbol) can be used.' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_wrapper_heading'}{l s='Wrapper' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_row_heading'}{l s='Row' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_col_heading'}{l s='Column' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_module_heading'}{l s='Module' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_module_heading'}{l s='Extra content' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_multiselect_all_text'}{l s='All pages' mod='jxmegalayout'}{/addJsDefL}
{addJsDefL name='jxml_multiselect_search_text'}{l s='Search' mod='jxmegalayout'}{/addJsDefL}

{assign var='optimization' value=false}
{if Configuration::get(JXMEGALAYOUT_SHOW_MESSAGES) != '1' || Configuration::get(JXMEGALAYOUT_OPTIMIZE) == '1'}
  {assign var='optimization' value=true}
{/if}
{addJsDef name='needOptimization' value=$optimization}
{literal}
  <div id="jxmegalayout-vue-app">
    <p class="alertMessage alert alert-warning" v-if="jxmegalayoutNeedOptimization">
      {/literal}
      {l s='Option `optimization` activated. After you complete all actions with presets, click optimize button.' mod='jxmegalayout'}
      <a @click.prevent="optimizeFiles" class="btn btn-success btn-sm pull-right" href="#">{l s='Optimize' mod='jxmegalayout'}</a>
      {literal}
    </p>
    <div class="app-loader" v-if="status == 'loading'"><i class="icon-refresh icon-spin icon-fw"></i></div>
    <ul class="nav jxmegalayout-nav-vue nav-tabs panel">
      <li
              v-for="(item, key, index) in jxmegalayoutTabs"
              v-if="jxmegalayoutTabsSectionType == item.section_name || item.type != 'layout'"
              v-bind:class="[{active: jxmegalayoutTabsActive == key}, {jxml_tools_tab: item.type == 'settings'}]"
              v-bind:key="key">
        <a v-if="item.type != 'sections'" :data-tab-name="item.hook_name" :id="item.id" @click.prevent="jxmegalayoutSetActiveTab(key)" class="layouts-tab" href="#">{{ item.tab_name }}</a>
        <div v-else id="jxml-sections-dropdown">
          <div class="dropdown jxlist-group-container" :id="item.id">
            <button class="btn btn-default dropdown-toggle" type="button" id="sectionsDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"></button>
            <ul class="dropdown-menu jxlist-group" aria-labelledby="dropdown">
              <jxml-sections-dropdown
                      v-for="(item, key, index) in item.sections"
                      :item="item"
                      :name="key"
                      :class="{active: jxmegalayoutTabsActive == key || !index}"
                      v-on:set-layout-type="onJxmegalayoutSetActiveSection"
                      :key="key">
              </jxml-sections-dropdown>
            </ul>
          </div>
        </div>
      </li>
    </ul>
    <div class="jxmegalayout-tab-content">
      <div
              class="tab-pane"
              v-for="(item, key, index) in jxmegalayoutTabs"
              v-if="key == jxmegalayoutTabsActive"
              v-bind:key="key"
              v-bind:item="item"
              v-bind:type="key"
              v-bind:class="{active: jxmegalayoutTabsActive == key}"
      >
        <div class="layout-tab-content">
          <div class="jxpanel panel clearfix" v-if="jxmegalayoutTabsActive == 'Tools'">
            <jxml-tools-tabs></jxml-tools-tabs>
          </div>
          <div class="jxpanel clearfix" v-else>
            <jxml-section-content :layout="key"></jxml-section-content>
          </div>
        </div>
      </div>
    </div>
  </div>
{/literal}
<script src="{$app_js_dir}"></script>
