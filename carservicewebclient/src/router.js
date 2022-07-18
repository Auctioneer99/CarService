import { createWebHistory, createRouter } from "vue-router";

var routes = [
	{
		path: "/",
		name: "home",
		component: () => import("./views/Home.vue"),
	},
	{
		path: "/profile",
		name: "profile",
		component: () => import("./views/Profile.vue"),
	},
	{
		path: "/report/transport",
		name: "transportReport",
		component: () => import("./views/report/Transport.vue"),
	},
	{
		path: "/report/work",
		name: "workReport",
		component: () => import("./views/report/Work.vue"),
	},
	{
		path: "/report/customer",
		name: "customerReport",
		component: () => import("./views/report/Customer.vue"),
	},
	{
		path: "/report/executor",
		name: "executorReport",
		component: () => import("./views/report/Executor.vue"),
	},
];

const router = createRouter({
	history: createWebHistory(process.env.BASE_URL),
	routes,
});

export default router;
