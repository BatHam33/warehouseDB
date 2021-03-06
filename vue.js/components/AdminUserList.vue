<template>
  <div>
    <div v-if="loading">Loading employees....</div>
    <router-link to="admin/add" tag="b-button" class="float-right"
      >Add employee</router-link
    >
    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>employeeid</b-th>
          <b-th>LastName</b-th>
          <b-th>FirstName</b-th>
          <b-th>position</b-th>
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
                variant="outline-primary"
                :to="`/admin/edit/${admin.adminid}`"
                >Edit</b-button
              >
              <b-button
                variant="outline-info"
                @click="() => publishArticle(admin.adminid)"
                >Publish</b-button
              >
              <b-button
                variant="outline-danger"
                @click="() => deleteArticle(admin.adminid)"
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
    publishArticle(articleid) {
      Api.publishArticle(articleid)
        .then(() => {
          this.loadArticles();
        })
        .catch((err) => {
          console.log(err);
        });
    },

    deleteArticle(articleid) {
      Api.deleteArticle(articleid)
        .then(() => {
          this.loadArticles();
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>