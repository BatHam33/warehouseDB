<template>
  <div>
    <div v-if="loading">Loading articles....</div>
    <router-link to="admin/add" tag="b-button" class="float-right"
      >Add article</router-link
    >
    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>ID</b-th>
          <b-th>Title</b-th>
          <b-th>Published</b-th>
          <b-th>Actions</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="product in products" :key="product.productid">
          <b-td>{{ product.productname }}</b-td>
          <b-td>{{ product.title }}</b-td>
          <b-td>{{ product.ispublished }}</b-td>
          <b-td>
            <b-button-group>
              <b-button
                variant="outline-primary"
                :to="`/admin/edit/${product.productid}`"
                >Edit</b-button
              >
              <b-button
                variant="outline-info"
                @click="() => publishArticle(product.productid)"
                >Publish</b-button
              >
              <b-button
                variant="outline-danger"
                @click="() => deleteArticle(product.productid)"
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
      products: [],
    };
  },
  created: function () {
    this.loadProducts();
  },

  methods: {
    loadProducts() {
      this.loading = true;
      this.products = [];
      Api.getProducts().then((res) => {                      
        this.products = res.data;
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