using System;
using System.Linq;
using DotNetWebApp.Data;
using DotNetWebApp.Data.Dapper;
using DotNetWebApp.Data.Tenancy;
using DotNetWebApp.Models;
using DotNetWebApp.Models.Generated;
using DotNetWebApp.Services;
using DotNetWebApp.Services.ICT;
using DotNetWebApp.Services.Views;
using Microsoft.AspNetCore.Components;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Radzen;

var builder = WebApplication.CreateBuilder(args);

// Load appsettings.Local.json for local developer overrides (connection strings, etc.)
builder.Configuration.AddJsonFile("appsettings.Local.json", optional: true, reloadOnChange: true);

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
builder.Services.Configure<DataSeederOptions>(
    builder.Configuration.GetSection(DataSeederOptions.SectionName));
builder.Services.Configure<TenantSchemaOptions>(
    builder.Configuration.GetSection("TenantSchema"));
builder.Services.Configure<DatabaseMappingOptions>(
    builder.Configuration.GetSection(DatabaseMappingOptions.SectionName));
builder.Services.Configure<DotNetWebApp.Services.Models.AcuityImportOptions>(
    builder.Configuration.GetSection(DotNetWebApp.Services.Models.AcuityImportOptions.SectionName));
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
builder.Services.AddScoped<IDashboardService, DashboardService>();
builder.Services.AddScoped<ISpaSectionService, SpaSectionService>();
builder.Services.AddScoped<ITenantSchemaAccessor, HeaderTenantSchemaAccessor>();
builder.Services.AddSingleton<IModelCacheKeyFactory, AppModelCacheKeyFactory>();
builder.Services.AddSingleton<IAppDictionaryService>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var yamlPath = Path.Combine(env.ContentRootPath, "app.yaml");
    return new AppDictionaryService(yamlPath);
});
builder.Services.AddSingleton<IEntityMetadataService, EntityMetadataService>();
builder.Services.AddScoped<IEntityOperationService, EntityOperationService>();
builder.Services.AddScoped<IEntityApiService, EntityApiService>();

// Acuity Import services (Phase 2 - First application)
builder.Services.AddScoped<IDeacomService, DeacomService>();
builder.Services.AddScoped<IAcuityImportService, AcuityImportService>();

// ICT services (Phase 2 - Second application)
builder.Services.AddScoped<IICTOrderNumberService, ICTOrderNumberService>();
builder.Services.AddScoped<IICTService, ICTService>();

// PrePick services (Phase 2 - Third application)
builder.Services.AddScoped<DotNetWebApp.Services.PrePick.Validators.AuditorAssignmentValidator>();
builder.Services.AddScoped<DotNetWebApp.Services.PrePick.Validators.TimestampValidator>();
builder.Services.AddScoped<DotNetWebApp.Services.PrePick.ShipValidationService>();
builder.Services.AddScoped<DotNetWebApp.Services.PrePick.ColorCodingService>();
builder.Services.AddScoped<DotNetWebApp.Services.PrePick.IPrePickService, DotNetWebApp.Services.PrePick.PrePickService>();

// Allocation services (Phase 2 - Fourth application)
builder.Services.AddScoped<DotNetWebApp.Services.Allocation.Validators.PaymentValidator>();
builder.Services.AddScoped<DotNetWebApp.Services.Allocation.Validators.ShelfLifeValidator>();
builder.Services.AddScoped<DotNetWebApp.Services.Allocation.ILockService, DotNetWebApp.Services.Allocation.LockService>();
builder.Services.AddScoped<DotNetWebApp.Services.Allocation.IFIFOAllocationEngine, DotNetWebApp.Services.Allocation.FIFOAllocationEngine>();
builder.Services.AddScoped<DotNetWebApp.Services.Allocation.IAllocationService, DotNetWebApp.Services.Allocation.AllocationService>();

// DMS (Dock Management System) services (Phase 2 - Fifth application)
builder.Services.AddScoped<DotNetWebApp.Services.DMS.Validators.StatusTransitionValidator>();
builder.Services.AddScoped<DotNetWebApp.Services.DMS.Validators.DeleteValidator>();
builder.Services.AddScoped<DotNetWebApp.Services.DMS.IDMSService, DotNetWebApp.Services.DMS.DMSService>();

// Database connections - PrimaryDatabase and SecondaryDatabase
// Note: PrimaryDatabase and SecondaryDatabase are defined in appsettings.Local.json (not in base appsettings.json)
// If they're empty or missing, fall back to DefaultConnection
var primaryConnectionString =
    (!string.IsNullOrWhiteSpace(builder.Configuration.GetConnectionString("PrimaryDatabase"))
        ? builder.Configuration.GetConnectionString("PrimaryDatabase")
        : null)
    ?? builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("No database connection string configured");

var secondaryConnectionString =
    (!string.IsNullOrWhiteSpace(builder.Configuration.GetConnectionString("SecondaryDatabase"))
        ? builder.Configuration.GetConnectionString("SecondaryDatabase")
        : null)
    ?? primaryConnectionString;

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(primaryConnectionString));
builder.Services.AddDbContext<SecondaryDbContext>(options =>
    options.UseSqlServer(secondaryConnectionString));

// DbContext resolver routes entities to correct database based on namespace
builder.Services.AddScoped<IDbContextResolver, DbContextResolver>();
builder.Services.AddScoped<DbContext>(sp => sp.GetRequiredService<AppDbContext>());
builder.Services.AddScoped<DataSeeder>();

// Dapper infrastructure (read-only, shares EF connection)
// Primary database (GAI) - for queries to dmprod, dtfifo, dtjob, etc.
builder.Services.AddKeyedScoped<IDapperQueryService, DapperQueryService>("Primary");
builder.Services.AddKeyedScoped<IDapperQueryService>(
    "Secondary",
    (sp, key) => new SecondaryDapperQueryService(
        sp.GetRequiredService<SecondaryDbContext>(),
        sp.GetRequiredService<ILogger<SecondaryDapperQueryService>>()));

// Default (non-keyed) registration uses Primary for backwards compatibility
builder.Services.AddScoped<IDapperQueryService, DapperQueryService>();

// View registry (singleton, loaded once at startup from app.yaml)
builder.Services.AddSingleton<IViewRegistry>(sp =>
{
    var env = sp.GetRequiredService<IHostEnvironment>();
    var logger = sp.GetRequiredService<ILogger<ViewRegistry>>();
    var appDictionary = sp.GetRequiredService<IAppDictionaryService>();
    return new ViewRegistry(logger, appDictionary, env.ContentRootPath);
});

// View service (scoped, executes views)
builder.Services.AddScoped<IViewService, ViewService>();

var seedMode = args.Any(arg => string.Equals(arg, "--seed", StringComparison.OrdinalIgnoreCase));
var app = builder.Build();

if (seedMode)
{
    using var scope = app.Services.CreateScope();
    var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    await dbContext.Database.MigrateAsync();
    await scope.ServiceProvider.GetRequiredService<DataSeeder>().SeedAsync();
    return;
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.MapControllers();
app.MapBlazorHub();
app.MapFallbackToPage("/_Host");
app.Run();
