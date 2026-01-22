# **Architectural Strategies for Orchestrating Raw SQL Script Execution via the Entity Framework Core CLI**

The integration of raw SQL scripts within the Entity Framework Core ecosystem represents a sophisticated intersection between the abstraction of object-relational mapping and the granular, high-performance capabilities of native database engines. While Entity Framework Core is fundamentally architected to facilitate database interactions through Language Integrated Query and a declarative model-building paradigm, modern enterprise applications frequently encounter operational requirements that necessitate direct SQL execution. These requirements often include the orchestration of complex data migrations, the deployment of provider-specific database objects such as stored procedures, triggers, or views, and the execution of high-volume bulk operations that surpass the efficiency of the standard Change Tracker mechanism.1 The ability to apply INSERT and UPDATE statements from external .sql files using the dotnet ef command-line interface is not merely a technical utility but a critical component of a robust database deployment strategy.

## **The Paradigm of Managed Persistence and the Role of Raw SQL**

Entity Framework Core serves as a bridge between the imperative world of C\# and the relational world of SQL. However, the framework's design acknowledges that LINQ cannot express every possible database operation with optimal efficiency.1 In early iterations of the framework, performing bulk updates required developers to load entire datasets into memory, modify the entities individually, and then call SaveChanges, a process that incurred massive overhead in terms of both memory allocation and network latency.1 Although EF Core 7.0 and subsequent versions introduced the ExecuteUpdate and ExecuteDelete methods to provide a more efficient LINQ-to-SQL translation for set-based operations, many legacy systems and complex data-seeding tasks still rely on pre-existing SQL scripts that have been manually tuned for performance.1

The dotnet ef toolset provides the necessary infrastructure to manage these scripts within the application’s lifecycle. By utilizing the migrations pipeline, developers can ensure that INSERT and UPDATE operations contained within .sql files are executed in a versioned, repeatable manner across different environments, from local development to production.3 This managed approach to raw SQL execution mitigates the risks associated with manual database patching and ensures that the database schema and its underlying data remain synchronized with the application code.2

## **The dotnet ef CLI Infrastructure**

The dotnet ef command-line interface is an extension of the.NET CLI that enables design-time tasks such as migration generation, database updates, and model scaffolding.11 To utilize these tools, developers must install the dotnet-ef tool globally or locally and include the Microsoft.EntityFrameworkCore.Design package in their target project.11 The CLI acts as the primary orchestrator for applying migrations that may contain raw SQL logic.

### **Core Commands for Script Management**

The lifecycle of a database change involving a .sql file typically begins with the generation of a migration. The CLI offers several commands that are instrumental in this process.

| Command | Functionality | Context for SQL Files |
| :---- | :---- | :---- |
| dotnet ef migrations add | Scaffolds a new migration file based on model changes. | Creates the Up and Down methods where file-reading logic is placed. |
| dotnet ef database update | Applies pending migrations to the target database. | Triggers the execution of the SQL contained in the referenced files. |
| dotnet ef migrations script | Generates a SQL script from a range of migrations. | Embeds the content of the .sql files into a larger deployment script. |
| dotnet ef migrations bundle | Creates a self-contained executable for applying migrations. | Packages the file-reading logic and SQL scripts for CI/CD pipelines. |
| dotnet ef dbcontext info | Provides metadata about the current DbContext. | Useful for verifying the connection string and provider before execution. |

8

A critical distinction must be made between the "Target Project" and the "Startup Project" when executing these commands. The target project is where the migrations and model files reside, while the startup project is the entry point that the tools build and run to access the DbContext configuration, including connection strings and database providers.11 If the DbContext is located in a class library, a separate console application or web project must serve as the startup project to provide the necessary runtime environment for the tools.11

## **Mechanisms of Raw SQL Execution: A Taxonomy**

To apply INSERT and UPDATE statements from a file, the content of that file must eventually be passed to one of EF Core’s raw SQL execution APIs. The framework provides several methods for this purpose, each with distinct behaviors regarding entity tracking and return values.

### **The ExecuteSql and ExecuteSqlRaw APIs**

