# DdlParser

Converts SQL Server DDL (.sql files) into `app.yaml` format for the DotNetWebApp framework.

## Usage

```bash
cd DdlParser
dotnet run -- <input.sql> <output.yaml>
```

## Example

```bash
# Parse a SQL schema file and generate app.yaml
dotnet run -- database-schema.sql ../app.yaml

# Then generate models from the YAML
cd ../ModelGenerator
dotnet run ../app.yaml

# Build and run
cd ..
make build
make dev
```

## How It Works

The DdlParser uses Microsoft's official SQL Server T-SQL parser (`Microsoft.SqlServer.TransactSql.ScriptDom`) to:

1. **Parse** SQL DDL files into an Abstract Syntax Tree (AST)
2. **Extract** table metadata (columns, constraints, relationships)
3. **Convert** SQL types to app.yaml types
4. **Generate** valid `app.yaml` compatible with ModelGenerator

### Pipeline

```
database.sql → DdlParser → app.yaml → ModelGenerator → Models/Generated/*.cs
```

## Supported Features

### Data Types
- **Integer:** `int`, `bigint`, `smallint`, `tinyint`
- **String:** `varchar`, `nvarchar`, `char`, `nchar`, `text`, `ntext`
- **Decimal:** `decimal`, `numeric`, `money`, `smallmoney`, `float`, `real`
- **DateTime:** `datetime`, `datetime2`, `date`, `time`, `datetimeoffset`, `timestamp`
- **Boolean:** `bit`
- **GUID:** `uniqueidentifier`

### DDL Elements
- CREATE TABLE statements
- Column definitions with data types
- NOT NULL constraints
- PRIMARY KEY constraints (single column)
- FOREIGN KEY constraints
- IDENTITY columns
- DEFAULT values
- VARCHAR/NVARCHAR max lengths
- DECIMAL precision and scale

## Limitations

- **Composite primary keys** - Only single-column primary keys are fully supported
- **CHECK constraints** - Ignored during parsing
- **UNIQUE constraints** - Ignored (not included in app.yaml schema)
- **Computed columns** - Not supported by app.yaml (will be ignored)
- **Multiple schemas** - All tables assumed to be in `dbo` schema
- **Schema-qualified names** - `dbo.Products` will be parsed as `Products`
- **Self-referencing foreign keys** - Should work but may need manual verification
- **Circular foreign keys** - May result in circular relationships in YAML

## Example Input

**schema.sql:**
```sql
CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    Price DECIMAL(18,2) NULL,
    CategoryId INT NULL,
    CreatedAt DATETIME2 NULL DEFAULT GETDATE(),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);
```

## Example Output

**app.yaml:**
```yaml
app:
  name: ImportedApp
  title: Imported Application
  description: Generated from DDL file
  logoUrl: /images/logo.png

theme:
  primaryColor: '#007bff'
  secondaryColor: '#6c757d'
  backgroundColor: '#ffffff'
  textColor: '#212529'

dataModel:
  entities:
  - name: Category
    properties:
    - name: Id
      type: int
      isPrimaryKey: true
      isIdentity: true
      isRequired: true
    - name: Name
      type: string
      maxLength: 50
      isRequired: true
    relationships: []

  - name: Product
    properties:
    - name: Id
      type: int
      isPrimaryKey: true
      isIdentity: true
      isRequired: true
    - name: Name
      type: string
      maxLength: 100
      isRequired: true
    - name: Description
      type: string
      maxLength: 500
      isRequired: false
    - name: Price
      type: decimal
      isRequired: false
    - name: CategoryId
      type: int
      isRequired: false
    - name: CreatedAt
      type: datetime
      isRequired: false
      defaultValue: GETDATE()
    relationships:
    - type: one-to-many
      targetEntity: Category
      foreignKey: CategoryId
      principalKey: Id
```

## Architecture

### Components

- **SqlDdlParser.cs** - Wraps Microsoft.SqlServer.TransactSql.ScriptDom parser
- **CreateTableVisitor.cs** - AST visitor that extracts CREATE TABLE statements
- **TypeMapper.cs** - Converts SQL types to app.yaml type strings
- **YamlGenerator.cs** - Converts parsed metadata to AppDefinition and serializes to YAML
- **Program.cs** - CLI entry point

### Key Classes

- `TableMetadata` - Represents a SQL table
- `ColumnMetadata` - Represents a table column
- `ForeignKeyMetadata` - Represents a foreign key relationship

## Troubleshooting

### SQL Parsing Errors
If you get parsing errors, ensure your SQL file contains valid T-SQL syntax. The parser is strict and may reject:
- Incomplete statements (missing semicolons)
- Invalid syntax
- Unsupported SQL Server features

### Type Mapping Issues
If a SQL type is not recognized, it defaults to `string`. Check `TypeMapper.cs` and add mappings for any missing types.

### Naming Issues
Entity names are singularized using basic rules (removing trailing 's', 'es', 'ies'). Complex pluralization may need manual adjustment in the generated `app.yaml`.

## Integration with ModelGenerator

After generating `app.yaml`:

```bash
# Generate model classes
cd ../ModelGenerator
dotnet run ../app.yaml

# Apply migrations (if using SQL Server)
cd ..
./dotnet-build.sh ef migrations add <MigrationName>
make migrate

# Build and verify
make build
```

## Future Enhancements

Potential improvements for future versions:
- Support for composite primary keys
- Index definitions
- View definitions
- ALTER TABLE statements
- Multiple schema support
- Interactive configuration mode
- Validation warnings for unsupported features
