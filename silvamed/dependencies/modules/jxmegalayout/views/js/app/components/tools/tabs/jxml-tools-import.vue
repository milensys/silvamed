<template>
  <form id="import_layout_form" class="defaultForm form-horizontal" method="post" enctype="multipart/form-data" novalidate="">
    <div class="form-wrapper">
      <div class="form-group">
        <label class="control-label col-lg-3">
          {{ trans('zip_file') }}
        </label>
        <div class="col-lg-5">
          <div class="form-group">
            <div class="col-sm-12">
              <input id="layoutArchiveApp" type="file" @change.prevent="getPreviewInfo($event)" name="themearchive" class="hide">
              <div class="dummyfile input-group">
                <span class="input-group-addon"><i class="icon-file"></i></span>
                <input @click.prevent="getImportInfo" id="layoutArchiveNameApp" type="text" name="filename" readonly="">
                <span class="input-group-btn">
                  <button id="selectLayoutArchiveApp" type="button" name="submitAddAttachments" class="btn btn-default">{{ trans('add_file') }}</button>
                </span>
              </div>
            </div>
          </div>
          <p class="help-block text-center">
            {{ trans('browse_file') }}<br>
            {{ trans('max_file_size') }} {{ maxfilesize }}<br>
            {{ trans('server_settings_notification') }}
          </p>
        </div>
      </div>
      <div class="form-group layout-preview-wrapper" :class="{ hidden: !preview }" v-if="preview">
        <jxml-tools-import-preview :data="previewContent"></jxml-tools-import-preview>
      </div>
    </div>
  </form>
</template>
<script>
  var importPreview = require('./_partials/jxml-tools-import-preview.vue')

  module.exports = {
    props: ['data'],
    data: function() {
      return {
        preview: false,
        previewContent: '',
        errors: null
      }
    },
    computed: {
      maxfilesize() {
        return this.$store.getters.maxfilesize;
      }
    },
    mounted: function() {
      $('#selectLayoutArchiveApp').live('click', function(e) {
        $('#layoutArchiveApp').trigger('click');
      });
      $('#layoutArchiveNameApp').live('click', function(e) {
        $('#layoutArchiveApp').trigger('click');
      });
      $('#layoutArchiveNameApp').live('dragenter', function(e) {
        e.preventDefault();
      });
      $('#layoutArchiveNameApp').live('dragover', function(e) {
        e.preventDefault();
      });
      $('#layoutArchiveNameApp').live('drop', function(e) {
        e.preventDefault();
        var files                       = e.originalEvent.dataTransfer.files;
        $('#layoutArchiveApp')[0].files[0] = files;
        $(this).val(files[0].name);
      });
    },
    methods : {
      getPreviewInfo: function(event) {
        this.$store.commit('setLoadingStatus');
        var el = event.target;
        if (el.files !== undefined) {
          var files = el.files;
          var name  = '';
          $.each(files, function(index, value) {
            name += value.name + ', ';
          });
          $('#layoutArchiveNameApp').val(name.slice(0, -2));
        } else {
          var name = el.val().split(/[\\/]/);
          $('#layoutArchiveNameApp').val(name[name.length - 1]);
        }
        var file      = $('#layoutArchiveApp')[0].files[0];
        var formData = new FormData();
        formData.append('file', file);
        this.sendFile(formData, file.name, file.size, 'preview');
      },
      getImportInfo: function() {
        this.$store.commit('setLoadingStatus');
        var file      = $('#layoutArchiveApp')[0].files[0];
        var formData = new FormData();
        formData.append('file', file);
        var nameLayout = $('input[name="new_name_layout"]').val();
        if (typeof(nameLayout) != 'undefined' && nameLayout.length) {
          if (this.$root.validateLayoutName(nameLayout)) {
            this.sendFile(formData, file.name, file.size, 'import');
          } else {
            $('.layout-preview-box').find('p.alert').remove();
            $('.layout-preview-box').prepend('<p class="alert alert-warning text-left">' + jxml_layout_validate_error_text + '</p>');
            this.$store.commit('setReadyStatus');
          }
        } else {
          this.sendFile(formData, file.name, file.size, 'import');
        }
      },
      sendFile: function(formData, name, size, action) {
        var xhr = new XMLHttpRequest();
        if (action == 'preview') {
          xhr.open('POST', this.$store.getters.endpoint + '&action=getImportInfo', false);
        } else {
          var nameLayout = $('input[name="new_name_layout"]').val();
          if (typeof(nameLayout) != 'undefined' && nameLayout.length) {
            xhr.open('POST', this.$store.getters.endpoint + '&action=importLayout&name_layout=' + nameLayout, false);
          } else {
            xhr.open('POST', this.$store.getters.endpoint + '&action=importLayout', false);
          }
        }
        xhr.setRequestHeader("Cache-Control", "no-cache");
        xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
        xhr.setRequestHeader('X-FILE-NAME', name);
        xhr.setRequestHeader('X-FILE-SIZE', size);
        xhr.send(formData);
        if (xhr.status == 200) {
          if (action == 'preview') {
            this.preview = true;
            this.previewContent = JSON.parse(xhr.responseText)['rawData'];
          } else {
            if (JSON.parse(xhr.responseText).type != 'popup') {
              if (JSON.parse(xhr.responseText)['status']) {
                showSuccessMessage(JSON.parse(xhr.responseText)['response_msg']);
                $('#layoutArchiveNameApp').attr('value', '');
                this.afterImport();
              }
              this.optimizeMessage();
              // refresh all preview to avoid caching during other archive processing
              this.preview = false;
              this.previewContent = '';
            } else {
              $('.layout-preview-box').find('p.alert').remove();
              $('.layout-preview-box').prepend('<p class="alert alert-danger text-left">' + JSON.parse(xhr.responseText).message + '</p>');
            }
          }
          this.$store.commit('setReadyStatus');
        }
      },
      afterImport: function() {
        var options = {
          action: 'afterImport'
        };

        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options)
      },
      optimizeMessage: function() {
        var options = {
          action: 'optimizeMessage'
        };
        var resource = this.$resource(this.$store.getters.endpoint);
        resource.get(options).then(function(response) {
          if (response.body.needOptimization) {
            this.$root.jxmegalayoutNeedOptimization = true
          }
        })
      }
    },
    components: {
      'jxml-tools-import-preview': importPreview
    }
  }
</script>