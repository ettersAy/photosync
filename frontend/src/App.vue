<template>
  <nav style="padding: 20px; display:flex; gap:20px; background:#f5f5f5;">
    <router-link to="/">Dashboard</router-link>
    <router-link to="/booking">Book a Photoshoot</router-link>
    <router-link to="/contact">Contact Us</router-link>
    <router-link to="/admin" style="margin-left: auto;">Admin</router-link>
  </nav>

  <router-view />
</template>

<style>
.router-link-active {
  font-weight: bold;
  color: #007bff;
}

a {
  text-decoration: none;
  color: #333;
}

a:hover {
  color: #007bff;
}
</style>

