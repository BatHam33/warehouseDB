l<template>
  <div>
		<br><div style="text-align:center; font-weight:bold; font-size:250%;">Admin List</div><br>
    <div v-if="loading">Loading Admininistrators....</div>
	<div v-if="loading">Loading Admininistrators....</div>
    <router-link to="/logout" tag="b-button" class="float-right" style="margin-left:10px;">Log Out</router-link>
    
    <!--Change router link to add employee page-->

    <router-link to="/newcustomer" tag="b-button" class="float-right" style="margin-left:10px;">Add Customer</router-link>

    <router-link to="/product" tag="b-button" class="float-right">Products</router-link>


    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Admin ID</b-th>
          <b-th>Last Name</b-th>
          <b-th>First Name</b-th>
          <b-th>Title</b-th>
          <b-th>Actions</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="admin in admins" :key="admin.adminid">
          <b-td>{{ admin.employeeid }}</b-td>
          <b-td>{{ admin.lastname }}</b-td>
          <b-td>{{ admin.firstname }}</b-td>
          <b-td>{{ admin.title }}</b-td>
          <b-td>
            <b-button-group>
              <b-button
                variant="outline-danger"
                @click="() => deleteAdmin(admin.employeeid)"
                >Delete</b-button
              >
            </b-button-group>
          </b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
    <router-link to="/admin/employeelist" tag="b-button" class="float-left">List All Employees</router-link>
    <router-link to="/admin/newadmin" tag="b-button" class="float-left" style="margin-left:10px;">Add Admin</router-link>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "AdminArticleList",
  data: function () {
    return {
      loading: false,
      admins: [],
    };
  },
  created: function () {
    this.loadadmins();
  },

  methods: {
    loadadmins() {
      this.loading = true;
      this.admins = [];
      Api.getadmins().then((res) => {                      
        this.admins = res.data;
        this.loading = false;
      });
    },

    deleteAdmin(adminID) {
      Api.deleteAdmin(adminID)
        .then(() => {
          this.loadadmins();
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>






