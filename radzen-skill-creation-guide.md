# How to Create a Radzen Blazor Components Skill for Claude Code

## Overview

This guide will walk you through creating a custom Claude Code skill for working with Radzen Blazor UI components. Based on my research, **no pre-existing Radzen skill exists in the community**, so creating one will be valuable for your .NET Blazor development workflow.

## What is Radzen?

Radzen Blazor Components is a **free, open-source library** with 100+ native Blazor UI components including:
- DataGrid, Scheduler, Charts
- Form components (buttons, inputs, dropdowns)
- Layout components
- Material Design and Fluent UI theming
- Full ARIA support and keyboard navigation

**Key Facts:**
- MIT licensed and open source
- No JavaScript wrappers (pure C#/Razor)
- Works with Blazor Server, WebAssembly, and .NET 8+
- NuGet package: `Radzen.Blazor`

---

## Step 1: Understanding Radzen Usage Patterns

Before creating the skill, identify common Radzen development tasks:

### Common User Requests:
1. "Add a Radzen DataGrid to display users"
2. "Create a form with Radzen components for user registration"
3. "Setup Radzen in my Blazor project"
4. "Add a Radzen chart to visualize sales data"
5. "Create a CRUD page using Radzen components"
6. "Add validation to my Radzen form"
7. "Implement Radzen dialog for confirmations"

### Trigger Keywords:
- "Radzen" (primary)
- "Radzen component", "Radzen DataGrid", "Radzen form"
- "Blazor UI component" (when Radzen is in context)

---

## Step 2: Planning Skill Contents

Based on common patterns, here's what your skill should include:

### SKILL.md Structure

**Frontmatter (YAML):**
```yaml
---
name: radzen-blazor
description: >
  Expert guidance for Radzen Blazor UI components - a free, open-source library 
  of 100+ native Blazor components. Use when working with Radzen components, 
  creating Blazor UI with DataGrids, forms, charts, or when user mentions 
  "Radzen". Covers setup, component usage, theming, data binding, validation, 
  and CRUD operations with Radzen.Blazor components.
---
```

**Body Sections:**

1. **Quick Setup Guide**
   - NuGet installation
   - Service registration
   - CSS/JS references
   - Basic configuration

2. **Common Components Reference**
   - RadzenDataGrid (most used)
   - RadzenButton, RadzenTextBox
   - RadzenDropDown, RadzenDatePicker
   - RadzenDialog, RadzenNotification
   - RadzenCard, RadzenPanel

3. **Pattern Library**
   - Data binding patterns
   - Event handling
   - Form validation
   - CRUD operations
   - Template usage

4. **Best Practices**
   - Component render modes (.NET 8+)
   - Performance optimization
   - Theming guidelines

### Bundled Resources to Include

#### `references/components-quick-ref.md`
Detailed component parameter reference for:
- RadzenDataGrid (columns, sorting, filtering, paging)
- Form components (validation, binding)
- Layout components (responsive design)

**Why in references?** This is detailed API documentation that Claude only needs when working with specific components.

#### `references/setup-patterns.md`
Complete setup instructions for:
- Blazor Server (.NET 6, 7, 8+)
- Blazor WebAssembly
- Different render modes
- Service registration options

**Why in references?** Environment-specific setup is only needed during initial configuration.

#### `scripts/setup-radzen.sh` (optional)
Bash script to automate Radzen setup:
```bash
#!/bin/bash
# Adds Radzen package and updates configuration files
dotnet add package Radzen.Blazor
# Update _Imports.razor, Program.cs, etc.
```

**Why include?** Setup is repetitive and error-prone - scripting ensures consistency.

#### `assets/templates/`
Common Radzen patterns as template files:
- `crud-page.razor` - Basic CRUD page template
- `data-grid-example.razor` - DataGrid with all features
- `form-validation.razor` - Complete form with validation
- `dialog-pattern.razor` - Dialog usage pattern

**Why in assets?** These are boilerplate that gets copied/modified for new implementations.

---

## Step 3: Creating the Skill Structure

### Directory Structure

```
radzen-blazor/
├── SKILL.md                          # Main skill file
├── references/
│   ├── components-quick-ref.md       # Component API reference
│   ├── setup-patterns.md             # Setup instructions
│   └── best-practices.md             # Advanced patterns
├── assets/
│   └── templates/
│       ├── crud-page.razor
│       ├── data-grid-example.razor
│       ├── form-validation.razor
│       └── dialog-pattern.razor
└── scripts/
    └── setup-radzen.sh               # Optional automation
```

---

## Step 4: Writing the SKILL.md

### Sample SKILL.md Content

```markdown
---
name: radzen-blazor
description: >
  Expert guidance for Radzen Blazor UI components - a free, open-source library 
  of 100+ native Blazor components. Use when working with Radzen components, 
  creating Blazor UI with DataGrids, forms, charts, or when user mentions 
  "Radzen". Covers setup, component usage, theming, data binding, validation, 
  and CRUD operations with Radzen.Blazor components.
---

# Radzen Blazor Components Skill

Expert guidance for building Blazor applications with Radzen components.

## Quick Setup

### 1. Install NuGet Package
```bash
dotnet add package Radzen.Blazor
```

### 2. Add Service Registration
In `Program.cs`:
```csharp
using Radzen;
builder.Services.AddRadzenComponents();
```

### 3. Add References
In `_Imports.razor`:
```razor
@using Radzen
@using Radzen.Blazor
```

### 4. Include CSS/JS
In `App.razor` or `_Layout.cshtml`:
```html
<link rel="stylesheet" href="_content/Radzen.Blazor/css/material-base.css">
<script src="_content/Radzen.Blazor/Radzen.Blazor.js"></script>
```

For detailed environment-specific setup, see [references/setup-patterns.md](references/setup-patterns.md).

## Core Components

### RadzenDataGrid
Most powerful component for data display with sorting, filtering, paging.

**Basic Usage:**
```razor
<RadzenDataGrid Data="@users" TItem="User">
    <Columns>
        <RadzenDataGridColumn TItem="User" Property="Name" Title="Name" />
        <RadzenDataGridColumn TItem="User" Property="Email" Title="Email" />
    </Columns>
</RadzenDataGrid>
```

See [references/components-quick-ref.md](references/components-quick-ref.md) for complete DataGrid parameters.

### Forms and Validation
```razor
<RadzenTemplateForm Data="@model" Submit="@OnSubmit">
    <RadzenTextBox @bind-Value="@model.Name" />
    <RadzenRequiredValidator Component="Name" Text="Name required" />
    <RadzenButton ButtonType="ButtonType.Submit" Text="Save" />
</RadzenTemplateForm>
```

## Templates

Pre-built templates available in `assets/templates/`:
- **crud-page.razor** - Complete CRUD page
- **data-grid-example.razor** - DataGrid with all features
- **form-validation.razor** - Form with validation
- **dialog-pattern.razor** - Dialog usage

## Best Practices

### .NET 8+ Render Modes
All Radzen components with events require interactive render mode:
```razor
<RadzenButton @rendermode="InteractiveServer" Click="@HandleClick" />
```

### Data Binding
Use `@bind-Value` for two-way binding:
```razor
<RadzenTextBox @bind-Value="@model.Name" />
```

### Event Handling
```razor
<RadzenButton Click="@(() => OnClick())" Text="Click Me" />
```

## Advanced Features

For advanced topics, see:
- **Complex DataGrid scenarios**: [references/components-quick-ref.md](references/components-quick-ref.md)
- **Custom theming**: [references/best-practices.md](references/best-practices.md)
- **Performance optimization**: [references/best-practices.md](references/best-practices.md)

## Common Patterns

### CRUD Operations
1. Use RadzenDataGrid for display
2. RadzenDialog for create/edit forms
3. RadzenNotification for feedback
4. Template form for validation

See `assets/templates/crud-page.razor` for complete implementation.

### Dialog Pattern
```razor
@inject DialogService DialogService

<RadzenButton Click="@OpenDialog" Text="Open Dialog" />

@code {
    async Task OpenDialog()
    {
        await DialogService.OpenAsync<EditUser>("Edit User",
            new Dictionary<string, object>() { { "UserId", userId } });
    }
}
```

## References

- **Component API**: [references/components-quick-ref.md](references/components-quick-ref.md)
- **Setup Guide**: [references/setup-patterns.md](references/setup-patterns.md)
- **Best Practices**: [references/best-practices.md](references/best-practices.md)
- **Official Docs**: https://blazor.radzen.com/
```

---

## Step 5: Creating Reference Files

### Example: `references/components-quick-ref.md`

```markdown
# Radzen Components Quick Reference

## RadzenDataGrid

### Key Parameters
- `Data` - IEnumerable<T> data source
- `TItem` - Type of data item
- `AllowSorting` - Enable column sorting (default: true)
- `AllowFiltering` - Enable filtering (default: false)
- `AllowPaging` - Enable pagination (default: false)
- `PageSize` - Items per page
- `SelectionMode` - DataGridSelectionMode (Single/Multiple)

### Common Patterns

**Sorting and Filtering:**
```razor
<RadzenDataGrid Data="@users" TItem="User" 
                AllowSorting="true" 
                AllowFiltering="true">
```

**Paging:**
```razor
<RadzenDataGrid Data="@users" TItem="User" 
                AllowPaging="true" 
                PageSize="10">
```

**Selection:**
```razor
<RadzenDataGrid Data="@users" TItem="User" 
                SelectionMode="DataGridSelectionMode.Single"
                @bind-Value="@selectedUser">
```

**Template Columns:**
```razor
<RadzenDataGridColumn TItem="User" Title="Actions">
    <Template Context="user">
        <RadzenButton Text="Edit" Click="@(() => Edit(user))" />
    </Template>
</RadzenDataGridColumn>
```

## RadzenButton

### Parameters
- `Text` - Button text
- `Click` - EventCallback for click
- `ButtonType` - Submit/Button/Reset
- `ButtonStyle` - Primary/Secondary/Success/Danger/etc.
- `Disabled` - bool to disable

### Usage
```razor
<RadzenButton Text="Save" 
              Click="@OnSave" 
              ButtonStyle="ButtonStyle.Primary" />
```

## RadzenDropDown

### Parameters
- `Data` - IEnumerable data source
- `@bind-Value` - Selected value binding
- `TextProperty` - Property for display text
- `ValueProperty` - Property for value
- `AllowClear` - Show clear button
- `Placeholder` - Placeholder text

### Usage
```razor
<RadzenDropDown Data="@countries" 
                @bind-Value="@selectedCountry"
                TextProperty="Name" 
                ValueProperty="Id" />
```

## Form Components

### RadzenTextBox
```razor
<RadzenTextBox @bind-Value="@model.Name" Placeholder="Enter name" />
```

### RadzenNumeric
```razor
<RadzenNumeric @bind-Value="@model.Age" TValue="int" />
```

### RadzenDatePicker
```razor
<RadzenDatePicker @bind-Value="@model.BirthDate" />
```

### RadzenCheckBox
```razor
<RadzenCheckBox @bind-Value="@model.IsActive" />
```

## Validation

### Built-in Validators
- `RadzenRequiredValidator` - Required field
- `RadzenEmailValidator` - Email format
- `RadzenLengthValidator` - String length
- `RadzenNumericRangeValidator` - Number range
- `RadzenCompareValidator` - Compare two fields

### Usage
```razor
<RadzenTemplateForm Data="@model" Submit="@OnSubmit">
    <RadzenTextBox @bind-Value="@model.Email" Name="Email" />
    <RadzenRequiredValidator Component="Email" Text="Email is required" />
    <RadzenEmailValidator Component="Email" Text="Invalid email" />
</RadzenTemplateForm>
```
```

---

## Step 6: Testing the Skill

### Test Cases

1. **Basic Setup Test**
   - User: "Setup Radzen in my Blazor project"
   - Expected: Skill triggers, provides setup steps

2. **Component Usage Test**
   - User: "Add a Radzen DataGrid to show my users"
   - Expected: Generates DataGrid with proper bindings

3. **CRUD Test**
   - User: "Create a CRUD page for products using Radzen"
   - Expected: Uses template, generates complete implementation

4. **Validation Test**
   - User: "Add validation to my Radzen form"
   - Expected: Adds proper validators

---

## Step 7: Installing in Claude Code

Once you've created your skill, you can install it in Claude Code:

### For Local Use (Personal Skill)

1. Create the skill directory in `~/.claude/skills/`:
```bash
mkdir -p ~/.claude/skills/radzen-blazor
```

2. Copy your SKILL.md and resources:
```bash
cp -r radzen-blazor/* ~/.claude/skills/radzen-blazor/
```

### For Project Use

1. Create in project's `.claude/skills/`:
```bash
mkdir -p .claude/skills/radzen-blazor
cp -r radzen-blazor/* .claude/skills/radzen-blazor/
```

2. Commit to version control so team can use it

### For Distribution

If you want to share with others or use the packaging system:

```bash
# Package the skill (after validating)
scripts/package_skill.py ~/path/to/radzen-blazor

# This creates radzen-blazor.skill file
```

---

## Additional Recommendations

### 1. Progressive Enhancement
Start simple, add complexity as needed:
- **Version 1**: Basic setup + DataGrid + Form components
- **Version 2**: Add templates, validation patterns
- **Version 3**: Add advanced features (custom themes, complex scenarios)

### 2. Keep It Concise
Remember: "Default assumption: Claude is already very smart"
- Don't explain what Blazor is
- Don't explain basic C# syntax
- Focus on Radzen-specific patterns

### 3. Use References Wisely
- SKILL.md: Core workflows, when to load references
- References: Detailed API docs, environment-specific setup
- Assets: Reusable templates and boilerplate

### 4. Include Real Examples
Pull from Radzen's official demos:
- https://blazor.radzen.com/
- https://github.com/radzenhq/radzen-blazor

### 5. Update Regularly
Radzen is actively maintained. Check for:
- New components
- Breaking changes
- Best practice updates

---

## Resources

- **Radzen Blazor Components**: https://blazor.radzen.com/
- **GitHub Repository**: https://github.com/radzenhq/radzen-blazor
- **Getting Started**: https://blazor.radzen.com/get-started
- **NuGet Package**: https://www.nuget.org/packages/Radzen.Blazor
- **Claude Code Skills Docs**: https://code.claude.com/docs/en/skills
- **Agent Skills Standard**: https://agentskills.io

---

## Next Steps

1. **Create the skill structure** following this guide
2. **Test it locally** in Claude Code with real Radzen projects
3. **Iterate based on usage** - What works? What's missing?
4. **Consider sharing** - Submit to claude-plugins.dev or GitHub
5. **Keep updated** - Radzen releases new features regularly

Good luck creating your Radzen skill! This will be a valuable addition to the Claude Code ecosystem.