The Database property of the DbContext exposes the ExecuteSql and ExecuteSqlRaw methods, which are designed specifically for DDL (Data Definition Language) and DML (Data Manipulation Language) operations that do not return entity results.1 When a SQL file containing multiple INSERT or UPDATE statements is read into a string, it can be passed to these methods. ExecuteSqlRaw returns an integer representing the total number of rows affected by the command.1

A notable evolutionary step occurred in EF Core 7.0, where ExecuteSql was introduced as a more modern alternative to ExecuteSqlRaw, supporting string interpolation for easier parameterization while maintaining protection against SQL injection.1 However, for executing the static content of a file where parameters are not dynamically injected, ExecuteSqlRaw remains the standard choice.14

### **FromSql and Query-Based Execution**

While ExecuteSql is used for commands that modify state, FromSql (and its predecessor FromSqlRaw) is used to begin a LINQ query based on a SQL statement.4 While primarily used for SELECT queries, FromSql can be used to execute stored procedures that might perform updates while also returning data.4 However, it is important to note that FromSql can only be used on a DbSet and requires the SQL query to return data for all properties of the mapped entity type.4

## **Strategic Implementation of SQL File Integration in Migrations**

The most common and recommended approach for applying SQL statements from a file is to integrate the execution logic directly into an EF Core migration. This ensures that the data operations are performed at the correct point in the database's version history.2

### **The Migration Lifecycle**

When the dotnet ef migrations add command is executed, EF Core compares the current model with the previous model snapshot to identify changes.9 To include a custom SQL file, a developer can generate an empty migration by making no model changes and then manually editing the generated file.10 The Up method of the migration class should be modified to include a call to migrationBuilder.Sql(), which accepts a string containing the SQL to be executed.18

### **File Access Methodologies in C\#**

Reading a .sql file during a migration requires careful consideration of file paths and deployment environments. Because migrations are executed both in development (via the CLI) and in production (potentially via bundles or runtime calls), the method of locating the file must be robust.

One common approach is to use relative paths from the project's base directory. However, Directory.GetCurrentDirectory() can be unreliable when the CLI is invoked from different folders.16 A more stable alternative is to use AppDomain.CurrentDomain.BaseDirectory or AppContext.BaseDirectory, which points to the location of the compiled assemblies.16

For maximum reliability in distributed systems, the SQL files should be treated as "Embedded Resources".16 By setting the build action to embedded, the script content is compiled directly into the assembly, eliminating the risk of a "file not found" exception during a remote deployment.16 The migration then uses the Assembly class to retrieve the resource stream and read its contents into a string for the migrationBuilder.Sql() method.16

| File Access Method | Implementation Detail | Pros | Cons |
| :---- | :---- | :---- | :---- |
| **Physical File (Relative)** | File.ReadAllText("Scripts/data.sql") | Simple to edit during development. | Path may break in different environments. |
| **Physical File (Absolute)** | Path.Combine(AppContext.BaseDirectory,...) | More stable than relative paths. | Still relies on external file presence. |
| **Embedded Resource** | GetManifestResourceStream() | Extremely portable; no external file dependencies. | Requires project rebuild to update script. |
| **Project Resource** | Resources.MyScript | Easy access via strongly-typed properties. | Embeds SQL in assembly metadata; may increase binary size. |

16

## **Runtime Orchestration: Applying SQL via DbContext**

In some scenarios, it is necessary to apply SQL scripts outside of the migration pipeline, such as during application startup or in response to a specific user action. This is achieved through the context.Database property.1

### **Programmatic Migration with Migrate()**

Applications can programmatically apply pending migrations by calling context.Database.Migrate() or MigrateAsync().8 If a migration contains the file-reading logic described previously, this call will effectively execute the INSERT and UPDATE statements from the .sql file.9 While convenient for local testing and small-scale deployments, this approach is often discouraged for production environments due to potential race conditions in multi-instance deployments and the elevated database permissions required by the application.8

### **Direct Script Execution**

For ad-hoc script application, developers can use ExecuteSqlRawAsync directly within a service or controller. This is particularly useful for maintenance tasks or high-performance data patching that does not belong in the schema version history.14

C\#

// Example of direct execution logic within a service  
public async Task ApplyPatchAsync(string fileName)  
{  
    var sql \= await File.ReadAllTextAsync(Path.Combine(\_basePath, fileName));  
    using (var context \= \_contextFactory.CreateDbContext())  
    {  
        await context.Database.ExecuteSqlRawAsync(sql);  
    }  
}

