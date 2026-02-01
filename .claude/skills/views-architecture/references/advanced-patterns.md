# Advanced Patterns: Caching, Testing, Performance

Advanced techniques and patterns for sophisticated view usage.

---

## Caching View Results

Views are read-only aggregations perfect for caching. Implement caching where freshness requirements allow.

### Basic IMemoryCache Pattern

```csharp
@inject IViewService ViewService
@inject IMemoryCache MemoryCache
@inject ILogger<ProductDashboard> Logger

protected override async Task OnInitializedAsync()
{
    const string cacheKey = "ProductSalesView_Top50";

    if (!MemoryCache.TryGetValue(cacheKey, out IEnumerable<ProductSalesView> products))
    {
        try
        {
            products = await ViewService.ExecuteViewAsync<ProductSalesView>(
                "ProductSalesView",
                new { TopN = 50 });

            // Cache for 5 minutes
            var cacheOptions = new MemoryCacheEntryOptions()
                .SetAbsoluteExpiration(TimeSpan.FromMinutes(5));

            MemoryCache.Set(cacheKey, products, cacheOptions);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, "Error loading ProductSalesView");
        }
    }
}
```

### Cache Key Strategy

Use a hash of parameters in the key:

```csharp
public static string GetCacheKey<T>(string viewName, object? parameters)
{
    if (parameters == null)
        return $"View_{viewName}";

    var paramHash = parameters.GetHashCode();
    return $"View_{viewName}_{paramHash}";
}

// Usage
var cacheKey = GetCacheKey<ProductSalesView>("ProductSalesView", new { TopN = 50 });
```

### Cache Invalidation

Implement refresh mechanism:

```csharp
public interface IViewCacheService
{
    Task<IEnumerable<T>> GetCachedViewAsync<T>(
        string viewName,
        object? parameters = null,
        TimeSpan? cacheDuration = null);

    void InvalidateView(string viewName);

    void InvalidateAllViews();
}

public class ViewCacheService : IViewCacheService
{
    private readonly IViewService _viewService;
    private readonly IMemoryCache _cache;
    private readonly ILogger<ViewCacheService> _logger;

    public async Task<IEnumerable<T>> GetCachedViewAsync<T>(
        string viewName,
        object? parameters = null,
        TimeSpan? cacheDuration = null)
    {
        var cacheKey = GetCacheKey<T>(viewName, parameters);

        if (!_cache.TryGetValue(cacheKey, out IEnumerable<T> results))
        {
            results = await _viewService.ExecuteViewAsync<T>(viewName, parameters);

            var options = new MemoryCacheEntryOptions()
                .SetAbsoluteExpiration(cacheDuration ?? TimeSpan.FromMinutes(5));

            _cache.Set(cacheKey, results, options);
            _logger.LogInformation("Cached view {ViewName}", viewName);
        }

        return results;
    }

    public void InvalidateView(string viewName)
    {
        var cacheKey = $"View_{viewName}";
        _cache.Remove(cacheKey);
        _logger.LogInformation("Invalidated cache for {ViewName}", viewName);
    }

    public void InvalidateAllViews()
    {
        // Note: IMemoryCache doesn't provide enumeration API
        // Implement your own cache key registry for bulk invalidation
    }
}
```

### DI Registration

```csharp
builder.Services.AddScoped<IViewCacheService, ViewCacheService>();
```

---

## Extending IViewService for Custom Scenarios

Views often need to be part of larger workflows. Extend or wrap IViewService to add business logic without creating controllers.

### Pattern 1: Publishing to Message Queues

After executing a view, publish results to a message queue for downstream processing.

```csharp
public interface IEventPublishingViewService
{
    Task<IEnumerable<T>> ExecuteAndPublishAsync<T>(
        string viewName,
        object? parameters = null,
        string eventTopic = null);
}

public class EventPublishingViewService : IEventPublishingViewService
{
    private readonly IViewService _viewService;
    private readonly IMessageQueue _queue;
    private readonly ILogger<EventPublishingViewService> _logger;

    public async Task<IEnumerable<T>> ExecuteAndPublishAsync<T>(
        string viewName,
        object? parameters = null,
        string eventTopic = null)
    {
        var results = await _viewService.ExecuteViewAsync<T>(viewName, parameters);

        if (eventTopic != null && results?.Any() == true)
        {
            var @event = new ViewExecutedEvent
            {
                ViewName = viewName,
                ResultCount = results.Count(),
                ExecutedAt = DateTime.UtcNow,
                Parameters = parameters?.ToString()
            };

            await _queue.PublishAsync(eventTopic, @event);
            _logger.LogInformation(
                "[{EventId}] Published {Count} results from {ViewName} to {Topic}",
                @event.Id, results.Count(), viewName, eventTopic);
        }

        return results;
    }
}
```

