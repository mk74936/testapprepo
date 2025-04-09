# Use the official Microsoft .NET Core SDK image to build the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["testapp.csproj", "./"]
RUN dotnet restore "testapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "testapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "testapp.csproj" -c Release -o /app/publish

# Copy the build artifacts from the previous stage
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "testapp.dll"]