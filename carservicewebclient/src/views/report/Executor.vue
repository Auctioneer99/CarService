<template>
	<div class="d-flex flex-column h-100">
		<div class="w-100 d-flex justify-content-center flex-row">
			<h1>Отчет по исполнителю</h1>
		</div>
		<div class="form-group">
			<form class="mb-5 ml-0 row w-100" v-on:submit="onSearch">
				<div class="form-group col-3 m-0">
					<label for="dateFrom">От:</label><br />
					<Calendar v-model="form.dateFrom" />
				</div>
				<div class="form-group col-3 m-0">
					<label for="dateTo">До:</label><br />
					<Calendar v-model="form.dateTo" />
				</div>
				<div class="form-group col-3 m-0">
					<label class="form-check-label" for="executor">Имя исполнителя:</label
					><br />
					<AutoComplete
						id="executor"
						forceSelection
						v-model="form.executor"
						:suggestions="form.filteredExecutors"
						@complete="searchExecutorTyped($event)"
						field="name"
						placeholder="Иван Иванов"
					/>
				</div>
				<div class="col-3 m-0 d-flex flex-column justify-content-end">
					<button type="submit" class="btn btn-primary ml-auto mr-auto">
						Поиск
					</button>
				</div>
			</form>
		</div>
		<template v-if="!paged"> Начните поиск! </template>
		<template v-else>
			<div class="d-flex flex-column justify-content-between h-100">
				<template v-if="loadingData">
					<div class="mb-auto">Загрузка...</div>
				</template>
				<template v-else>
					<DataTable
						:value="paged.items"
						responsiveLayout="scroll"
						class="mb-auto"
					>
						<Column field="transport.number" header="Код"></Column>
						<Column field="price" header="Цена"></Column>
						<Column field="mileage" header="Пробег"></Column>
						<Column field="task" header="Услуга"></Column>
						<Column header="Дата проведеня">
							<template #body="slotProps">
								{{
									new Date(slotProps.data.performDate).toLocaleDateString(
										"ru-RU",
										this.dateOptions
									)
								}}
							</template>
						</Column>
						<Column header="Дата возврата">
							<template #body="slotProps">
								{{
									slotProps.data.returnDate ?
									new Date(slotProps.data.returnDate).toLocaleDateString(
										"ru-RU",
										this.dateOptions
									) : "На обслуживании"
								}}
							</template>
						</Column>
					</DataTable>
				</template>
				<div>
					Суммарная стоимость: {{ this.report.price }}<br />
					Количество записей: {{ this.report.count }}
				</div>
				<Paginator
					:rows="defaultPageSize"
					:totalRecords="paged.totalCount"
					@page="onPageChange($event)"
				></Paginator>
			</div>
		</template>
	</div>
</template>

<script>
import graphQL from "../../api/graphQL";

export default {
	data() {
		return {
			defaultPageSize: 6,
			report: {
				price: 0,
				count: 0,
			},
			dateOptions: {
				year: "numeric",
				month: "short",
				day: "numeric",
				hour: "numeric",
				minute: "numeric",
			},
			loadingData: true,
			paged: null,
			lastSearchedScheme: null,
			form: {
				executor: null,
				filteredExecutors: null,
				dateFrom: new Date(),
				dateTo: new Date(),
			},
		};
	},
	methods: {
		searchExecutorTyped(event) {
			if (!this.form.executor || this.form.executor == "") {
				return;
			}
			var queryExecutors = `query{users(first:20 name:\"${this.form.executor}\" where:{role:{eq:\"executor\"}}){nodes{id name}}}`;
			graphQL
				.get(queryExecutors)
				.then((response) => {
					this.form.filteredExecutors = response.data.data.users.nodes;
				})
				.catch((error) => {
					this.form.filteredExecutors = [];
					console.log(error);
				});
		},
		onSearch(event) {
			event.preventDefault();
			if (!this.form.executor) {
				return;
			}
			this.lastSearchedScheme = {
				executor: {
					id: this.form.executor.id,
				},
				dateFrom: this.form.dateFrom,
				dateTo: this.form.dateTo,
			};

			var queryReport = `query{workReportForExecutor(dateFrom:\"${this.form.dateFrom.toLocaleDateString(
				"en-US"
			)}\" dateTo:\"${this.form.dateTo.toLocaleDateString("en-US")}\" id:\"${
				this.form.executor.id
			}\"){price count}}`;
			graphQL
				.get(queryReport)
				.then((response) => {
					this.report = response.data.data.workReportForExecutor ?? {
						price: 0,
						count: 0,
					};
				})
				.catch((error) => {
					this.paged = null;
					console.log(error);
				});
			this.updateData(this.form, 0);
		},
		onPageChange(event) {
			this.updateData(this.lastSearchedScheme, event.page);
		},
		updateData(searchScheme, page) {
			this.loadingData = true;

			var skip = page * this.defaultPageSize;
			var queryWorks = `query{works(take:${
				this.defaultPageSize
			},skip:${skip},where:{performDate:{gte:\"${searchScheme.dateFrom.toLocaleDateString(
				"en-US"
			)}\"lte:\"${searchScheme.dateTo.toLocaleDateString(
				"en-US"
			)}\"},executorId:{eq:\"${
				searchScheme.executor.id
			}\"}}){totalCount items{id performDate returnDate price mileage task transport{id number}}}}`;
			graphQL
				.get(queryWorks)
				.then((response) => {
					this.paged = response.data.data.works;
				})
				.catch((error) => {
					this.paged = null;
					console.log(error);
				})
				.finally(() => {
					this.loadingData = false;
				});
		},
	},
};
</script>
