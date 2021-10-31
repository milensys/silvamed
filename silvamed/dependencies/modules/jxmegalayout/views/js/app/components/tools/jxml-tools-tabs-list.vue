<template>
  <li><a @click.prevent="$emit('switch-active-tools-tab', tab)" href="#">{{ name }}</a></li>
</template>

<script>
  module.exports = {
    props: ['tab', 'name']
  }
</script>