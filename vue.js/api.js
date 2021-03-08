import axios from "axios";
import { authHeader } from "./auth";
//getJwtToken, getUserIdFromToken 

const API_URL = "http://192.168.50.70:8000";

class Api {
  getProducts() {
    return axios.get(API_URL + "/products", {});
  }

  getadmins() {
    return axios.get(API_URL + "/list_of_admins", {
        headers: authHeader(),
      } );
  }

  deleteAdmin(adminID){
    return axios.get(API_URL + "delete_admin" + adminID, {
    headers: authHeader(),
    } );
  }

  getProductOfType(category) {
    return axios.get(API_URL + "/get_all_"+category);
  }

  login_admin(username, password) {
    return axios.post(API_URL + "/rpc/login", { username, password });
  }

  login_customer(email, password) {
    return axios.post(API_URL + "/rpc/login_customer", {email, password})
  }

  signup_customer(email, password, name) {
    return axios.post(API_URL + "/rpc/signup", { email, password, name });
  }

}

export default new Api();