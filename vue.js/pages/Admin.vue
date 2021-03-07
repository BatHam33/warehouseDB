<template>
  <div>
    <b-navbar>
      <b-navbar-brand :to="{ path: '/' }">Warehouse </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
            <router-link to="admin/adminlist" tag="b-button" class="float-left"
      >ListofAdmins</router-link
    >
          <b-nav-item :to="{ path: '/logout' }">Logout</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
    <br />
    <hr />
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "Admin",
};
</script>