**DI Registration:**
```csharp
builder.Services.AddScoped<IEventPublishingViewService, EventPublishingViewService>();
```

**Usage in Blazor Component:**
```csharp
@inject IEventPublishingViewService EventPublishingViewService

protected override async Task OnInitializedAsync()
{
    results = await EventPublishingViewService.ExecuteAndPublishAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 50 },
        eventTopic: "product-sales-analysis");
}
```

---

### Pattern 2: Enriching View Results with External API Data

Execute a view, then enrich results with data from third-party APIs.

```csharp
public interface IEnrichedViewService
{
    Task<IEnumerable<TEnriched>> ExecuteAndEnrichAsync<T, TEnriched>(
        string viewName,
        Func<T, Task<TEnriched>> enrichmentFunction,
        object? parameters = null)
        where TEnriched : class;
}

public class EnrichedViewService : IEnrichedViewService
{
    private readonly IViewService _viewService;
    private readonly ILogger<EnrichedViewService> _logger;

    public async Task<IEnumerable<TEnriched>> ExecuteAndEnrichAsync<T, TEnriched>(
        string viewName,
        Func<T, Task<TEnriched>> enrichmentFunction,
        object? parameters = null)
        where TEnriched : class
    {
        var results = await _viewService.ExecuteViewAsync<T>(viewName, parameters);

        var enrichedResults = new List<TEnriched>();

        foreach (var result in results)
        {
            try
            {
                var enriched = await enrichmentFunction(result);
                enrichedResults.Add(enriched);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to enrich result from {ViewName}", viewName);
                // Continue with other results or rethrow based on requirements
            }
        }

        return enrichedResults;
    }
}
```

**Usage Example: Enrich ProductSalesView with pricing data from external API:**

```csharp
@inject IEnrichedViewService EnrichedViewService
@inject IExternalPricingService PricingService

private record ProductSalesEnriched(
    int Id,
    string Name,
    decimal Price,
    int TotalSold,
    decimal? ExternalMarketPrice,
    decimal? PriceGap);

protected override async Task OnInitializedAsync()
{
    enrichedProducts = await EnrichedViewService.ExecuteAndEnrichAsync<ProductSalesView, ProductSalesEnriched>(
        "ProductSalesView",
        async product =>
        {
            var externalPrice = await PricingService.GetMarketPriceAsync(product.Name);
            return new ProductSalesEnriched(
                product.Id,
                product.Name,
                product.Price,
                product.TotalSold,
                externalPrice,
                externalPrice - product.Price);
        },
        new { TopN = 50 });
}
```

---

### Pattern 3: Auditing and Logging View Execution

Automatically log who executed which views and when, without cluttering business logic.

