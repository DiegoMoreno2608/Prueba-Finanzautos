FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["src/Asisya.Api/Asisya.Api.csproj", "src/Asisya.Api/"]
COPY ["src/Asisya.Application/Asisya.Application.csproj", "src/Asisya.Application/"]
COPY ["src/Asisya.Domain/Asisya.Domain.csproj", "src/Asisya.Domain/"]
COPY ["src/Asisya.Infrastructure/Asisya.Infrastructure.csproj", "src/Asisya.Infrastructure/"]
RUN dotnet restore "src/Asisya.Api/Asisya.Api.csproj"
COPY . .
WORKDIR "/src/src/Asisya.Api"
RUN dotnet build "Asisya.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Asisya.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Asisya.Api.dll"]
