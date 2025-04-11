
using Npgsql;
using Microsoft.EntityFrameworkCore;
using employees_management.Data;

var builder = WebApplication.CreateBuilder(args);

var port = Environment.GetEnvironmentVariable("PORT") ?? "5001";
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenAnyIP(Int32.Parse(port));
});

// Convert DATABASE_URL to a PostgreSQL connection string

var rawUrl = Environment.GetEnvironmentVariable("RAILWAY_DATABASE_URL");

if (string.IsNullOrEmpty(rawUrl))
{
    // fallback to a local PostgreSQL connection
    rawUrl = "postgres://postgres:postgres@postgres:5432/employees_db";
}

// Convert URL to standard connection string
var uri = new Uri(rawUrl);
var userInfo = uri.UserInfo.Split(':');

var useSsl = !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("RAILWAY_DATABASE_URL"));

#pragma warning disable CS0618 // Type or member is obsolete
var b = new NpgsqlConnectionStringBuilder
{
    Host = uri.Host,
    Port = uri.Port,
    Username = userInfo[0],
    Password = userInfo[1],
    Database = uri.AbsolutePath.TrimStart('/'),
    SslMode = useSsl ? SslMode.Require : SslMode.Disable,
    TrustServerCertificate = useSsl
};
#pragma warning restore CS0618 // Type or member is obsolete

builder.Services.AddDbContext<EmployeesManagementDbContext>(options =>
    options.UseNpgsql(b.ConnectionString));

builder.Services.AddControllers();

// builder.WebHost.UseUrls("http://0.0.0.0:80");

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<EmployeesManagementDbContext>();
    db.Database.Migrate();
}

// Map controllers
app.MapControllers();

// This should come BEFORE `app.Run()`
var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast = Enumerable.Range(1, 5).Select(index =>
        new WeatherForecast
        (
            DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
            Random.Shared.Next(-20, 55),
            summaries[Random.Shared.Next(summaries.Length)]
        ))
        .ToArray();
    return forecast;
})
.WithName("GetWeatherForecast")
.WithOpenApi();

app.Run(); // ✅ Always at the end

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}