1

## **The Performance Frontier: Benchmarking Bulk Data Operations**

The decision to use raw SQL scripts for INSERT and UPDATE operations is frequently driven by performance considerations. The traditional EF Core pattern of row-by-row updates is fundamentally limited by the latency of individual database round-trips and the computational cost of change tracking.6

### **Quantitative Impact of Bulk Operations**

When processing large datasets, the performance gains of raw SQL are significant. Research suggests that for an operation involving 5,000 records, the standard SaveChanges() method may take approximately 85 seconds, whereas a bulk operation can complete the same task in approximately 1 second.6 This represents a 98.8% reduction in execution time.6

The efficiency can be quantified using the following relationship:

$$\\text{Speedup Factor} \= \\frac{\\text{Time}\_{\\text{Tracked}}}{\\text{Time}\_{\\text{Bulk}}}$$

In high-latency environments, where the time per round-trip is a major bottleneck, the speedup factor for raw SQL bulk operations can exceed 85x for inserts and 10x-30x for updates and deletes.6

| Operation Type | Rows | SaveChanges Time | Bulk/SQL Time | Efficiency Improvement |
| :---- | :---- | :---- | :---- | :---- |
| **Insert** | 5,000 | 85.0s | 1.0s | 85.0x |
| **Insert** | 100,000 | 595.0s | 7.0s | 85.0x |
| **Insert** | 1,000,000 | 17,000s | 25.0s | 680.0x |
| **Update** | 1,000 | 17.0s | 0.5s | 34.0x |

6

These gains are primarily attributed to the reduction of database round-trips. While SaveChanges() sends $N$ statements for $N$ records, a raw SQL script or an ExecuteUpdate call typically sends a single statement that the database engine can optimize internally.5 Furthermore, the memory footprint is dramatically reduced because EF Core does not need to instantiate or track entity objects, which can consume up to 2GB of memory for a million-record operation.6

## **Architectural Deployment: From Development to Production**

Deploying database changes that include raw SQL files requires a strategy that balances developer productivity with production safety. The EF Core documentation highlights several distinct strategies for applying migrations.8

### **Recommended Production Pattern: SQL Scripts**

For production environments, the most recommended strategy is the generation of SQL scripts using dotnet ef migrations script.8 This allows a Database Administrator (DBA) to review the generated SQL—including the contents of any INSERT or UPDATE statements pulled from .sql files—before they are executed.2 This "script-first" deployment model provides the highest level of control and minimizes the risk of accidental data loss.2

### **Idempotent Deployment**

In environments where the current state of the database may be unknown, idempotent scripts are invaluable. By using the \--idempotent flag with the script generation command, EF Core produces a script that checks the \_\_EFMigrationsHistory table before executing each migration block.8 This ensures that the same script can be run multiple times without causing errors or duplicate data entries, as the script will only apply those migrations that are currently missing.2

### **Migration Bundles (efbundle)**

For modern DevOps pipelines, Migration Bundles provide a self-contained, single-file executable (efbundle.exe) that can apply migrations to a target database.8 Bundles are advantageous because they do not require the.NET SDK or the project source code to be present on the production server.8 When a migration includes logic to read a .sql file, that file must be available in the execution directory of the bundle, or it must have been embedded into the assembly at build time.8

## **Security and Data Integrity in the Raw SQL Lifecycle**

Executing raw SQL statements from external files introduces specific security and integrity concerns that must be addressed through architectural safeguards.

### **SQL Injection Prevention**

The primary security risk associated with raw SQL is SQL injection. While static .sql files are generally safe if their content is controlled by the development team, any logic that dynamicallly alters the script before execution must be carefully scrutinized.1 Developers should avoid concatenating user input into SQL strings. When using ExecuteSqlRaw, parameterization should be used for variable values.1

C\#

// Secure parameterization example  
var category \= "Electronics";  
var increase \= 1.10;  
context.Database.ExecuteSqlRaw(  
    "UPDATE Products SET Price \= Price \* {0} WHERE Category \= {1}",   
    increase, category);

1

### **The ChangeTracker Disconnect**

