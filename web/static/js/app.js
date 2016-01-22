console.log("Hello from Webpack!??");

var Vue = require('vue');
var appOptions = require('./app.vue');
var app = new Vue(appOptions).$mount('#app');

