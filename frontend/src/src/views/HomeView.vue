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
import { getUser, logoutUser } from "@/services/api";
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
    const response = await getUser();
    user.value = response.data;
  } catch {
    localStorage.removeItem("access_token");
    router.push("/login");
  }
});

const handleLogout = async () => {
  try {
    await logoutUser();
  } catch {
    /* ignorar error de logout */
  } finally {
    localStorage.removeItem("access_token");
    router.push("/login");
  }
};
</script>