A critical implication of using raw SQL for UPDATE and INSERT operations is that these commands bypass the EF Core Change Tracker.5 If an application executes an UPDATE statement via raw SQL that modifies a record already loaded into memory, the in-memory entity will become "stale," reflecting the old data state.7 This can lead to data inconsistency if the stale entity is later modified and saved via SaveChanges.7

To maintain consistency, developers should:

1. **Execute bulk operations before loading data:** Ensure the database is in the desired state before entities are fetched for processing.5  
2. **Clear the Change Tracker:** If data has already been loaded, calling context.ChangeTracker.Clear() ensures that subsequent queries fetch the updated values from the database.7  
3. **Use Transactions:** Wrapping both raw SQL execution and subsequent EF Core operations in a common transaction ensures that either all changes are committed or none are, preventing partial state updates in the event of an error.7

## **Advanced Extensibility and Custom Operations**

For organizations that frequently utilize SQL scripts, the EF Core migration pipeline can be extended to support specialized operations. This is achieved by subclassing MigrationOperation and providing a custom IMigrationsSqlGenerator.27

### **Creating a SqlFileOperation**

Rather than manually reading file contents in every migration, a developer can define a SqlFileOperation that takes a filename as a parameter.27 A custom SQL generator then intercepts this operation and handles the provider-specific logic for executing the file's contents.27 This approach allows for cleaner migration code and centralizes the logic for file handling and security validation.27

C\#

// Architectural pattern for a custom migration operation  
public class CreateStoredProcedureOperation : MigrationOperation  
{  
    public string Name { get; set; }  
    public string ScriptPath { get; set; }  
}

public static class MigrationBuilderExtensions  
{  
    public static OperationBuilder\<CreateStoredProcedureOperation\> CreateStoredProcedure(  
        this MigrationBuilder builder, string name, string path)  
    {  
        var op \= new CreateStoredProcedureOperation { Name \= name, ScriptPath \= path };  
        builder.Operations.Add(op);  
        return new OperationBuilder\<CreateStoredProcedureOperation\>(op);  
    }  
}

20

This level of extensibility allows teams to create a domain-specific language (DSL) for their database changes, incorporating scripts for custom permissions, auditing triggers, or complex reporting views while still benefiting from the dotnet ef CLI's management capabilities.27

## **The Impact of Modern Framework Evolution (EF Core 9 & 10\)**

The release of EF Core 9.0 and the upcoming EF Core 10 introduce several breaking changes and enhancements that affect how raw SQL is managed and executed.

### **Enforced Model Consistency**

Starting with EF Core 9.0, the framework introduces a stricter check for model consistency. If the tools detect pending model changes that have not been captured in a migration, an exception is thrown when calling database update or Migrate().26 This ensures that developers do not accidentally bypass the migration history when making schema changes.26 For developers using raw SQL files to manage objects that EF Core is unaware of (such as custom roles or permissions), it is necessary to use annotations to ensure EF Core tracks these changes as part of the model.28

### **Transaction Strategy Changes**

Another significant change in EF Core 9.0 is the default transaction behavior for migrations. Calls to Migrate() and MigrateAsync() now automatically start a transaction and execute commands using an execution strategy.26 This improvement ensures higher reliability for multi-step migrations but may require developers to adjust their code if they were previously managing transactions manually.26

### **Enhancements in Bulk Updates**

EF Core 9 and 10 continue to improve the ExecuteUpdate and ExecuteDelete APIs. EF Core 9 added support for complex type properties in bulk updates, and EF Core 10 is slated to allow regular lambdas (rather than just expression trees) for ExecuteUpdateAsync, making dynamic and conditional updates significantly easier to write in C\#.5 As these LINQ-based bulk operations become more powerful, the necessity of falling back to raw SQL files may decrease for standard data transformations, though scripts will remain the primary choice for complex, pre-tuned database logic.5

## **Navigating the Hybrid Persistence Model**

The effective application of INSERT and UPDATE statements from .sql files using dotnet ef requires a nuanced understanding of the framework's internal mechanisms and the broader database deployment lifecycle. While raw SQL offers unparalleled performance and access to provider-specific features, it must be used within the structured confines of the migrations system to maintain the integrity and maintainability of the application.

