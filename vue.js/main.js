import Vue from "vue";
import VueRouter from "vue-router";
import { BootstrapVue, IconsPlugin } from "bootstrap-vue";

import App from "./App.vue";
import Home from "./pages/Home";
import Login from "./pages/Login";
import Logout from "./pages/Logout";
import Register from "./pages/Register";
import AdminUserList from "./components/AdminUserList";
import EmployeeList from "./components/EmployeeList";
import NewAdmin from "./pages/NewAdmin";
import NewUser from "./pages/newUser";
Vue.config.productionTip = false;

import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
import { getJwtToken } from "./auth";

Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(VueRouter);

const checkAuth = function(to, _, next) {
  const token = getJwtToken();
  if (token === undefined || token === "undefined" || token === null) {
    // redirect to login because we don't have token yet
    next({
      path: "/login",
      params: { nextUrl: to.fullPath },
    });
  } else {
    next();
  }
};

const router = new VueRouter({
  routes: [
    { path: "/", component: Home },
    { path: "/login", component: Login },
    { path: "/logout", component: Logout },
    { path: "/register", component: Register },
    {
      path: "/admin",
      component: EmployeeList,
      beforeEnter: checkAuth
    },
        
    { path: "/admin/adminlist", component: AdminUserList, beforeEnter: checkAuth },
    { path: "/admin/employeelist", component: EmployeeList, beforeEnter: checkAuth },
    { path: "/admin/newadmin", component: NewAdmin, beforeEnter: checkAuth},
    { path: "/newcustomer", component: NewUser},
    { path: "/admin/newemployee", component: NewEmployee},
    
  ],
});

new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");