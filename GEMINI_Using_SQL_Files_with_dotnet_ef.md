# **Research: Applying SQL Scripts via "dotnet ef"**

Applying INSERT and UPDATE statements from a .sql file using Entity Framework Core (EF Core) is a common requirement for data seeding, migrations, or complex data patches. While dotnet ef is primarily designed for C\#-based migrations, it provides hooks to execute raw SQL.

## **1\. The Migration Strategy (Recommended)**

The most robust way to apply SQL files is through EF Core Migrations. This ensures that the SQL script is versioned along with your schema and executed automatically across environments.

### **Step-by-Step Workflow**

1. Create an Empty Migration:  
   Run the following command in your terminal:  
   dotnet ef migrations add SeedDataFromSql

2. Embed the SQL File:  
   To ensure the .sql file is accessible when the application is compiled or deployed, add it to your .csproj as an Embedded Resource:  
   \<ItemGroup\>  
     \<EmbeddedResource Include="Scripts\\MyScript.sql" /\>  
   \</ItemGroup\>

3. Read and Execute in the Migration:  
   Inside the generated migration's Up method, use MigrationBuilder.Sql() to execute the contents of the file.

## **2\. The Raw Execution Strategy**

If you need to run a script ad-hoc without a migration (for example, in a CI/CD pipeline or a startup routine), you can use the DbContext.Database.ExecuteSqlRaw method.

### **Implementation Example:**

var sql \= File.ReadAllText("path/to/script.sql");  
using (var context \= new MyDbContext())  
{  
    context.Database.ExecuteSqlRaw(sql);  
}

## **3\. Tooling and CLI Alternatives**

### **SQL Idempotency**

When using dotnet ef migrations script, you can generate a full SQL script representing your migrations. If your .sql file is already integrated into a migration, it will be included in this output.

dotnet ef migrations script \--output bundle.sql \--idempotent

### **EF Core Power Tools**

For developers who prefer a UI, **EF Core Power Tools** (a Visual Studio extension) allows for easier management of SQL-based migrations and schema comparisons.

## **4\. Key Considerations**

| Feature | Description |
| :---- | :---- |
| **Transaction Management** | EF Migrations wrap your SQL in a transaction by default. If your script contains COMMIT or ROLLBACK, it may cause errors. |
| **Provider Specificity** | Raw SQL is often specific to a provider (e.g., T-SQL for SQL Server vs. PL/pgSQL for PostgreSQL). Ensure your script matches your target DB. |
| **Execution Order** | When using migrations, the INSERT and UPDATE statements will always run after the schema changes defined in the same migration. |
| **Pathing** | Use AppDomain.CurrentDomain.BaseDirectory or Embedded Resources to avoid "file not found" errors in production environments. |

## **Conclusion**

The best practice is to incorporate .sql files into **EF Core Migrations** using migrationBuilder.Sql(). This maintains a single source of truth for your database state and leverages the existing dotnet ef database update workflow.