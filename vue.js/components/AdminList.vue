<template>
  <div>
    <div v-if="loading">Loading admins....</div>
    <router-link to="admin/addadmin" tag="b-button" class="float-right"
      >Add admins</router-link
    >
    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>adminid</b-th>
          <b-th>username</b-th>
          <b-th>employeeid</b-th>
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
                @click="() => deleteAdmin(admin.adminid)"
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
  name: "AdminList",
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