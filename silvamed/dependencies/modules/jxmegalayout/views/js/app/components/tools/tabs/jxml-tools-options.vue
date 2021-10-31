<template>
  <div class="jxmegalayout-lsettins">
    <div class="form-wrapper">
      <div class="form-group">
        <label class="control-label pull-left">{{ trans('optimization_label') }}</label>
        <div class="jxlist-layout-btns" data-layout-id="4">
          <a class="layout-btn" id="optionShowMessages" href="#" data-layout-id="4">
            <i class="process-icon-toggle-on" @click.prevent="switchShowMessages" v-if="showMessages"></i>
            <i class="process-icon-toggle-off" @click.prevent="switchShowMessages" v-if="!showMessages"></i>
          </a>
        </div>
        <p class="desc">
          <small>{{ trans('optimization_notification') }}</small>
        </p>
      </div>
      <div class="form-group">
        <label class="control-label pull-left">{{ trans('reset_to_default') }}</label>
        <a href="#" @click.prevent="resetToDefault" class="btn btn-default btn-sm reset-layouts">{{ trans('reset') }}</a>
        <p class="desc">
          <small>{{ trans('remove_presets_notification') }}</small>
        </p>
      </div>
    </div>
  </div>
</template>
<script>
  module.exports = {
    data: function() {
      return {
        showMessages: JXMEGALAYOUT_SHOW_MESSAGES
      }
    },
    methods : {
      switchShowMessages: function() {
        this.$store.commit('setLoadingStatus');
        var options = {
          action: 'showMessages'
        };
        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          this.showMessages = response.body.status;
          this.$store.commit('setReadyStatus');
          showSuccessMessage(response.body.response_msg);
        }, function(error) {
          this.$store.commit('setErrorStatus');
        })
      },
      resetToDefault: function() {
        this.$store.commit('setLoadingStatus');
        var options = {
          action: 'resetToDefault'
        };
        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          if (response.body.status) {
            this.$store.commit('setReadyStatus');
            showSuccessMessage(response.body.message);
          } else {
            showErrorMessage(response.body.message);
          }
        }, function(error) {
          this.$store.commit('setErrorStatus');
        })
      }
    }
  }
</script>