```csharp
public interface IAuditedViewService
{
    Task<IEnumerable<T>> ExecuteWithAuditAsync<T>(
        string viewName,
        object? parameters = null);
}

public class AuditedViewService : IAuditedViewService
{
    private readonly IViewService _viewService;
    private readonly IAuditLog _auditLog;
    private readonly IHttpContextAccessor _httpContext;
    private readonly ILogger<AuditedViewService> _logger;

    public async Task<IEnumerable<T>> ExecuteWithAuditAsync<T>(
        string viewName,
        object? parameters = null)
    {
        var startTime = DateTime.UtcNow;
        var userId = _httpContext.HttpContext?.User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "Anonymous";

        try
        {
            var results = await _viewService.ExecuteViewAsync<T>(viewName, parameters);

            var duration = DateTime.UtcNow - startTime;

            // Log successful execution
            await _auditLog.LogAsync(new AuditEntry
            {
                UserId = userId,
                Action = "ViewExecuted",
                Resource = viewName,
                Result = "Success",
                ResultCount = results.Count(),
                DurationMs = (long)duration.TotalMilliseconds,
                Timestamp = startTime
            });

            _logger.LogInformation(
                "User {UserId} executed view {ViewName} in {DurationMs}ms, returned {ResultCount} rows",
                userId, viewName, duration.TotalMilliseconds, results.Count());

            return results;
        }
        catch (Exception ex)
        {
            var duration = DateTime.UtcNow - startTime;

            // Log failed execution
            await _auditLog.LogAsync(new AuditEntry
            {
                UserId = userId,
                Action = "ViewExecuted",
                Resource = viewName,
                Result = "Failed",
                ErrorMessage = ex.Message,
                DurationMs = (long)duration.TotalMilliseconds,
                Timestamp = startTime
            });

            _logger.LogError(ex, "[AUDIT] User {UserId} failed executing view {ViewName}", userId, viewName);
            throw;
        }
    }
}
```

**DI Registration:**
```csharp
builder.Services.AddScoped<IAuditedViewService, AuditedViewService>();
builder.Services.AddScoped<IAuditLog, DatabaseAuditLog>();
```

**Usage:**
```csharp
@inject IAuditedViewService AuditedViewService

protected override async Task OnInitializedAsync()
{
    // Automatically logged to audit table
    results = await AuditedViewService.ExecuteWithAuditAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 50 });
}
```

---

### Pattern 4: Multi-Step View Orchestration

Coordinate multiple views and aggregate results into a single dashboard.

```csharp
public interface IViewOrchestrationService
{
    Task<DashboardViewModel> LoadDashboardAsync(string dashboardName);
}

public class ViewOrchestrationService : IViewOrchestrationService
{
    private readonly IViewService _viewService;
    private readonly ILogger<ViewOrchestrationService> _logger;

    public async Task<DashboardViewModel> LoadDashboardAsync(string dashboardName)
    {
        if (dashboardName != "sales-dashboard")
            throw new ArgumentException("Unknown dashboard");

        _logger.LogInformation("Loading sales dashboard");

        // Execute multiple views in parallel
        var topProductsTask = _viewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = 10 });

        var monthlySalesTask = _viewService.ExecuteViewAsync<MonthlySalesView>(
            "MonthlySalesView",
            new { Months = 12 });

        var categoryBreakdownTask = _viewService.ExecuteViewAsync<CategoryBreakdownView>(
            "CategoryBreakdownView");

        await Task.WhenAll(topProductsTask, monthlySalesTask, categoryBreakdownTask);

        // Aggregate into single view model
        return new DashboardViewModel
        {
            TopProducts = topProductsTask.Result.ToList(),
            MonthlySales = monthlySalesTask.Result.ToList(),
            CategoryBreakdown = categoryBreakdownTask.Result.ToList(),
            LoadedAt = DateTime.UtcNow
        };
    }
}

public class DashboardViewModel
{
    public List<ProductSalesView> TopProducts { get; set; }
    public List<MonthlySalesView> MonthlySales { get; set; }
    public List<CategoryBreakdownView> CategoryBreakdown { get; set; }
    public DateTime LoadedAt { get; set; }
}
```

**Usage:**
```csharp
@inject IViewOrchestrationService Orchestration

private DashboardViewModel dashboard;

protected override async Task OnInitializedAsync()
{
    dashboard = await Orchestration.LoadDashboardAsync("sales-dashboard");
}
```

---

### Summary: When to Create Custom View Services

| Scenario | Service to Create | Purpose |
|----------|-------------------|---------|
| **Caching with complex invalidation** | IViewCacheService | Manage cache lifecycle |
| **Publishing results to queues** | IEventPublishingViewService | Event-driven workflows |
| **Enriching with external data** | IEnrichedViewService | Third-party API integration |
| **Audit trail required** | IAuditedViewService | Compliance and monitoring |
| **Complex orchestration** | IViewOrchestrationService | Multi-view dashboards |
| **Custom transformations** | Custom wrapper | Business-specific formatting |

**Key principle:** Wrap IViewService, don't replace it. Each wrapper adds one responsibility.

---

## Testing View Execution

### Unit Testing with Mocks

