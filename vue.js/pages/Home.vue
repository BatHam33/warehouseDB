<template>
  <div>
    <b-jumbotron>
      <p>Welcome to Warhouse World</p>
    </b-jumbotron>
    <br />
    <div v-if="loading">Loading products....</div>
    <ul v-else>
      <li v-for="product in products" :key="product.productid"><!--We need to double check if this is how we go through each product-->
        <!--We need to add a product vue that will lead to the correct layout-->
        <router-link :to="`product/${product.productid}`">{{ 
          article.name
        }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import Api from "../api";
export default {
  name: "Home",
  data: function () {
    return {
      loading: false,
      articles: [],
    };
  },
  created: function () {
    this.loading = true;
    Api.getArticles().then((res) => {
      this.articles = res.data;
      this.loading = false;
    });
  },
};
</script>