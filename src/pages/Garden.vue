Testing
<template>
  <div>

    <div v-if="loading">Loading products....</div>
<br><div style="text-align:center; font-weight:bold; font-size:250%;">Product Category: Garden</div><br>
    <br /><br />
 <router-link to="/admin" tag="b-button" class="float-left">Home</router-link>


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
          <b-td v-if="product.categoryid==5">{{ product.productname }}</b-td>
          <b-td v-if="product.categoryid==5">${{ product.productprice }}</b-td>
          <b-td v-if="product.categoryid==5">{{ product.productlocation }}</b-td>
          <b-td v-if="product.categoryid==5">
            <b-button-group>
              <b-button
                variant="outline-danger"
                @click="() => deleteProduct(product.productid)"
                >Delete</b-button
              >
            </b-button-group>
           </b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>



 <router-link to="/admin/AddProduct" tag="b-button" class="float-left">Add Product</router-link>
 <b-dropdown tag="b-dropdown" class="float-left" text="Filter By Category: Garden"  style="margin-left:10px;">
    <b-dropdown-item router-link to="/product" >None</b-dropdown-item>
    <b-dropdown-item router-link to="/Auto" >Auto</b-dropdown-item>
    <b-dropdown-item router-link to="/Clothing">Clothing</b-dropdown-item>
    <b-dropdown-item router-link to="/Food">Food</b-dropdown-item>
    <b-dropdown-item router-link to="/Furniture">Furniture</b-dropdown-item>
    <b-dropdown-item router-link to="/Garden">Garden</b-dropdown-item>
    <b-dropdown-item router-link to="/Pharmacy">Pharmacy</b-dropdown-item>
</b-dropdown>


  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "Product",
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
    deleteProduct(productid) {
      Api.deleteProduct(productid)
        .then(() => {
          this.loadProducts();
        })
        .catch((err) => {
          console.log(err);
        });
    },
  },
};
</script>
