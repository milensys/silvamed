<template>
  <li class="jxlist-group-item"><a @click.prevent="$emit('set-layout-type', name)" href="#">{{ item.lang }}</a></li>
</template>

<script>
  module.exports = {
    props: ['item', 'name'],
    mounted: function() {
      var btnDefaultText = $('.jxlist-group.dropdown-menu > li.active').text();
      $('.jxmegalayout-nav-vue #sectionsDropdown').text($.trim(btnDefaultText));
    }
  }
</script>