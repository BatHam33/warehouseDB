<template>
  <div>
    <div v-if="loading">Loading employees....</div>
    <router-link to="newadmin" tag="b-button" class="float-right"
      >Add Admin</router-link
    >
    <!--Change router link to add employee page-->
    <router-link to="newadmin" tag="b-button" class="float-right"
      >Add employee</router-link
    >
    <router-link to="adminlist" tag="b-button" class="float-right"
      >View Admins Only</router-link
    >
    
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