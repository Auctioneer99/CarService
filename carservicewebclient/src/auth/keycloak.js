import Keycloak from "keycloak-js";
import routes from "../routes";
import keycloakUser from "./keycloakUser";

var { self } = routes;

var url = `http://${process.env.VUE_APP_KEYCLOAK_HOST ?? "localhost"}:${
	process.env.VUE_APP_KEYCLOAK_PORT ?? 8080
}`;

let initOptions = {
	url: url,
	realm: process.env.VUE_APP_KEYCLOAK_REALM ?? "master",
	clientId: process.env.VUE_APP_KEYCLOAK_CLIENT ?? "client",
	onLoad: "login-required",
};
let keycloak = Keycloak(initOptions);

var user = new keycloakUser();

export default {
	init() {
		return keycloak.init({ onLoad: initOptions.onLoad }).catch(() => {
			console.error("Failed to refresh token");
		});
	},
	updateToken() {
		keycloak.updateToken(70);
	},
	login(url) {
		if (keycloak.authenticated == false) {
			return keycloak.login({ redirectUri: self + url });
		}
		this.updateToken();
	},
	logout() {
		keycloak.logout();
	},
	register() {
		keycloak.register();
		this.updateToken();
	},
	getUser() {
		user.user = keycloak;
		return user;
	},
	isAuthenticated() {
		return keycloak.authenticated;
	},
};
