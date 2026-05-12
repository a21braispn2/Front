<template>
  <div style="padding: 20px">
    <h2>Inicio</h2>
    <div v-if="user">
      <p>
        Bienvenido, <strong>{{ user.name }}</strong>
      </p>
      <p>Email: {{ user.email }}</p>
      <p>Rol: {{ user.role }}</p>
      <br />
      <button id="btn-logout" @click="handleLogout">Cerrar sesión</button>
    </div>
    <p v-else>Cargando...</p>
    <p v-if="error" style="color: red">{{ error }}</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";

const router = useRouter();
const user = ref(null);
const error = ref(null);

onMounted(async () => {
  const token = localStorage.getItem("access_token");
  if (!token) {
    router.push("/login");
    return;
  }
  try {
    const response = await axios.get(
      "http://192.168.116.232:8000/api/v1/user",
      {
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: "application/json",
        },
      },
    );
    user.value = response.data;
  } catch {
    localStorage.removeItem("access_token");
    router.push("/login");
  }
});

const handleLogout = async () => {
  const token = localStorage.getItem("access_token");
  try {
    await axios.post(
      "http://192.168.116.232:8000/api/v1/logout",
      {},
      {
        headers: {
          Authorization: `Bearer ${token}`,
          Accept: "application/json",
        },
      },
    );
  } catch {
    /* ignorar error de logout */
  } finally {
    localStorage.removeItem("access_token");
    router.push("/login");
  }
};
</script>
