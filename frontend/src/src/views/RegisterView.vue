<template>
  <div class="register-container">
    <div class="card">
      <h2>Registro</h2>
      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label>Nombre:</label>
          <input
            v-model="form.name"
            type="text"
            required
            placeholder="Tu nombre"
          />
        </div>
        <div class="form-group">
          <label>Email:</label>
          <input
            v-model="form.email"
            type="email"
            required
            placeholder="correo@example.com"
          />
        </div>
        <div class="form-group">
          <label>Contraseña:</label>
          <input
            v-model="form.password"
            type="password"
            required
            placeholder="********"
          />
        </div>
        <button type="submit" :disabled="loading">
          {{ loading ? "Creando cuenta..." : "Crear cuenta" }}
        </button>
      </form>
      <p v-if="error" class="error-msg">{{ error }}</p>
      <p v-if="success" class="success-msg">{{ success }}</p>
      <p>
        ¿Ya tienes cuenta? <router-link to="/login">Inicia sesión</router-link>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";

const router = useRouter();
const loading = ref(false);
const error = ref(null);
const success = ref(null);

const form = reactive({ name: "", email: "", password: "" });

const handleRegister = async () => {
  loading.value = true;
  error.value = null;
  success.value = null;
  try {
    await axios.post(
      "http://192.168.116.232:8000/api/v1/register",
      {
        name: form.name,
        surname: form.name,
        email: form.email,
        password: form.password,
        role: "producer",
        avatar_url: "",
        bio: "",
      },
      {
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
      },
    );
    success.value = "Cuenta creada correctamente. Redirigiendo...";
    setTimeout(() => router.push("/login"), 1500);
  } catch (err) {
    error.value =
      err.response?.data?.message ||
      err.response?.data?.error ||
      "Error al registrarse";
  } finally {
    loading.value = false;
  }
};
</script>
