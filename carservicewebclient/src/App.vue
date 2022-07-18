<template>
	<nav ref="nav" class="navbar navbar-light bg-light mb-5 ml-0 row w-100">
		<div class="col-1 m-0" />
		<div class="navbar-brand col-2 justify-content-center m-0">
			<router-link class="nav-link" to="/">
				<div class="btn-light">
					<h1>CarService</h1>
				</div>
			</router-link>
		</div>
		<ul class="nav justify-content-center col-6 m-0">
			<template v-if="user.hasRole('admin')">
				<li class="nav-item">
					<router-link class="nav-link" to="/report/customer">
						<button class="btn btn-light btn-lg">Заказчик</button>
					</router-link>
				</li>
			</template>

			<template v-if="user.hasRole('admin')">
				<li class="nav-item">
					<router-link class="nav-link" to="/report/executor">
						<button class="btn btn-light btn-lg">Исполнитель</button>
					</router-link>
				</li>
			</template>

			<template v-if="user.hasRole('executor') || user.hasRole('admin')">
				<li class="nav-item">
					<router-link class="nav-link" to="/report/work">
						<button class="btn btn-light btn-lg">Работа</button>
					</router-link>
				</li>
			</template>

			<template v-if="(user.hasRole('customer') && user.hasRole('executor') == false) || user.hasRole('admin')">
				<li class="nav-item">
					<router-link class="nav-link" to="/report/transport">
						<button class="btn btn-light btn-lg">Транспорт</button>
					</router-link>
				</li>
			</template>
		</ul>
		<ul class="nav justify-content-center col-3 m-0">
			<template v-if="!authenticated">
				<li class="nav-item">
					<button class="btn btn-light btn-lg" @click="login">Вход</button>
				</li>
				<li class="nav-item">
					<button class="btn btn-light btn-lg" @click="register">
						Регистрация
					</button>
				</li>
			</template>
			<template v-else>
				<li class="nav-item">
					<router-link class="nav-link" to="/profile">
						<button class="btn btn-light btn-lg">
							{{ user.getName() }}
						</button>
					</router-link>
				</li>
				<li class="nav-item">
					<div class="nav-link">
						<button class="btn btn-light btn-lg" @click="logout">Выйти</button>
					</div>
				</li>
			</template>
		</ul>
	</nav>
	<div ref="navcontainer" class="container ml-auto mr-auto">
		<div class="border p-3 bg-white" style="height: 710px">
			<router-view v-slot="{ Component }">
				<transition name="component-fade" mode="out-in">
					<component :is="Component" />
				</transition>
			</router-view>
		</div>
	</div>
</template>

<script>
import keycloak from "./auth/keycloak.js";

export default {
	name: "App",
	data() {
		return {};
	},
	computed: {
		user() {
			return keycloak.getUser();
		},
		authenticated() {
			return keycloak.isAuthenticated();
		},
	},
	methods: {
		login() {
			keycloak.login(this.$router.currentRoute.value.fullPath);
		},
		logout() {
			keycloak.logout();
		},
		register() {
			keycloak.register();
		},
	},
};
</script>
