<template>
	<div class="about">
		<h1>{{ profile.getName() }}</h1>
		<label>ИНН: {{ profile.getINN() }}</label
		><br />
		<label>Роли: {{ profile.getRoles() }}</label
		><br />
		<label>Почта: {{ profile.getEmail() }}</label
		><br />
	</div>
</template>

<script>
import keycloak from "../auth/keycloak";

export default {
	name: "UserProfile",
	computed: {
		profile() {
			console.log(keycloak.getUser());
			return keycloak.getUser();
		},
		beforeMount() {
			
		}
	}
};
</script>
