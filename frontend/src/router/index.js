import { createRouter, createWebHistory } from 'vue-router'
import Dashboard from '../pages/Dashboard.vue'
import Contact from '../pages/Contact.vue'
import Booking from '../pages/Booking.vue'
import AdminDashboard from '../pages/AdminDashboard.vue'

const routes = [
  { path: '/', name: 'Dashboard', component: Dashboard },
  { path: '/contact', name: 'Contact', component: Contact },
  { path: '/booking', name: 'Booking', component: Booking },
  { path: '/admin', name: 'AdminDashboard', component: AdminDashboard },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router