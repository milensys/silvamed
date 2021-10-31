<template>
  <div class="jxpanel">
    <div v-html="data"></div>
  </div>
</template>
<script>
  module.exports = {
    props: ['data'],
    data: function() {
      return {
        status: null,
        content: null
      }
    }
  }
</script>