import axios from "axios";
import keycloak from "../auth/keycloak.js";

export default {
	get(query, args) {
		//console.log(query)
		return axios({
			url: window.location.origin + "/api",
			method: "post",
			data: {
				operationName: null,
				variables: {
					...args,
				},
				query: query,
			},
			headers: {
				Authorization: "Bearer " + keycloak.getUser().getAuthToken(),
			},
		});
		//.then(response => { console.log(response.data); return response;});
	},
};
