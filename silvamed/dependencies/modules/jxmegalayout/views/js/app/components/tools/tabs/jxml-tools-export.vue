<template>
  <div>
    <div class="block" v-for="(item, key) in data" :key="key">
      <div class="hook-title" :class="{ disabled: !item.layouts }">
        <h4>{{ trans('hook') }} "{{ item.hook_name }}"</h4>
      </div>
      <ul class="tree" v-if="item.layouts">
        <li class="item-name" v-for="(layout, layoutKey) in item.layouts" :key="layoutKey">
        <span class="tree-item-name">
          <i class="icon-image"></i>
          <label class="tree-toggler">{{ layout.layout_name }}</label>
          (
          <a href="#" @click.prevent="layoutPreview(layout.id_layout)">{{ trans('layout_preview') }}</a>
          |
          <a href="#" @click.prevent="layoutExport(layout.id_layout)">{{ trans('layout_export') }}</a>
          )
        </span>
        </li>
      </ul>
      <p class="alert alert-info" v-else>
        {{ trans('no_export') }}
      </p>
    </div>
  </div>
</template>
<script>
  module.exports = {
    props   : ['data'],
    methods : {
      layoutPreview: function(id_layout) {
        this.$store.commit('setLoadingStatus');
        var options = {
          action: 'layoutPreview',
          id_layout: id_layout
        };

        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          if (msg = response.body.msg) {
            this.$root.showPopup('<div class="jxmegalayout-admin container"><div class="preview-popup-content">'+msg+'</div></div>');
          }
          this.$store.commit('setReadyStatus');
        }, function(error) {
          this.$store.commit('setErrorStatus');
        })
      },
      layoutExport: function(id_layout) {
        this.$store.commit('setLoadingStatus');
        var options = {
          action: 'layoutExport',
          id_layout: id_layout
        };

        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          if (href = response.body.href) {
            location.href = href;
          }
          this.$store.commit('setReadyStatus');
        }, function(error) {
          this.$store.commit('setErrorStatus');
        })
      }
    }
  }
</script>