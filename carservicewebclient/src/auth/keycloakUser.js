class KeycloakUser {
	constructor() {
		this.user = null;
	}

	getName() {
		return this.user.tokenParsed.name;
	}

	getEmail() {
		return this.user.tokenParsed.email;
	}

	getINN() {
		return this.user.tokenParsed.inn;
	}

	hasRole(role) {
		return this.getRoles().includes(role);
	}

	getAuthToken() {
		return this.user.token;
	}

	getRoles() {
		return this.user.tokenParsed.roles;
	}
}

export default KeycloakUser;
