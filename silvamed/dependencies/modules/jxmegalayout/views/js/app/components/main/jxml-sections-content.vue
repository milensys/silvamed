<template>
  <div class="jxpanel-content">
    <div class="panel jxmegalayout-lsettins clearfix">
      <div class="button-container">
        <a class="btn btn-success add_layout" :data-hook-name="tabContent.hook_name" @click.prevent href="#">{{ trans('add_preset') }}</a>
      </div>
      <div class="jxlist-group-container dropdown">
        <button v-if="tabContent.layouts_list" class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">{{ activeLayoutName }}</button>
        <ul :data-list-id="tabContent.hook_name" class="jxlist-group jxml-layouts-list dropdown-menu" aria-labelledby="dropdownMenu">
          <li v-for="(item, key, index) in tabContent.layouts_list" :data-layout-id="item.id_layout" :class="{ active: item.status == '1' }" class="jxlist-group-item">
            <a href="#">
              <i class="icon-star" :class="{ visible: item.status == '1', 'hidden': item.status != '1' }"></i>
              <i class="icon-star-half-empty" :class="{ hidden: !assignedPages(item.id_layout), 'visible': assignedPages(item.id_layout) }"></i>
              {{ item.layout_name }}
            </a>
          </li>
        </ul>
      </div>
      <div class="jxlist-layout-buttons clearfix">
        <p v-if="tabContent.id_layout" :data-layout-id="tabContent.id_layout" class="jxlist-layout-btns pull-left">
          <a :data-layout-id="tabContent.id_layout" href="#" :class="{ hidden: tabContent.status || assignedPages(tabContent.id_layout) }" class="layout-btn use-layout">
            <i class="process-icon-toggle-off"></i>
            {{ trans('use_default') }}
          </a>
          <a :data-layout-id="tabContent.id_layout" href="#" :class="{hidden: !tabContent.status && !assignedPages(tabContent.id_layout)}" class="layout-btn disable-layout">
            <i class="process-icon-toggle-on"></i>
            {{ trans('use_default') }}
          </a>
        </p>
        <select v-if="tabContent.id_layout && tabContent.availableForAllPages" class="jxmegalayout-availible-pages" multiple="multiple" name="jxmegalayout-availible-pages">
          <option :selected="isPageSelected(tabContent.id_layout, key)" v-for="(item, key) in tabContent.pages_list" :value="key">{{ key }}</option>
        </select>
      </div>
    </div>
    <div class="layout-container">
      <div :data-layout-id="tabContent.id_layout" class="jxmegalayout-admin container">
        <div v-if="tabContent.layout" class="jxlayout-row">
          <span class="jxmlmegalayout-layout-name">{{ tabContent.layout_name }}</span>
          <a :data-layout-id="tabContent.id_layout" href="#" class="edit-layout"></a>
          <a :data-layout-id="tabContent.id_layout" href="#" class="remove-layout"></a>
        </div>
        <article v-if="tabContent.layout" v-start-with-html="tabContent.layout" class="inner">
          <p class="add-buttons">
            <span class="col-xs-12 col-sm-6 add-but">
              <a href="#" class="btn add-wrapper min-level">{{ trans('add_wrapper') }}</a>
            </span>
            <span class="col-xs-12 col-sm-6 add-but">
              <a href="#" class="btn add-row  min-level">{{ trans('add_row') }}</a>
            </span>
          </p>
        </article>
        <input v-if="tabContent.layout" type="hidden" name="jxml_id_layout" :value="tabContent.id_layout" />
        <div v-else>
          <p v-if="tabContent.layouts_list" class="alert alert-info">{{ trans('select_layout') }}</p>
          <p v-else class="alert alert-info">{{ trans('add_layout') }}</p>
        </div>
      </div>
    </div>
    <input type="hidden" data-name="bgimg" id="flmbgimg" value=""/>
    <input type="hidden" name="jxml_hook_name" :value="tabContent.hook_name"/>
  </div>
</template>

<script>
  module.exports = {
    props: ['layout'],
    data: function() {
      return {
        active: null,
        availableItemsList: null,
        tabContent: ''
      }
    },
    methods: {
      getTabContent: function() {
        this.$store.commit('setLoadingStatus');
        var options = {
          action   : 'loadLayoutTabContent',
          tab_name : this.layout
        };

        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          this.$store.commit('setReadyStatus');
          var content = response.body.content;
          this.tabContent = content[this.layout];
        }, function(error) {

        })
      },
      assignedPages(id_layout) {
        var result = [];
        $.each(this.tabContent.layouts_list, function(index, value) {
          if (value.id_layout == id_layout) {
            if (value.subpages) {
              $.each(value.subpages, function(i, v) {
                result.push(v.page_name)
              })
            }
          }
        })
        if (result.length) {
          return result
        }
        return false
      },
      isPageSelected: function(id_layout, page_name) {
        $.each(this.tabContent.layouts_list, function(index, value) {
          if (value.id_layout == id_layout && value.subpages) {
            $.each(value.subpages, function(i, v) {
              if (v.page_name == page_name) {
                return true;
              }
            });
          }
        });

        return false;
      }
    },
    created: function() {
      this.getTabContent();
    },
    updated: function() {
      jxml.sortInit();
      jxml.tooltipInit();
      jxml.multiselectInit();
    },
    computed: {
      activeLayoutName() {
        var name = '--';
        for (i = 0; i < this.tabContent.layouts_list.length; i++) {
          if (this.tabContent.layouts_list[i].status == '1') {
            name = this.tabContent.layouts_list[i].layout_name;
          }
        }
        return name;
      }
    },
    directives: {
      startWithHtml: {
        inserted(el, binding) {
          el.insertAdjacentHTML('afterbegin', binding.value);
        }
      }
    }
  }
</script>

<style>
  a.btn.app_add_layout {
    padding: 7px 20px;
  }
</style>