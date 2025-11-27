<template>
  <div style="padding: 40px; text-align:center;">
    <h1>Welcome to PhotoSync</h1>
    <p>Book professional photoshoots with ease</p>

    <div style="max-width: 600px; margin: 40px auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px;">
      <div style="background: #f8f9fa; padding: 30px; border-radius: 10px;">
        <h3>📸 Book a Photoshoot</h3>
        <p>Schedule your perfect photoshoot with our professional photographers</p>
        <router-link to="/booking" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px; margin-top: 10px;">
          Book Now
        </router-link>
      </div>

      <div style="background: #f8f9fa; padding: 30px; border-radius: 10px;">
        <h3>💬 Contact Us</h3>
        <p>Have questions? Get in touch with our team</p>
        <router-link to="/contact" style="display: inline-block; padding: 10px 20px; background: #28a745; color: white; text-decoration: none; border-radius: 5px; margin-top: 10px;">
          Contact
        </router-link>
      </div>
    </div>

    <div style="margin-top: 40px; padding: 20px; background: #e9ecef; border-radius: 10px; max-width: 800px; margin-left: auto; margin-right: auto;">
      <h3>Our Services</h3>
      <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-top: 20px;">
        <div style="text-align: center;">
          <div style="font-size: 24px; margin-bottom: 10px;">👤</div>
          <strong>Portrait</strong>
        </div>
        <div style="text-align: center;">
          <div style="font-size: 24px; margin-bottom: 10px;">💒</div>
          <strong>Wedding</strong>
        </div>
        <div style="text-align: center;">
          <div style="font-size: 24px; margin-bottom: 10px;">🎉</div>
          <strong>Event</strong>
        </div>
        <div style="text-align: center;">
          <div style="font-size: 24px; margin-bottom: 10px;">📦</div>
          <strong>Product</strong>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.router-link-active {
  font-weight: bold;
}
</style>
