<template>
  <div style="max-width: 600px; margin: 50px auto;">
    <h1>Book a Photoshoot</h1>

    <form @submit.prevent="submitBooking" style="display: flex; flex-direction: column; gap: 20px;">
      <!-- Customer Information -->
      <fieldset style="border: 1px solid #ccc; padding: 20px;">
        <legend style="font-weight: bold;">Your Information</legend>
        
        <div style="display: flex; flex-direction: column; gap: 10px;">
          <label>
            Full Name *
            <input v-model="booking.customer.name" type="text" required style="width: 100%; padding: 8px; margin-top: 5px;">
          </label>
          
          <label>
            Email *
            <input v-model="booking.customer.email" type="email" required style="width: 100%; padding: 8px; margin-top: 5px;">
          </label>
          
          <label>
            Phone
            <input v-model="booking.customer.phone" type="tel" style="width: 100%; padding: 8px; margin-top: 5px;">
          </label>
          
          <label>
            Notes
            <textarea v-model="booking.customer.notes" placeholder="Any special requirements or preferences..." style="width: 100%; padding: 8px; margin-top: 5px; height: 80px;"></textarea>
          </label>
        </div>
      </fieldset>

      <!-- Photoshoot Details -->
      <fieldset style="border: 1px solid #ccc; padding: 20px;">
        <legend style="font-weight: bold;">Photoshoot Details</legend>
        
        <div style="display: flex; flex-direction: column; gap: 10px;">
          <label>
            Shoot Type *
            <select v-model="booking.photoshoot.type" required style="width: 100%; padding: 8px; margin-top: 5px;">
              <option value="">Select a type</option>
              <option value="portrait">Portrait</option>
              <option value="wedding">Wedding</option>
              <option value="event">Event</option>
              <option value="product">Product</option>
              <option value="other">Other</option>
            </select>
          </label>
          
          <label>
            Duration (minutes) *
            <select v-model="booking.photoshoot.duration_minutes" required style="width: 100%; padding: 8px; margin-top: 5px;">
              <option value="30">30 minutes</option>
              <option value="60">1 hour</option>
              <option value="90">1.5 hours</option>
              <option value="120">2 hours</option>
              <option value="180">3 hours</option>
            </select>
          </label>
          
          <label>
            Description
            <textarea v-model="booking.photoshoot.description" placeholder="Describe what you're looking for..." style="width: 100%; padding: 8px; margin-top: 5px; height: 80px;"></textarea>
          </label>
        </div>
      </fieldset>

      <!-- Appointment Scheduling -->
      <fieldset style="border: 1px solid #ccc; padding: 20px;">
        <legend style="font-weight: bold;">Schedule Appointment</legend>
        
        <div style="display: flex; flex-direction: column; gap: 10px;">
          <label>
            Date *
            <input 
              v-model="selectedDate" 
              type="date" 
              :min="today" 
              @change="loadAvailableSlots" 
              required 
              style="width: 100%; padding: 8px; margin-top: 5px;"
            >
          </label>
          
          <div v-if="loadingSlots" style="text-align: center; padding: 10px;">
            Loading available time slots...
          </div>
          
          <div v-else-if="availableSlots.length > 0">
            <label>Available Time Slots *</label>
            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 10px; margin-top: 10px;">
              <button
                v-for="slot in availableSlots"
                :key="slot.datetime"
                type="button"
                @click="selectTimeSlot(slot)"
                :class="['time-slot', { selected: selectedTimeSlot?.datetime === slot.datetime }]"
                style="padding: 10px; border: 1px solid #ccc; background: white; cursor: pointer;"
              >
                {{ slot.start }}
              </button>
            </div>
          </div>
          
          <div v-else-if="selectedDate" style="color: #666; text-align: center; padding: 10px;">
            No available slots for this date. Please select another date.
          </div>
          
          <label>
            Location
            <input v-model="booking.appointment.location" placeholder="Where should we meet?" style="width: 100%; padding: 8px; margin-top: 5px;">
          </label>
          
          <label>
            Appointment Notes
            <textarea v-model="booking.appointment.notes" placeholder="Any specific details about the appointment..." style="width: 100%; padding: 8px; margin-top: 5px; height: 60px;"></textarea>
          </label>
        </div>
      </fieldset>

      <button 
        type="submit" 
        :disabled="!isFormValid || submitting" 
        style="padding: 15px; background: #007bff; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer;"
      >
        {{ submitting ? 'Booking...' : 'Book Photoshoot' }}
      </button>

      <p v-if="status" :style="{ color: status.includes('Error') ? 'red' : 'green' }">{{ status }}</p>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      booking: {
        customer: {
          name: '',
          email: '',
          phone: '',
          notes: ''
        },
        photoshoot: {
          type: '',
          description: '',
          duration_minutes: 60,
          price: null
        },
        appointment: {
          scheduled_at: '',
          location: '',
          notes: ''
        }
      },
      selectedDate: '',
      selectedTimeSlot: null,
      availableSlots: [],
      loadingSlots: false,
      submitting: false,
      status: '',
      today: new Date().toISOString().split('T')[0]
    }
  },
  computed: {
    isFormValid() {
      return (
        this.booking.customer.name &&
        this.booking.customer.email &&
        this.booking.photoshoot.type &&
        this.selectedTimeSlot
      )
    }
  },
  methods: {
    async loadAvailableSlots() {
      if (!this.selectedDate) return
      
      this.loadingSlots = true
      this.availableSlots = []
      this.selectedTimeSlot = null

      try {
        const apiUrl = import.meta.env.VITE_API_URL
        const res = await fetch(`${apiUrl}/api/bookings/available-slots?date=${this.selectedDate}`)
        
        if (!res.ok) throw new Error('Failed to load available slots')
        
        const data = await res.json()
        this.availableSlots = data.available_slots || []
      } catch (e) {
        this.status = 'Error loading available slots: ' + e.message
      } finally {
        this.loadingSlots = false
      }
    },
    
    selectTimeSlot(slot) {
      this.selectedTimeSlot = slot
      // Combine date and time for the scheduled_at field
      this.booking.appointment.scheduled_at = `${this.selectedDate} ${slot.start}:00`
    },
    
    async submitBooking() {
      this.submitting = true
      this.status = ''

      try {
        const apiUrl = import.meta.env.VITE_API_URL
        
        if (!apiUrl) {
          throw new Error("API URL not configured. Please set VITE_API_URL in your environment.")
        }

        const res = await fetch(apiUrl + "/api/bookings", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(this.booking),
        });

        if (!res.ok) {
          const errorData = await res.json()
          throw new Error(errorData.message || 'Failed to create booking')
        }

        const data = await res.json()
        this.status = 'Booking created successfully! We\'ll contact you soon to confirm.'
        
        // Reset form
        this.resetForm()
      } catch (e) {
        this.status = 'Error creating booking: ' + e.message
      } finally {
        this.submitting = false
      }
    },
    
    resetForm() {
      this.booking = {
        customer: {
          name: '',
          email: '',
          phone: '',
          notes: ''
        },
        photoshoot: {
          type: '',
          description: '',
          duration_minutes: 60,
          price: null
        },
        appointment: {
          scheduled_at: '',
          location: '',
          notes: ''
        }
      }
      this.selectedDate = ''
      this.selectedTimeSlot = null
      this.availableSlots = []
    }
  }
}
</script>

<style scoped>
.time-slot.selected {
  background: #007bff !important;
  color: white !important;
  border-color: #007bff !important;
}

fieldset {
  border-radius: 8px;
}

label {
  font-weight: 500;
}

button:disabled {
  background: #ccc !important;
  cursor: not-allowed !important;
}
</style>