By leveraging embedded resources for script storage, utilizing idempotent deployment strategies for production, and remaining mindful of the Change Tracker's disconnect during raw SQL execution, engineering teams can build highly performant and reliable data layers. As Entity Framework Core continues to evolve, the distinction between high-level ORM operations and low-level SQL execution is becoming increasingly blurred, allowing for a hybrid model where developers can choose the most efficient tool for any given task without sacrificing the benefits of a managed, version-controlled environment.

The quantitative evidence for the efficiency of bulk operations highlights the necessity of this hybrid approach. In an era of massive datasets and high-concurrency cloud applications, the ability to bypass row-by-row processing in favor of set-based SQL execution is a critical performance tier that every professional developer must be prepared to implement. Whether through the direct use of CLI tools or the programmatic orchestration of migrations, the integration of raw SQL files remains a cornerstone of professional.NET database development.

#### **Works cited**

1. ExecuteSql \- Executing Raw SQL Queries using EF Core \- Learn Entity Framework Core, accessed January 21, 2026, [https://www.learnentityframeworkcore.com/raw-sql/execute-sql](https://www.learnentityframeworkcore.com/raw-sql/execute-sql)  
2. EF Core Migrations: A Detailed Guide \- Milan Jovanović, accessed January 21, 2026, [https://www.milanjovanovic.tech/blog/efcore-migrations-a-detailed-guide](https://www.milanjovanovic.tech/blog/efcore-migrations-a-detailed-guide)  
3. Entity Framework Core Migrations: Create, Update, Remove, Revert \- Devart, accessed January 21, 2026, [https://www.devart.com/dotconnect/ef-core-migrations.html](https://www.devart.com/dotconnect/ef-core-migrations.html)  
4. SQL Queries \- EF Core \- Microsoft Learn, accessed January 21, 2026, [https://learn.microsoft.com/en-us/ef/core/querying/sql-queries](https://learn.microsoft.com/en-us/ef/core/querying/sql-queries)  
5. EF Core ExecuteUpdate (EF Core 7–10) – Set-Based Bulk Updates, accessed January 21, 2026, [https://www.learnentityframeworkcore.com/dbset/execute-update](https://www.learnentityframeworkcore.com/dbset/execute-update)  
6. Maximizing Data Throughput: Mastering Bulk Operations in EF Core \- Medium, accessed January 21, 2026, [https://medium.com/@20011002nimeth/maximizing-data-throughput-mastering-bulk-operations-in-ef-core-1344699146cc](https://medium.com/@20011002nimeth/maximizing-data-throughput-mastering-bulk-operations-in-ef-core-1344699146cc)  
7. What You Need To Know About EF Core Bulk Updates, accessed January 21, 2026, [https://www.milanjovanovic.tech/blog/what-you-need-to-know-about-ef-core-bulk-updates](https://www.milanjovanovic.tech/blog/what-you-need-to-know-about-ef-core-bulk-updates)  
8. Applying Migrations \- EF Core \- Microsoft Learn, accessed January 21, 2026, [https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/applying](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/applying)  
9. Entity Framework Core Migrations, accessed January 21, 2026, [https://www.learnentityframeworkcore.com/migrations](https://www.learnentityframeworkcore.com/migrations)  
10. Managing Migrations \- EF Core \- Microsoft Learn, accessed January 21, 2026, [https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/managing](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/managing)  
11. EF Core tools reference (.NET CLI) \- Microsoft Learn, accessed January 21, 2026, [https://learn.microsoft.com/en-us/ef/core/cli/dotnet](https://learn.microsoft.com/en-us/ef/core/cli/dotnet)  
12. Command Line Interface commands \- Learn Entity Framework Core, accessed January 21, 2026, [https://www.learnentityframeworkcore.com/migrations/commands/cli-commands](https://www.learnentityframeworkcore.com/migrations/commands/cli-commands)  
13. EF Core: The Main Things You Need To Know About Migrations | by Nathan \- Medium, accessed January 21, 2026, [https://medium.com/the-tech-collective/ef-core-the-main-things-you-need-to-know-about-migrations-ae3c1a8e7705](https://medium.com/the-tech-collective/ef-core-the-main-things-you-need-to-know-about-migrations-ae3c1a8e7705)  
14. Executing raw SQL using EntityFrameworkCore and SQLite on .NET Core \- Stack Overflow, accessed January 21, 2026, [https://stackoverflow.com/questions/39073543/executing-raw-sql-using-entityframeworkcore-and-sqlite-on-net-core](https://stackoverflow.com/questions/39073543/executing-raw-sql-using-entityframeworkcore-and-sqlite-on-net-core)  
15. EF Core Bulk Operations \- C\# Corner, accessed January 21, 2026, [https://www.c-sharpcorner.com/article/ef-core-bulk-operations/](https://www.c-sharpcorner.com/article/ef-core-bulk-operations/)  
16. How to run migration SQL script using Entity Framework Core \- Stack Overflow, accessed January 21, 2026, [https://stackoverflow.com/questions/45035754/how-to-run-migration-sql-script-using-entity-framework-core](https://stackoverflow.com/questions/45035754/how-to-run-migration-sql-script-using-entity-framework-core)  
17. Custom Entity Framework Core Migration Script? \- Stack Overflow, accessed January 21, 2026, [https://stackoverflow.com/questions/51048534/custom-entity-framework-core-migration-script](https://stackoverflow.com/questions/51048534/custom-entity-framework-core-migration-script)  
18. Execute custom SQL script as part of Entity Framework migration \- Stack Overflow, accessed January 21, 2026, [https://stackoverflow.com/questions/46638380/execute-custom-sql-script-as-part-of-entity-framework-migration](https://stackoverflow.com/questions/46638380/execute-custom-sql-script-as-part-of-entity-framework-migration)  
19. Raw SQL in EF migration \- Stack Overflow, accessed January 21, 2026, [https://stackoverflow.com/questions/53171440/raw-sql-in-ef-migration](https://stackoverflow.com/questions/53171440/raw-sql-in-ef-migration)  
20. Entity Framework Core migration tools: run a .sql script and \`DropStoredProcedureIfExists()\`, accessed January 21, 2026, [https://gist.github.com/689891a94fc2a49f193d8ba667110b51](https://gist.github.com/689891a94fc2a49f193d8ba667110b51)  
21. EF Core Migrations without Hard-coding a Connection String using IDbContextFactory  
22. How to run SQL scripts in a file while performing the code first EF Core migrations?, accessed January 21, 2026, [https://iabu94.medium.com/how-to-run-sql-scripts-in-a-file-while-performing-the-code-first-ef-core-migrations-f75856466917](https://iabu94.medium.com/how-to-run-sql-scripts-in-a-file-while-performing-the-code-first-ef-core-migrations-f75856466917)  
23. Executing raw SQL queries in EF Core \- YouTube, accessed January 21, 2026, [https://www.youtube.com/watch?v=cr\_7rfXTOo4](https://www.youtube.com/watch?v=cr_7rfXTOo4)  
24. Entity Framework 7 bulk update \- ExecuteUpdate (new) v SaveChanges v plain SQL benchmarks : r/dotnet \- Reddit, accessed January 21, 2026, [https://www.reddit.com/r/dotnet/comments/10ohpqs/entity\_framework\_7\_bulk\_update\_executeupdate\_new/](https://www.reddit.com/r/dotnet/comments/10ohpqs/entity_framework_7_bulk_update_executeupdate_new/)  
25. How to ignore EF migrations that already happened, but were merged into the develop branch? \- Reddit, accessed January 21, 2026, [https://www.reddit.com/r/dotnet/comments/wmau5k/how\_to\_ignore\_ef\_migrations\_that\_already\_happened/](https://www.reddit.com/r/dotnet/comments/wmau5k/how_to_ignore_ef_migrations_that_already_happened/)  
26. Breaking changes in EF Core 9 (EF9) \- Microsoft Learn, accessed January 21, 2026, [https://learn.microsoft.com/en-us/ef/core/what-is-new/ef-core-9.0/breaking-changes](https://learn.microsoft.com/en-us/ef/core/what-is-new/ef-core-9.0/breaking-changes)  
27. Custom Migrations Operations \- EF Core | Microsoft Learn, accessed January 21, 2026, [https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/operations](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/operations)  
28. Customizing migration detection and generation · Issue \#34454 · dotnet/efcore \- GitHub, accessed January 21, 2026, [https://github.com/dotnet/efcore/issues/34454](https://github.com/dotnet/efcore/issues/34454)