```csharp
[Fact]
public async Task ViewSection_ExecuteView_DisplaysResults()
{
    // Arrange
    var mockViewService = new Mock<IViewService>();
    mockViewService.Setup(vs => vs.ExecuteViewAsync<ProductSalesView>(
        It.IsAny<string>(),
        It.IsAny<object>()))
        .ReturnsAsync(new[]
        {
            new ProductSalesView { Id = 1, Name = "Product1", Price = 10m },
            new ProductSalesView { Id = 2, Name = "Product2", Price = 20m }
        });

    var component = new ProductDashboard { ViewService = mockViewService.Object };

    // Act
    await component.OnInitializedAsync();

    // Assert
    Assert.NotNull(component.Products);
    Assert.Equal(2, component.Products.Count());
}
```

### Integration Testing with Real Database

```csharp
[Fact]
public async Task ProductSalesView_WithRealDatabase_ReturnsResults()
{
    // Arrange
    var options = new DbContextOptionsBuilder<AppDbContext>()
        .UseSqlServer(_testDatabaseConnectionString)
        .Options;

    using var dbContext = new AppDbContext(options);
    var dapper = new DapperQueryService(dbContext);
    var appDictionary = new AppDictionaryService(_appYamlPath);
    var registry = new ViewRegistry(_logger, appDictionary, _contentRoot);
    var viewService = new ViewService(registry, dapper);

    // Act
    var results = await viewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = 10 });

    // Assert
    Assert.NotNull(results);
    Assert.True(results.Count() <= 10);
}
```

### Testing View Parameters

```csharp
[Theory]
[InlineData(5)]
[InlineData(50)]
[InlineData(100)]
public async Task ProductSalesView_WithVariousTopN_ReturnsAtMostTopN(int topN)
{
    // Arrange
    var results = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        new { TopN = topN });

    // Assert
    Assert.True(results.Count() <= topN);
}

[Fact]
public async Task ProductSalesView_WithInvalidTopN_ThrowsArgumentException()
{
    // Arrange
    int invalidTopN = -1;

    // Act & Assert
    await Assert.ThrowsAsync<ArgumentException>(() =>
        ViewService.ExecuteViewAsync<ProductSalesView>(
            "ProductSalesView",
            new { TopN = invalidTopN }));
}
```

---

## Dynamic Pagination

Implement OFFSET/FETCH pagination for large result sets.

### SQL with Pagination

```sql
-- ProductSalesView_Paginated.sql
-- Parameters: @TopN, @PageSize, @PageNumber

SELECT
    p.Id,
    p.Name,
    p.Price
FROM acme.Products p
ORDER BY p.Id
OFFSET (@PageNumber - 1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY;

-- Also needed: Total count for pagination UI
SELECT COUNT(*) AS TotalCount FROM acme.Products;
```

### Pagination Parameters

```json
{
  "Name": "ProductSalesViewPaginated",
  "SqlFile": "sql/views/ProductSalesView_Paginated.sql",
  "Parameters": [
    {
      "Name": "PageSize",
      "Type": "int",
      "Default": "20",
      "Validation": { "Range": [1, 100] }
    },
    {
      "Name": "PageNumber",
      "Type": "int",
      "Default": "1",
      "Validation": { "Range": [1, 999999] }
    }
  ]
}
```

### Pagination Component

```csharp
private int currentPage = 1;
private int pageSize = 20;
private int totalCount = 0;
private IEnumerable<ProductSalesView> results;

protected override async Task OnInitializedAsync()
{
    await LoadPage(1);
}

private async Task LoadPage(int pageNumber)
{
    results = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesViewPaginated",
        new { PageSize = pageSize, PageNumber = pageNumber });

    currentPage = pageNumber;
    StateHasChanged();
}

private int TotalPages => (int)Math.Ceiling(totalCount / (double)pageSize);
```

---

## Custom View Model Extensions

Add business logic to generated view models using partial classes.

### Example: Extended ProductSalesView

**Generated File:** `ProductSalesView.generated.cs` (never edit)

```csharp
public partial class ProductSalesView
{
    public int Id { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
    public int TotalSold { get; set; }
    public decimal TotalRevenue { get; set; }
}
```

**User File:** `ProductSalesView.cs` (your custom code, never overwritten)

