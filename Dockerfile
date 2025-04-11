# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Install netcat (used in wait-for.sh)
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/publish ./
COPY wait-for.sh /wait-for.sh
RUN chmod +x /wait-for.sh

# Run the app after DB is ready
# CMD ["./wait-for.sh", "postgres:5432", "--", "dotnet", "employees-management.dll"] # Working **
CMD ["/wait-for.sh", "postgres", "5432", "--", "dotnet", "employees-management.dll"]