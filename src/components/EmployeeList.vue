<template>
  <div>
		<br><div style="text-align:center; font-weight:bold; font-size:250%;">Employee List</div><br>
    <div v-if="loading">Loading employees....</div>
    <router-link to="/logout" tag="b-button" class="float-right" style="margin-left:10px;">Log Out</router-link>
    <!--Change router link to add employee page-->
    <router-link to="/newcustomer" tag="b-button" class="float-right" style="margin-left:10px;">Add Customer</router-link>
    <router-link to="/product" tag="b-button" class="float-right">Products</router-link>
    

    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Employee ID</b-th>
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
                @click="() => deleteEmployee(admin.employeeid)"
                >Delete</b-button
              >
            </b-button-group>
          </b-td>
        </b-tr>
      </b-tbody>
    <router-link to="/admin/adminlist" tag="b-button" class="float-left">List Admins Only</router-link>
    <router-link to="/admin/newadmin" tag="b-button" class="float-left" style="margin-left:10px;">Add Admin</router-link>
    </b-table-simple>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "EmployeeList",
  data: function () {
    return {
      loading: false,
      admins: [],
    };
  },
  created: function () {
    this.loadEmployees();
  },

  methods: {
    loadEmployees() {
      this.loading = true;
      this.admins = [];
      Api.getEmployees().then((res) => {                      
        this.admins = res.data;
        this.loading = false;
      });
    },
    
    deleteEmployee(employeeid) {
      Api.deleteEmployee(employeeid)
        .then(() => {
          this.loadEmployees();
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>

















