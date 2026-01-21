using DotNetWebApp.Data;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using DotNetWebApp.Services;
using Microsoft.AspNetCore.Components;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Radzen;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers();
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddRadzenComponents();
builder.Services.Configure<AppCustomizationOptions>(
    builder.Configuration.GetSection("AppCustomization"));
builder.Services.Configure<TenantSchemaOptions>(
    builder.Configuration.GetSection("TenantSchema"));
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped(sp =>
{
    var navigationManager = sp.GetRequiredService<NavigationManager>();
    var handler = new HttpClientHandler();
    if (builder.Environment.IsDevelopment())
    {
        // Accept self-signed certificates in development
        handler.ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true;
    }
    return new HttpClient(handler) { BaseAddress = new Uri(navigationManager.BaseUri) };
});
builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<IDashboardService, DashboardService>();
builder.Services.AddScoped<ISpaSectionService, SpaSectionService>();
builder.Services.AddScoped<ITenantSchemaAccessor, HeaderTenantSchemaAccessor>();
builder.Services.AddSingleton<IModelCacheKeyFactory, AppModelCacheKeyFactory>();
builder.Services.AddSingleton<IAppDictionaryService>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var yamlPath = Path.Combine(env.ContentRootPath, "app.example.yaml");
    return new AppDictionaryService(yamlPath);
});
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

var summaries = new[]
{
    "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
};

app.MapGet("/weatherforecast", () =>
{
    var forecast =  Enumerable.Range(1, 5).Select(index =>
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
app.MapControllers();
app.MapBlazorHub();
app.MapFallbackToPage("/_Host");
app.Run();

record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
{
    public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
}
