import { createApp } from "vue";
import router from "./router.js";
import keycloak from "./auth/keycloak";
import App from "./App.vue";

import PrimeVue from "primevue/config";
import AutoComplete from "primevue/autocomplete";
import Calendar from "primevue/calendar";
import Paginator from "primevue/paginator";
import DataTable from "primevue/datatable";
import Column from "primevue/column";

import "bootstrap/dist/css/bootstrap.min.css";
import "jquery/src/jquery.js";
import "bootstrap/dist/js/bootstrap.min.js";

import "primevue/resources/themes/saga-blue/theme.css";
import "primevue/resources/primevue.min.css";
import "primeicons/primeicons.css";

(async () => {
	const app = createApp(App);
	app.use(PrimeVue);
	app.use(router);

	app.component("AutoComplete", AutoComplete);
	app.component("Calendar", Calendar);
	app.component("Paginator", Paginator);
	app.component("DataTable", DataTable);
	app.component("Column", Column);

	await keycloak.init();
	app.mount("#app");
})();
