# -------- build --------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 1) Copia solo el csproj y restaura (aprovecha la caché)
COPY RandomNumberApp.csproj .
RUN dotnet restore RandomNumberApp.csproj

# 2) Copia el resto del código y publica
COPY . .
RUN dotnet publish RandomNumberApp.csproj -c Release -o /app/publish /p:UseAppHost=false

# -------- runtime --------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "RandomNumberApp.dll"]   # <-- que coincida con tu AssemblyName

