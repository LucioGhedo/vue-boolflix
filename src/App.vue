<template>
  <div id="app">
    <header>
      <HeaderCompo @search="searchFilm" />
    </header>
    <main>
      <MainCompo :text="userText" />
    </main>
  </div>
</template>

<script>
import HeaderCompo from './components/HeaderCompo.vue'
import MainCompo from './components/MainCompo.vue'

export default {
  name: 'App',
  components: {
    HeaderCompo,
    MainCompo
  },
  data() {
    return {
      userText: '',
    }
  },
  methods: {
    searchFilm(text) {
      this.userText = '';
      this.userText = text;
    }
  }
}
</script>

<style lang="scss">
@import './assets/common.scss';

</style>
