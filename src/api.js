import axios from "axios";
import { authHeader, getJwtToken, getUserIdFromToken } from "./auth";

const API_URL = "http://192.168.50.70:8000";

class Api {
  getProducts() {
    return axios.get(API_URL + "/product", {});
  }
  getadmins() {
    return axios.get(API_URL + "/list_of_admins", {
        headers: authHeader(),
      } );
  }

  getArticleDetail(id) {
    return axios.get(API_URL + `/articles?articleid=eq.${id}`);
  }

  addArticle(article) {
    return axios.post(
      API_URL + "/articles",
      {
        ...article,
        // add user id from JWT token
        userid: getUserIdFromToken(getJwtToken()),
      },
      {
        headers: authHeader(),
      }
    );
  }

  updateArticle(article) {
    return axios.patch(
      API_URL + `/articles?articleid=eq.${article.articleid}`,
      article,
      {
        headers: authHeader(),
      }
    );
  }

  deleteArticle(id) {
    return axios.delete(API_URL + `/articles?articleid=eq.${id}`, {
      headers: authHeader(),
    });
  }

  publishArticle(id) {
    return axios.post(
      API_URL + "/rpc/publish",
      { id: id },
      {
        headers: authHeader(),
      }
    );
  }

  login(username, password) {
    return axios.post(API_URL + "/rpc/login", { username, password });
  }

  signup(email, password, name) {
    return axios.post(API_URL + "/rpc/signup", { email, password, name });

  }
}

export default new Api();
