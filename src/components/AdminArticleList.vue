<template>
  <div>
    <div v-if="loading">Loading articles....</div>
    
    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Name</b-th>
          <b-th>Price</b-th>
          <b-th>Location</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="product in products" :key="product.productid">
          <b-td>{{ product.productname }}</b-td>
          <b-td>{{ product.productprice }}</b-td>
          <b-td>{{ product.productlocation }}</b-td>
          <b-td>
            <b-button-group>
              
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