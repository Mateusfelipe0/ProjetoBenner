import Page from "./Page";
import Vue from "vue";
import VueResource from "vue-resource";

Vue.use(VueResource);
Vue.http.options.root = Page.getApplicationPath();

export default Vue.http;