# # Use the official .NET Core SDK image to build the app
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# EXPOSE 80

# # Use the official .NET SDK image to build the app
# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# WORKDIR /src
# COPY ["./employees-management.csproj", "EmployeeMicroservice/"]
# RUN dotnet restore "EmployeeMicroservice/employees-management.csproj"
# COPY . .
# WORKDIR "/src/EmployeeMicroservice"
# RUN dotnet build "employees-management.csproj" -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish "EmployeeMicroservice.csproj" -c Release -o /app/publish

# # Copy the build to the base image
# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "EmployeeMicroservice.dll"]
# -------------------------------------------------------------------------------
# Use an official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src/EmployeeMicroservice

# Copy all files to the container
COPY . .

# Restore any dependencies (via NuGet)
RUN dotnet restore "employees-management.csproj"

# Build the app
RUN dotnet build "employees-management.csproj" -c Release -o /app/build

# Publish the app
FROM build AS publish
RUN dotnet publish "employees-management.csproj" -c Release -o /app/publish

# Generate the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Copy the built app into the final image
COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "employees-management.dll"]

