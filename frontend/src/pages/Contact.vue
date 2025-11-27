<template>
  <div style="max-width: 500px; margin: 50px auto;">
    <h1>Contact Us</h1>

    <form @submit.prevent="submitForm">
      <label>Email (optional)</label>
      <input v-model="email" type="email" placeholder="you@example.com" />

      <label>Message</label>
      <textarea v-model="msg" required placeholder="Write your message here..."></textarea>

      <button type="submit">Send</button>
    </form>

    <p v-if="status">{{ status }}</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: "",
      msg: "",
      status: "",
    }
  },
  methods: {
    async submitForm() {
      this.status = "Sending..."

      try {
        const apiUrl = import.meta.env.VITE_API_URL
        
        if (!apiUrl) {
          throw new Error("API URL not configured. Please set VITE_API_URL in your environment.")
        }

        const res = await fetch(apiUrl + "/api/messages", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            email: this.email,
            msg: this.msg
          }),
        });

        if (!res.ok) throw new Error("Failed request")

        this.status = "Message sent successfully!"
        this.email = ""
        this.msg = ""
      } catch (e) {
        this.status = "Error sending message: " + e.message
      }
    }
  }
}
</script>

<style>
form {
  display: flex;
  flex-direction: column;
  gap: 15px;
}
input, textarea {
  padding: 10px;
  font-size: 16px;
}
button {
  padding: 12px;
  font-size: 16px;
  cursor: pointer;
}
</style>
