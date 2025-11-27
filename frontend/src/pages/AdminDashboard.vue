<template>
  <div style="padding: 20px; max-width: 1200px; margin: 0 auto;">
    <h1>Admin Dashboard</h1>
    
    <!-- Stats Overview -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px;">
      <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center;">
        <h3 style="margin: 0; color: #007bff;">{{ stats.totalBookings }}</h3>
        <p style="margin: 5px 0 0 0; color: #666;">Total Bookings</p>
      </div>
      <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center;">
        <h3 style="margin: 0; color: #28a745;">{{ stats.pendingBookings }}</h3>
        <p style="margin: 5px 0 0 0; color: #666;">Pending</p>
      </div>
      <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center;">
        <h3 style="margin: 0; color: #ffc107;">{{ stats.confirmedBookings }}</h3>
        <p style="margin: 5px 0 0 0; color: #666;">Confirmed</p>
      </div>
      <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center;">
        <h3 style="margin: 0; color: #17a2b8;">{{ stats.totalMessages }}</h3>
        <p style="margin: 5px 0 0 0; color: #666;">Messages</p>
      </div>
    </div>

    <!-- Tabs -->
    <div style="margin-bottom: 20px;">
      <button 
        v-for="tab in tabs" 
        :key="tab.id"
        @click="activeTab = tab.id"
        :style="{
          padding: '10px 20px',
          border: 'none',
          background: activeTab === tab.id ? '#007bff' : '#f8f9fa',
          color: activeTab === tab.id ? 'white' : '#333',
          cursor: 'pointer',
          marginRight: '10px',
          borderRadius: '5px'
        }"
      >
        {{ tab.label }}
      </button>
    </div>

    <!-- Bookings Tab -->
    <div v-if="activeTab === 'bookings'" style="background: white; border-radius: 8px; padding: 20px;">
      <h2>Recent Bookings</h2>
      
      <div v-if="loading" style="text-align: center; padding: 40px;">
        Loading bookings...
      </div>
      
      <div v-else-if="bookings.length === 0" style="text-align: center; padding: 40px; color: #666;">
        No bookings found.
      </div>
      
      <div v-else>
        <div style="overflow-x: auto;">
          <table style="width: 100%; border-collapse: collapse;">
            <thead>
              <tr style="background: #f8f9fa;">
                <th style="padding: 12px; text-align: left; border-bottom: 1px solid #dee2e6;">Customer</th>
                <th style="padding: 12px; text-align: left; border-bottom: 1px solid #dee2e6;">Type</th>
                <th style="padding: 12px; text-align: left; border-bottom: 1px solid #dee2e6;">Scheduled</th>
                <th style="padding: 12px; text-align: left; border-bottom: 1px solid #dee2e6;">Status</th>
                <th style="padding: 12px; text-align: left; border-bottom: 1px solid #dee2e6;">Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="booking in bookings" :key="booking.id" style="border-bottom: 1px solid #dee2e6;">
                <td style="padding: 12px;">
                  <strong>{{ booking.customer.name }}</strong><br>
                  <small style="color: #666;">{{ booking.customer.email }}</small>
                </td>
                <td style="padding: 12px;">{{ booking.type }}</td>
                <td style="padding: 12px;">
                  <span v-if="booking.appointments.length > 0">
                    {{ formatDate(booking.appointments[0].scheduled_at) }}
                  </span>
                  <span v-else style="color: #999;">Not scheduled</span>
                </td>
                <td style="padding: 12px;">
                  <span :style="getStatusStyle(booking.status)" style="padding: 4px 8px; border-radius: 4px; font-size: 12px;">
                    {{ booking.status }}
                  </span>
                </td>
                <td style="padding: 12px;">
                  <button 
                    @click="viewBooking(booking)"
                    style="padding: 6px 12px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; margin-right: 5px;"
                  >
                    View
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Messages Tab -->
    <div v-if="activeTab === 'messages'" style="background: white; border-radius: 8px; padding: 20px;">
      <h2>Contact Messages</h2>
      
      <div v-if="loadingMessages" style="text-align: center; padding: 40px;">
        Loading messages...
      </div>
      
      <div v-else-if="messages.length === 0" style="text-align: center; padding: 40px; color: #666;">
        No messages found.
      </div>
      
      <div v-else>
        <div v-for="message in messages" :key="message.id" style="border: 1px solid #e9ecef; border-radius: 8px; padding: 15px; margin-bottom: 15px;">
          <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 10px;">
            <div>
              <strong>{{ message.email || 'Anonymous' }}</strong>
              <small style="color: #666; margin-left: 10px;">{{ formatDate(message.created_at) }}</small>
            </div>
          </div>
          <p style="margin: 0; color: #333;">{{ message.msg }}</p>
        </div>
      </div>
    </div>

    <!-- Booking Details Modal -->
    <div v-if="selectedBooking" style="position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 1000;">
      <div style="background: white; padding: 30px; border-radius: 8px; max-width: 600px; width: 90%; max-height: 80vh; overflow-y: auto;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
          <h2 style="margin: 0;">Booking Details</h2>
          <button @click="selectedBooking = null" style="background: none; border: none; font-size: 24px; cursor: pointer; color: #666;">&times;</button>
        </div>
        
        <div v-if="selectedBooking">
          <h3>Customer Information</h3>
          <div style="background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
            <p><strong>Name:</strong> {{ selectedBooking.customer.name }}</p>
            <p><strong>Email:</strong> {{ selectedBooking.customer.email }}</p>
            <p v-if="selectedBooking.customer.phone"><strong>Phone:</strong> {{ selectedBooking.customer.phone }}</p>
            <p v-if="selectedBooking.customer.notes"><strong>Notes:</strong> {{ selectedBooking.customer.notes }}</p>
          </div>
          
          <h3>Photoshoot Details</h3>
          <div style="background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
            <p><strong>Type:</strong> {{ selectedBooking.type }}</p>
            <p><strong>Duration:</strong> {{ selectedBooking.duration_minutes }} minutes</p>
            <p v-if="selectedBooking.description"><strong>Description:</strong> {{ selectedBooking.description }}</p>
            <p><strong>Status:</strong> <span :style="getStatusStyle(selectedBooking.status)" style="padding: 4px 8px; border-radius: 4px; font-size: 12px;">{{ selectedBooking.status }}</span></p>
          </div>
          
          <h3>Appointment</h3>
          <div v-if="selectedBooking.appointments.length > 0" style="background: #f8f9fa; padding: 15px; border-radius: 5px;">
            <p><strong>Scheduled:</strong> {{ formatDateTime(selectedBooking.appointments[0].scheduled_at) }}</p>
            <p v-if="selectedBooking.appointments[0].location"><strong>Location:</strong> {{ selectedBooking.appointments[0].location }}</p>
            <p v-if="selectedBooking.appointments[0].notes"><strong>Notes:</strong> {{ selectedBooking.appointments[0].notes }}</p>
          </div>
          <div v-else style="background: #f8f9fa; padding: 15px; border-radius: 5px; color: #666;">
            No appointment scheduled
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      activeTab: 'bookings',
      tabs: [
        { id: 'bookings', label: 'Bookings' },
        { id: 'messages', label: 'Messages' }
      ],
      bookings: [],
      messages: [],
      stats: {
        totalBookings: 0,
        pendingBookings: 0,
        confirmedBookings: 0,
        totalMessages: 0
      },
      loading: false,
      loadingMessages: false,
      selectedBooking: null
    }
  },
  async mounted() {
    await this.loadBookings()
    await this.loadMessages()
    this.calculateStats()
  },
  methods: {
    async loadBookings() {
      this.loading = true
      try {
        const apiUrl = import.meta.env.VITE_API_URL
        const res = await fetch(`${apiUrl}/api/bookings`)
        
        if (!res.ok) throw new Error('Failed to load bookings')
        
        const data = await res.json()
        this.bookings = data.data || []
      } catch (e) {
        console.error('Error loading bookings:', e)
      } finally {
        this.loading = false
      }
    },
    
    async loadMessages() {
      this.loadingMessages = true
      try {
        const apiUrl = import.meta.env.VITE_API_URL
        const res = await fetch(`${apiUrl}/api/messages`)
        
        if (!res.ok) throw new Error('Failed to load messages')
        
        const data = await res.json()
        this.messages = data.data || []
      } catch (e) {
        console.error('Error loading messages:', e)
      } finally {
        this.loadingMessages = false
      }
    },
    
    calculateStats() {
      this.stats.totalBookings = this.bookings.length
      this.stats.pendingBookings = this.bookings.filter(b => b.status === 'pending').length
      this.stats.confirmedBookings = this.bookings.filter(b => b.status === 'confirmed').length
      this.stats.totalMessages = this.messages.length
    },
    
    viewBooking(booking) {
      this.selectedBooking = booking
    },
    
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString()
    },
    
    formatDateTime(dateString) {
      return new Date(dateString).toLocaleString()
    },
    
    getStatusStyle(status) {
      const styles = {
        pending: { background: '#fff3cd', color: '#856404' },
        confirmed: { background: '#d1ecf1', color: '#0c5460' },
        completed: { background: '#d4edda', color: '#155724' },
        cancelled: { background: '#f8d7da', color: '#721c24' }
      }
      return styles[status] || { background: '#f8f9fa', color: '#6c757d' }
    }
  },
  watch: {
    bookings() {
      this.calculateStats()
    }
  }
}
</script>