```csharp
namespace DotNetWebApp.Models.ViewModels
{
    public partial class ProductSalesView
    {
        /// Calculate profit margin
        [DisplayName("Margin %")]
        public decimal MarginPercent => (Price * 0.20m) / Price * 100;

        /// Get product category emoji
        public string CategoryEmoji => Name switch
        {
            "Electronics" => "⚡",
            "Books" => "📚",
            "Clothing" => "👕",
            _ => "📦"
        };

        /// Format revenue for display
        public string FormattedRevenue => TotalRevenue.ToString("C2");

        /// Check if product is a bestseller (> 100 units sold)
        public bool IsBestseller => TotalSold > 100;
    }
}
```

### Usage in Component

```razor
<RadzenDataGridColumn TItem="ProductSalesView" Property="Name" Title="Product">
    <Template Context="item">
        @item.CategoryEmoji @item.Name
    </Template>
</RadzenDataGridColumn>

<RadzenDataGridColumn TItem="ProductSalesView" Property="MarginPercent" Title="Margin %">
    <Template Context="item">
        @if (item.IsBestseller)
        {
            <RadzenBadge Text="⭐ " BadgeStyle="@BadgeStyle.Success" />
        }
        @item.MarginPercent.ToString("F2")%
    </Template>
</RadzenDataGridColumn>

<RadzenDataGridColumn TItem="ProductSalesView" Property="TotalRevenue" Title="Revenue">
    <Template Context="item">
        @item.FormattedRevenue
    </Template>
</RadzenDataGridColumn>
```

---

## Performance Optimization Checklist

### SQL Optimization

- [ ] Query executes < 500ms in SSMS (benchmark first)
- [ ] All JOINed columns have indexes: `CREATE INDEX idx_categoryid ON Products(CategoryId)`
- [ ] No SELECT * in views (list only needed columns)
- [ ] WHERE conditions filter before JOINs
- [ ] Aggregations (GROUP BY) use indexed columns
- [ ] No subqueries that could be JOINs
- [ ] Test execution plan in SSMS for full table scans

### C# Optimization

- [ ] View results are materialized only when needed (avoid ToList() until display)
- [ ] Caching is implemented for frequently-accessed views
- [ ] Pagination is used for large result sets (avoid loading 100K rows)
- [ ] ILogger is configured for production (Debug level disabled)

### Monitoring

- [ ] SQL query execution time is logged
- [ ] Slow queries (>1s) are tracked and optimized
- [ ] Cache hit rates are monitored
- [ ] Application insights or similar tracks view execution

---

## Streaming Large Result Sets

For large views, use `IAsyncEnumerable<T>` to avoid loading all rows in memory.

### Streaming View Component

```csharp
public async IAsyncEnumerable<ProductSalesView> StreamViewAsync(
    string viewName,
    object? parameters = null)
{
    var sql = await _viewRegistry.GetViewSqlAsync(viewName);
    var connection = _dbContext.Database.GetDbConnection();

    using (var reader = await connection.ExecuteReaderAsync(sql, parameters))
    {
        var parser = new Dapper.RowParser<ProductSalesView>(reader);

        while (await reader.NextResultAsync())
        {
            while (reader.Read())
            {
                yield return parser(reader);
            }
        }
    }
}
```

### Usage

```csharp
// Process results one at a time, never more than one in memory
await foreach (var product in StreamViewAsync("ProductSalesView"))
{
    // Process individual item
    ProcessProduct(product);
}
```

---

## FluentValidation for View Parameters

Add comprehensive parameter validation before view execution.

### Parameter Validator

```csharp
public class ProductSalesViewParametersValidator : AbstractValidator<ProductSalesViewParameters>
{
    public ProductSalesViewParametersValidator()
    {
        RuleFor(p => p.TopN)
            .InclusiveBetween(1, 1000)
            .WithMessage("TopN must be between 1 and 1000");

        RuleFor(p => p.CategoryId)
            .GreaterThan(0)
            .When(p => p.CategoryId.HasValue)
            .WithMessage("CategoryId must be positive");
    }
}
```

### DI Registration

```csharp
builder.Services.AddValidatorsFromAssemblyContaining<ProductSalesViewParametersValidator>();
```

