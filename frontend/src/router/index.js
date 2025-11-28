import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../pages/Dashboard.vue'
import Contact from '../pages/Contact.vue'

const routes = [
  { path: '/', name: 'Dashboard', component: Dashboard },
  { path: '/contact', name: 'Contact', component: Contact },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router