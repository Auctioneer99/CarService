# CarService
Тестовое задание на разработку ИС для СТО (станции технического обслуживания)

Веб клиент предоставляет отчеты на основании авторизированного пользователя
Десктоп клиент создан для роли Исполнителя, для учета заказов и транспортных средств

Технологии:
Vue.js
Postgres
Docker
ASP.NET
GraphQL
WinForms
Keycloak

Запуск:
[В корневой папке проекта]
docker compose build
docker compose up

Server: http://localhost:8000/
Admin Account: login: admin, password: admin

Keycloak: http://localhost:8100/
Admin: login: admin, password: admin
Executor: login executor{i} password: executor{i}, where 0 < {i} < 3
Customer: login customer{i} password: customer{i}, where 0 < {i} < 3

Client: http://localhost:8200/

PgAdmin: http://localhost:8300/
connectionHost: postgres
 
