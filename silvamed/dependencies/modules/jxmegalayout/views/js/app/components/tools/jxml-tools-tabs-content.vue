<template>
  <div class="tab-pane" :class="tab">
    <component :is="adjustTabName(tab)" :data="rawData"></component>
  </div>
</template>

<script>
  var Export = require('./tabs/jxml-tools-export.vue')
  var Import = require('./tabs/jxml-tools-import.vue')
  var Options = require('./tabs/jxml-tools-options.vue')
  var ExtraContent = require('./tabs/jxml-tools-extra-content.vue')
  var ThemeBuilder = require('./tabs/jxml-tools-theme-builder.vue')

  module.exports = {
    props: ['tab', 'rawData'],
    methods: {
      adjustTabName: function(tabName) {
        return tabName.replace(' ', '_');
      }
    },
    components: {
      'export': Export,
      'import': Import,
      'options': Options,
      'extra_content': ExtraContent,
      'theme_builder': ThemeBuilder
    }
  }
</script>