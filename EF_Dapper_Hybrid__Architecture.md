# This file follows **Microsoft Clean Architecture** standards:

### 1. **EF Core** is isolated in the Infrastructure layer (for migrations and state).  
### 2. **Dapper** is utilized in the Application layer (for fast reads and complex SQL writes).  
### 3. **Blazor/Radzen** stays in the Web layer, consuming the Dapper DTOs.

## **Implementation Blueprint: HybridArchitecture.md**

### TASK: Implement Hybrid .NET 8/9 Clean Architecture (EF Core \+ Dapper)

## **1. PRE-REQUISITES**  
- Create a new directory and execute all shell commands from the root.  
- Ensure .NET SDK 8.0 or higher is installed.

## **2. PROJECT INITIALIZATION (CLI)**  
Execute these commands to build the four-tier architecture:

```bash  
dotnet new sln -n HybridSystem  
dotnet new classlib -n HybridSystem.Domain  
dotnet new classlib -n HybridSystem.Application  
dotnet new classlib -n HybridSystem.Infrastructure  
dotnet new blazor -n HybridSystem.WebUI --interactivity Server  
dotnet sln add (ls **/*.csproj)
```

## **3. DEPENDENCY GRAPH**

Configure references to ensure the Domain remains pure:
* **Application** -> Domain  
* **Infrastructure** -> Application, Domain  
* **WebUI** -> Infrastructure, Application

## **4. MODULE ARCHITECTURE & STANDARDS**

### **A. DOMAIN LAYER (POCOs)**

* **Path**: HybridSystem.Domain/Entities/  
* **Rule**: Pure C\# classes only. No EF or Dapper references.  
* **Goal**: Database-agnostic business models.

### **B. INFRASTRUCTURE LAYER (EF/LINQ)**

* **Path**: HybridSystem.Infrastructure/Persistence/  
* **Technology**: EF Core (Microsoft.EntityFrameworkCore.SqlServer)  
* **Purpose**: Database schema management, Migrations, and Identity.  
* **Best Practice**: Use this layer for "Writes" where change-tracking is needed (e.g., Simple CRUD).

### **C. APPLICATION LAYER (DAPPER/SQL)**

* **Path**: HybridSystem.Application/Data/  
* **Technology**: Dapper  
* **Purpose**: High-performance Read models (DTOs) and Complex "Task-Writes."  
* **Standard**: All DTOs for Radzen components live here. Hand-written SQL only.

## **5. CODE IMPLEMENTATION: SHARED CONNECTION**

Create a service in HybridSystem.Infrastructure that registers a shared IDbConnection so EF and Dapper share the same underlying pipeline:

```C#
// Infrastructure/DependencyInjection.cs  
public static IServiceCollection AddPersistence(this IServiceCollection services, string connectionString) {  
    // 1\. EF Core Setup  
    services.AddDbContext\<AppDbContext\>(opt \=\> opt.UseSqlServer(connectionString));  
      
    // 2\. Dapper Setup (Sharing the Connection String)  
    services.AddScoped\<IDbConnection\>(\_ \=\> new SqlConnection(connectionString));  
      
    return services;  
}
```

## **6. SAMPLE BLAZOR-RADZEN EVENT (DAPPER WRITE)**

When a user clicks "Process" in the UI, use Dapper in the Application Layer to execute optimized SQL:

```C#

// Application/Services/OrderService.cs  
public async Task ProcessOrderAsync(int orderId) {  
    const string sql \= @"  
        UPDATE Orders SET Status \= 'Processed' WHERE Id \= @orderId;  
        INSERT INTO Logs (Msg) VALUES ('Order updated via Dapper');";  
      
    await \_db.ExecuteAsync(sql, new { orderId });  
}
```

## **7. SUMMARY OF ARCHITECTURAL INTENT**

This hybrid approach is designed for teams of **SQL experts**.

* **EF Core** is used as a "Database Management Tool" (Migrations).  
* **Dapper** is used as the "Application Engine" (Fast UI Data).  
* **Radzen** components bind to "Flat DTOs" in the Application layer, keeping the WebUI decoupled from the physical database schema.