### Usage in Component

```csharp
private async Task ExecuteViewWithValidation()
{
    var parameters = new ProductSalesViewParameters { TopN = userInput };
    var validator = new ProductSalesViewParametersValidator();
    var result = validator.Validate(parameters);

    if (!result.IsValid)
    {
        foreach (var error in result.Errors)
            Logger.LogWarning("Validation error: {Error}", error.ErrorMessage);
        return;
    }

    results = await ViewService.ExecuteViewAsync<ProductSalesView>(
        "ProductSalesView",
        parameters);
}
```

---

## Multi-Tenant View Considerations

Views automatically inherit tenant schema from EF Core connection. For multi-schema views:

### Schema-Explicit SQL (if needed)

```sql
-- ProductSalesView.sql
-- Works for any schema tenant

SELECT TOP (@TopN)
    p.Id,
    p.Name,
    SUM(od.Quantity) AS TotalSold
FROM Products p
LEFT JOIN OrderDetails od ON p.Id = od.ProductId
GROUP BY p.Id, p.Name
ORDER BY TotalSold DESC;

-- Dapper automatically uses tenant's schema
-- No schema prefix needed
```

### Testing Multi-Tenant Views

```csharp
[Fact]
public async Task ProductSalesView_AcmeTenant_ReturnsAcmeProducts()
{
    // Arrange - switch to ACME tenant
    _tenantService.SetCurrentTenant("acme");
    var results = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");

    // Assert
    Assert.All(results, product => Assert.Contains("acme_", product.Name));
}

[Fact]
public async Task ProductSalesView_InitechTenant_ReturnsInitechProducts()
{
    // Arrange - switch to INITECH tenant
    _tenantService.SetCurrentTenant("initech");
    var results = await ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView");

    // Assert
    Assert.All(results, product => Assert.Contains("initech_", product.Name));
}
```

---

## Custom Error Handling Strategy

Implement domain-specific error handling for views.

```csharp
public class ViewExceptionHandler
{
    private readonly ILogger _logger;

    public async Task<TResult> ExecuteWithHandlingAsync<TResult>(
        Func<Task<TResult>> action,
        string viewName)
    {
        try
        {
            return await action();
        }
        catch (InvalidOperationException ex) when (ex.Message.Contains("VIEW_NOT_FOUND"))
        {
            _logger.LogError(ex, "View {ViewName} not found", viewName);
            throw new DomainException($"The requested view '{viewName}' is not available.");
        }
        catch (SqlException ex) when (ex.Number == 1205)  // Deadlock
        {
            _logger.LogWarning(ex, "Deadlock executing {ViewName}, retrying", viewName);
            // Retry logic here
            return await action();
        }
        catch (OperationCanceledException ex)
        {
            _logger.LogError(ex, "View {ViewName} timeout", viewName);
            throw new DomainException($"The view '{viewName}' is taking too long. Please try again.");
        }
    }
}
```

### Usage

```csharp
var handler = new ViewExceptionHandler(logger);
var results = await handler.ExecuteWithHandlingAsync(
    () => ViewService.ExecuteViewAsync<ProductSalesView>("ProductSalesView"),
    "ProductSalesView");
```

---

## Summary: When to Use Each Pattern

| Pattern | When | Benefit |
|---------|------|---------|
| **Extending IViewService** | Adding business logic to view execution | Separate concerns, reusable across contexts |
| **Event Publishing** | Results trigger downstream processes | Event-driven architecture |
| **Enrichment** | Need to combine view data with external APIs | Single query result with external data |
| **Auditing** | Track who executed which views | Compliance and monitoring |
| **Orchestration** | Multi-view dashboards or reports | Parallel execution, aggregated results |
| **Caching** | Dashboard with stable data | 10x faster subsequent loads |
| **Pagination** | Large result sets (>1000 rows) | Reduce memory usage |
| **Streaming** | Very large exports (100K+ rows) | Constant memory footprint |
| **Custom extensions** | Need computed properties on models | Clean UI display logic |
| **FluentValidation** | Complex parameter rules | Reusable validation |
| **Custom handlers** | Domain-specific errors | Better error messages |
| **Multi-tenant testing** | Multi-schema project | Ensure data isolation |
