var host = `http://localhost:${process.env.VUE_APP_SERVER_PORT}`;
export default {
	host: host,
	hostApi: host + "/api",
};
