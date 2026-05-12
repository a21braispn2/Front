<template>
  <div class="login-container">
    <div class="card">
      <h2>Iniciar Sesión</h2>
      <form @submit.prevent="handleLogin">
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
          {{ loading ? "Entrando..." : "Entrar" }}
        </button>
      </form>
      <p v-if="error" class="error-msg">{{ error }}</p>
      <p>
        ¿No tienes cuenta? <router-link to="/register">Regístrate</router-link>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from "vue";
import { loginUser } from "@/services/api";
import { useRouter } from "vue-router";

const router = useRouter();
const loading = ref(false);
const error = ref(null);

const form = reactive({ email: "", password: "" });

const handleLogin = async () => {
  loading.value = true;
  error.value = null;
  try {
    const response = await loginUser(form);
    const token = response.data.access_token || response.data.token;
    localStorage.setItem("access_token", token);
    router.push("/home");
  } catch (err) {
    error.value =
      err.response?.data?.error ||
      err.response?.data?.message ||
      "Error al conectar con el servidor";
  } finally {
    loading.value = false;
  }
};
</script>
