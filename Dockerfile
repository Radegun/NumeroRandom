# -------- Etapa de build --------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia el proyecto y restaura dependencias
COPY *.csproj .
RUN dotnet restore

# Copia el resto del código y publica
COPY . .
RUN dotnet publish -c Release -o /app/publish /p:UseAppHost=false

# -------- Etapa de runtime --------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Kestrel escuchará en el puerto 8080 dentro del contenedor
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Copia el artefacto publicado
COPY --from=build /app/publish .

# Ejecuta la app
ENTRYPOINT ["dotnet", "RandomNumberApp.dll"]
