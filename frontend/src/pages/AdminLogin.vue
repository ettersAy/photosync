<template>
  <div>
    <h2>Admin Login</h2>
    <form @submit.prevent="login">
      <div>
        <label for="email">Email:</label>
        <input type="email" id="email" v-model="email" required>
      </div>
      <div>
        <label for="password">Password:</label>
        <input type="password" id="password" v-model="password" required>
      </div>
      <button type="submit">Login</button>
    </form>
    <p v-if="errorMessage">{{ errorMessage }}</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      email: '',
      password: '',
      errorMessage: ''
    };
  },
  methods: {
    async login() {
      this.errorMessage = '';
      try {
        const apiUrl = import.meta.env.VITE_API_URL
        
        if (!apiUrl) {
          throw new Error("API URL not configured. Please set VITE_API_URL in your environment.")
        }

        const response = await fetch(apiUrl + '/api/login', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            email: this.email,
            password: this.password
          })
        });

        if (response.ok) {
          const data = await response.json();
          // Store the token securely (e.g., in memory or HttpOnly cookie)
          console.log('Login successful, token:', data.access_token);
          this.$router.push('/admin/dashboard');
        } else {
          const errorData = await response.json();
          this.errorMessage = errorData.message || 'Login failed.';
        }
      } catch (error) {
        this.errorMessage = 'An error occurred during login.';
        console.error('Login error:', error);
      }
    }
  }
};
</script>
