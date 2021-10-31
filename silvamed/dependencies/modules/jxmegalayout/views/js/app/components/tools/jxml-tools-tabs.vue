<template id="jxml-tools-tabs">
  <div id="tools-tabs">
    <ul class="nav nav-pills col-sm-2 nav-stacked">
      <jxml-tools-tabs-list
              v-for="(tab, key, index) in tabs"
              :tab="tab.type"
              :name = "tab.name"
              :key="key"
              :class="{ active: tabActive == tab.type }"
              @switch-active-tools-tab="switchActiveTab(tab.type)">
      </jxml-tools-tabs-list>
    </ul>
    <div class="tab-content col-sm-10">
      <jxml-tools-tabs-content
              v-for="(tab, key, index) in tabs"
              :tab="tab.type"
              :key="key"
              :class="{ active: tabActive == tab.type }"
              :rawData = "content"
              v-if="tabActive == tab.type">
      </jxml-tools-tabs-content>
    </div>
  </div>
</template>
<script>
  var jxmlToolsTabsList = require('./jxml-tools-tabs-list.vue')
  var jxmlToolsTabsContent = require('./jxml-tools-tabs-content.vue')

  module.exports = {
    data: function() {
      return {
        tabs: jxmlToolsTabs,
        tabActive: jxmlToolsTabs[0]['type'],
        content: ''
      }
    },
    methods: {
      loadToolsTab: function() {
        var options = {
          action: 'loadTool',
          tool_name: this.tabActive
        };

        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          if (rawData = response.body.rawData) {
            this.content = rawData;
          } else {
            this.content = response.body.content;
          }
          this.$store.commit('setReadyStatus');
        }, function(error) {

        })
      },
      switchActiveTab: function(identifier) {
        this.$store.commit('setLoadingStatus');
        this.tabActive = identifier;
        this.loadToolsTab();
      }
    },
    mounted: function() {
      this.tabActive = this.tabs[0]['type'];
    },
    created: function() {
      this.loadToolsTab();
    },
    template: '#jxml-tools-tabs',
    components: {
      'jxml-tools-tabs-list': jxmlToolsTabsList,
      'jxml-tools-tabs-content': jxmlToolsTabsContent
    }
  }
</script>