<template>
  <div id="app">
    <transition name="fade">
      <keep-alive>
        <router-view/>
      </keep-alive>
    </transition>
    <img src="./assets/logo.png">
    <img src="./assets/logo.png" lazy="loading">
    <img src="./assets/logo.png" lazy="loaded">
    <img src="./assets/logo.png" lazy="error">
    <!--<div v-wechat-title="$route.meta.title"></div>-->
    <!--or-->
    <router-view v-wechat-title="$route.meta.title"></router-view>
  </div>
</template>

<script>

export default {
  name: 'app'
}
</script>

<style scoped>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

.fade-enter-active, .fade-leave-active {
  transition: opacity .5s
}
.fade-enter, .fade-leave-active {
  opacity: 0
}
</style>
