<template>
  <div id="app">
    <h1>zgk-k8s-app-front</h1>
    <div style="display: inline-block; vertical-align: top; width:45%">
      <h2>Users</h2>
      <input v-model="newUserName" placeholder="name">
      <input v-model="newUserEmail" placeholder="email">
      <button @click="createUser">Create user</button>
      <ul>
        <li v-for="user in users" v-bind:key="user.email">{{ user.name }} | {{ user.email }}</li>
      </ul>
    </div>
    <div style="display: inline-block; vertical-align: top; width:45%">
      <h2>Plans</h2>
      <input v-model="newPlanName" placeholder="name">
      <input v-model="newPlanCity" placeholder="city">
      <input v-model="newPlanCountry" placeholder="country">
      <input v-model="newPlanDescription" placeholder="description">
      <button @click="createPlan">Create plan</button>
      <ul>
        <li
          v-for="plan in plans"
          v-bind:key="plan._id"
        >{{ plan.name }} | {{ plan.city }}, {{ plan.country }} | {{ plan.description }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
import axios from "axios";
import HelloWorld from "./components/HelloWorld.vue";

export default {
  name: "app",
  data: function() {
    return {
      plans: [],
      users: [],
      newUserName: "",
      newUserEmail: "",
      newPlanName: "",
      newPlanCity: "",
      newPlanCountry: "",
      newPlanDescription: ""
    };
  },
  props: {},
  components: {
    HelloWorld
  },
  methods: {
    createUser: async function() {
      try {
        const dataNewUser = {
          name: this.newUserName,
          email: this.newUserEmail
        };

        const newUser = await axios.post(
          "http://localhost:8000/users",
          dataNewUser
        );
        this.users.push(dataNewUser);
        this.newUserName = '';
        this.newUserEmail = '';
      } catch (err) {
        console.log("ERROR");
      }
    },
    loadUsers: function() {
      axios.get("http://localhost:8000/users").then(
        response => {
          this.users = response.data;
          console.log("this.users: ", this.users);
        },
        error => {
          console.log("ERROR: ", err.message);
          alert(err.message);
        }
      );
    },
    createPlan: async function() {
      try {
        const dataNewPlan = {
          name: this.newPlanName,
          city: this.newPlanCity,
          country: this.newPlanCountry,
          description: this.newPlanDescription
        };
        const newPlan = await axios.post(
          "http://localhost:8000/plans",
          dataNewPlan
        );
        this.plans.push(dataNewPlan);
        this.newPlanName = "";
        this.newPlanCity = "";
        this.newPlanCountry = "";
        this.newPlanDescription = "";
      } catch (err) {
        console.log("ERROR: ", err.message);
        alert(err.message);
      }
    },
    loadPlans: function() {
      axios.get("http://localhost:8000/plans").then(
        response => {
          this.plans = response.data;
        },
        error => {
          console.log("ERROR: ", error);
        }
      );
    }
  },
  mounted: function() {
    this.loadUsers();
    this.loadPlans();
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

ul {
  list-style: none;
  text-align: left;
}
</style>
