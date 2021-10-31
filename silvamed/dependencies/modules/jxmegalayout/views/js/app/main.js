/**
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
*/

var Vue = require('vue')
var VueResource = require('vue-resource')
var Vuex = require('vuex')
var jxmlSectionDropdown = require('./components/main/jxml-sections-dropdown.vue')
var jxmlSectionTools = require('./components/tools/jxml-tools-tabs.vue')
var jxmlSectionContent = require('./components/main/jxml-sections-content.vue')
var Translation = require('./mixins/translate')

Vue.use(VueResource)
Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    max_file_size: max_file_size,
    endpoint: jxml_theme_url+'&ajax',
    status: 'loading',
    jxmegalayoutTabs: jxmegalayoutTabs,
    translations: app_translations
  },
  getters: {
    maxfilesize(state) {
      return state.max_file_size
    },
    status(state) {
      return state.status
    },
    endpoint(state) {
      return state.endpoint
    },
    getJxmegalayoutTabs(state) {
      return state.jxmegalayoutTabs
    }
  },
  mutations: {
    setLoadingStatus(state) {
      state.status = 'loading';
    },
    setReadyStatus(state) {
      state.status = 'ready';
    },
    setErrorStatus(state) {
      state.status = 'error';
    }
  }
});

Vue.mixin(Translation)

app = new Vue({
  el: '#jxmegalayout-vue-app',
  store,
  data: {
    jxmegalayoutNeedOptimization: !needOptimization,
    jxmegalayoutAction: 'loadLayoutTab',
    jxmegalayoutTabsActive: 'displayHeader',
    jxmegalayoutToolsTabsActive: 'Export',
    jxmegalayoutTabsSectionType: 'MainLayouts'
  },
  methods: {
    jxmegalayoutSetActiveTab: function(identificator) {
      this.jxmegalayoutTabsActive = identificator;
      //this.getTabContent();
    },
    onJxmegalayoutSetActiveSection: function(identificator) {
      this.jxmegalayoutTabsSectionType = identificator;
      if (this.jxmegalayoutTabsSectionType == 'MainLayouts') {
        this.jxmegalayoutTabsActive = 'displayHeader'
      } else {
        this.jxmegalayoutTabsActive = 'displayFooterProduct'
      }
      // invoke tab content updating after layouts type switching
      //this.getTabContent();
    },
    getTabContent: function() {
      if (this.jxmegalayoutTabsActive == 'Tools') {
        return;
      }
      this.$store.commit('setLoadingStatus');
      var options = {
          action   : this.jxmegalayoutAction,
          tab_name : this.jxmegalayoutTabsActive
      };

      var resource = this.$resource(this.$store.getters.endpoint);
      resource.get(options).then(function(response) {
        this.$store.commit('setReadyStatus');
      }, function(error) {

      })
    },
    showPopup: function(message) {
      $.fancybox.open({
        type       : 'inline',
        autoScale  : true,
        minHeight  : 30,
        minWidth   : 320,
        maxWidth   : 815,
        padding    : 0,
        content    : '<div class="bootstrap jxml-popup">' + message + '</div>',
        helpers    : {
          overlay : {
            locked : false
          }
        },
        afterClose : function() {
          $('.button-container a:not(.edit-styles)').removeClass('active');
        }
      });
    },
    validateLayoutName : function(name) {
      if ($.trim(name) == '') {
        return false;
      }
      for (i = 0; i < name.length; i++) {
        if (i == 0 && name[i] == '-') {
          return false;
        }
        if (/^[a-zA-Z0-9-]*$/.test(name[i]) == false) {
          return false;
        }
      }
      return true;
    },
    optimizeFiles: function() {
      var options = {
        action   : 'updateOptionOptimize'
      };

      var resource = this.$resource(this.$store.getters.endpoint);
      resource.get(options).then(function(response) {
        this.$store.commit('setReadyStatus');
        this.jxmegalayoutNeedOptimization = false;
        showSuccessMessage(response.body.response_msg);
      }, function(error) {})
    }
  },
  created: function() {
    this.$store.commit('setReadyStatus');
    //this.getTabContent();
  },
  computed: {
    status() {
      return this.$store.getters.status;
    },
    jxmegalayoutTabs() {
      return this.$store.getters.getJxmegalayoutTabs;
    }
  },
  components: {
    'jxml-sections-dropdown': jxmlSectionDropdown,
    'jxml-tools-tabs': jxmlSectionTools,
    'jxml-section-content': jxmlSectionContent
  }
});