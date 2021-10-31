<template>
  <div class="import-preview">
    <div v-if="data.errors">{{ data.errors }}</div>
    <div v-else-if="data.compatibility">{{ data.compatibility }}</div>
    <div class="layout-preview-box" v-else>
      {{ trans('layout_name') }}
      <span :class="{ layout_name_check: !data.check_name }" class="layout_name">{{ data.layout_name }}</span><br>
      <div v-if="!data.check_name">{{ trans('add_new_preset_name') }}
        <input v-model="new_name" type="text" value="" id="new_name_layout" class="form-control" name="new_name_layout" autocomplete="off"/>
      </div>
      {{ trans('hook') }}
      <span class="hook_name">{{ data.hook_name }}</span><br>
      <div v-if="data.pages" class="jxmegalayout-admin container">
        {{ trans('assigned_pages') }}
        {{ data.pages }}
      </div>
      {{ trans('preview') }}
      <div v-html="data.layout_preview" class="jxmegalayout-admin container">
        {{ $layout_preview }}
      </div>
    </div>
    <button @click.prevent="$parent.getImportInfo" class="btn btn-default center-block" v-if="data.check_name || (new_name && new_name != data.layout_name)" id="importLayoutArchiveApp">{{ trans('import') }}</button>
  </div>
</template>
<script>
  module.exports = {
    props   : ['data'],
    data: function() {
      return {
        new_name: null
      }
    }
  }
</script>