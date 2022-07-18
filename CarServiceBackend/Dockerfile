FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8000
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS serverbuild
WORKDIR /src
COPY . .
WORKDIR /src/CarServiceBackend
RUN dotnet restore CarServiceBackend.csproj
RUN dotnet build CarServiceBackend.csproj -c Release -o /app/build

FROM serverbuild AS publish
RUN dotnet publish CarServiceBackend.csproj -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT dotnet CarServiceBackend.dll