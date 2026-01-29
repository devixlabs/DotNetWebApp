# CSS & Radzen UI Styling Guide

This guide covers Radzen Blazor theme integration and custom CSS for the DotNetWebApp project. Read this before making CSS or visual styling changes.

---

## Project UI Stack

This project uses **Radzen Blazor components and themes only**. Bootstrap is not included.

**Goal**: Keep styling consistent with the active Radzen theme and avoid hardcoded colors on layout containers.

**How Branding Works**: Branding colors and fonts are set via CSS variables in `MainLayout.razor` from `AppCustomizationOptions.BrandCustomization`.

---

## CSS File Structure

```
wwwroot/css/
└── app.css                          # Custom application styles (THIS FILE)
```

### app.css (Custom Styles)
**Location**: `/wwwroot/css/app.css`

**Purpose**: All custom application styling including:
- Radzen layout wrappers (`.app-layout`, `.app-header`, `.app-sidebar`, `.app-body`)
- Page-level spacing (`.body-content`)
- Any custom component tweaks
- CSS animations (`@keyframes pulse`, `spin`, `slideIn`)

**CSS Variables** are defined in app.css root and overridden in MainLayout.razor via inline `style` attribute:
- `--app-font-family` - "Space Grotesk" (from AppCustomizationOptions)
- `--app-primary` - Primary theme color (from AppCustomizationOptions)
- `--app-accent` - Accent color (from AppCustomizationOptions)
- `--app-header-bg` - Header background gradient (from AppCustomizationOptions)
- `--app-header-text` - Header text color (from AppCustomizationOptions)
- `--app-logo-bg` - Logo background (from AppCustomizationOptions)
- `--app-logo-text` - Logo text color (from AppCustomizationOptions)

**Rule**: Avoid hardcoded background or text colors on layout containers. Use CSS variables instead so they respect the active branding.

---

## Radzen Blazor Theme Configuration

### Theme Files
**Location**: `Pages/_Layout.cshtml`

**Current Configuration** (Material Light):
```html
<link href="_content/Radzen.Blazor/css/material-base.css" rel="stylesheet" />
<link href="_content/Radzen.Blazor/css/material.css" rel="stylesheet" />
```

**Radzen Version**: v7.1.0 (pinned in project, see DotNetWebApp.csproj)
**NuGet Package**: `Radzen.Blazor` 7.1.0

### Theme Options
Radzen offers multiple theme families:
- `material` / `material-dark` (currently in use)
- `default` / `default-dark`
- `humanistic` / `humanistic-dark`
- `software` / `software-dark`

**Switching Themes**:
1. Update CSS links in `Pages/_Layout.cshtml`
2. Consider updating CSS variables in `wwwroot/css/app.css` root for light/dark compatibility
3. Test readability of text and component colors

**Rule**: If you switch to a dark theme, ensure CSS variables (especially text colors) remain readable against the new background colors.

---

## Layout & Navigation Components

### Layout Structure

```
Shared/
  MainLayout.razor        <- RadzenLayout, RadzenHeader, RadzenSidebar, RadzenBody, RadzenComponents
                             CSS variables injected via BuildLayoutStyle()
  NavMenu.razor           <- RadzenPanelMenu with dynamic entity links
  DynamicDataGrid.razor   <- Generic data grid component (renders any entity)
  GenericEntityPage.razor <- Standalone CRUD page template (routable at /{EntityName})
Components/Pages/
  SpaApp.razor            <- Main SPA container with section routing (/app)
Components/Sections/
  EntitySection.razor     <- Entity CRUD within SPA (uses DynamicDataGrid)
  SettingsSection.razor   <- Settings UI with forms
  DashboardSection.razor  <- Dashboard metrics cards
  SectionHeader.razor     <- Reusable header component
```

### Key Containers
- `.app-layout` - Layout wrapper
- `.app-header` - Header row
- `.app-sidebar` - Sidebar container
- `.app-body` - Main content area
- `.body-content` - Content width constraint

### Important: RadzenComponents Directive
**Location**: End of `MainLayout.razor`

```razor
<RadzenComponents />
```

This directive is **required** for Radzen features like toast notifications, dialogs, and context menus. Always ensure it's present in the main layout.

---

## Radzen Component Property Syntax

### Critical: Enum Properties Require @ Prefix

**WRONG** (will cause compile error):
```razor
<RadzenStack Orientation="Orientation.Horizontal" AlignItems="Center" />
<RadzenPanelMenu DisplayStyle="MenuItemDisplayStyle.IconAndText" />
```

**CORRECT** (proper Razor syntax):
```razor
<RadzenStack Orientation="@Orientation.Horizontal" AlignItems="@AlignItems.Center" />
<RadzenPanelMenu DisplayStyle="@MenuItemDisplayStyle.IconAndText" />
```

### Common Radzen Enums in This Project
- `MenuItemDisplayStyle` - `Icon`, `Text`, `IconAndText`
- `Orientation` - `Horizontal`, `Vertical`
- `AlignItems` - `Start`, `Center`, `End`, `Stretch`
- `JustifyContent` - `Start`, `Center`, `End`, `SpaceBetween`, `SpaceAround`, `SpaceEvenly`
- `ButtonStyle` - `Primary`, `Secondary`, `Danger`, `Warning`, `Success`, `Light`, `Info`
- `TextStyle` - `H1`, `H2`, `H3`, `H4`, `H5`, `H6`, `Subtitle1`, `Subtitle2`, `Body1`, `Body2`, `Caption`, `Overline`
- `AlertStyle` - `Danger`, `Warning`, `Info`, `Success`
- `Variant` - `Filled`, `Flat`, `Outlined`, `Text`
- `Shade` - `Default`, `Lighter`, `Darker`, `Light`, `Dark`
- `DataGridEditMode` - `Single`, `Multiple`
- `ButtonSize` - `Small`, `Medium`, `Large`
- `TextAlign` - `Left`, `Center`, `Right`
- `TagName` - `H1`, `H2`, `H3`, `H4`, `H5`, `H6`, `P`, `Span`, `Div`

---

## Radzen Components Used in This Project

### Layout & Structure
- **RadzenLayout** - Main application layout wrapper (see MainLayout.razor)
- **RadzenHeader** - Application header with logo and navigation
- **RadzenSidebar** - Collapsible sidebar with navigation menu
- **RadzenBody** - Main content area
- **RadzenSidebarToggle** - Toggle button for sidebar
- **RadzenComponents** - Required directive for dialogs/notifications (end of MainLayout.razor)

### Navigation
- **RadzenPanelMenu** - Hierarchical navigation menu (see NavMenu.razor)
- **RadzenPanelMenuItem** - Individual menu items with icons
- **RadzenLink** - Hyperlinks with Radzen styling

### Layout Containers
- **RadzenStack** - Flexible vertical/horizontal layout (see DashboardSection.razor)
- **RadzenRow** - Responsive grid row
- **RadzenColumn** - Responsive grid column with size breakpoints
- **RadzenCard** - Card container for content grouping

### Data Display
- **RadzenDataGrid** - Advanced data grid with sorting, filtering, paging, editing (see SmartDataGrid.razor)
- **RadzenDataGridColumn** - Grid column configuration
- **RadzenText** - Styled text with typography variants
- **RadzenLabel** - Form labels

### Forms & Input
- **RadzenTextBox** - Text input field
- **RadzenNumeric<T>** - Numeric input with type safety
- **RadzenButton** - Styled buttons with icons
- **RadzenFieldset** - Form fieldset container

### Feedback & Notifications
- **RadzenAlert** - Alert/message boxes (see DashboardSection.razor)
- **DialogService** - Modal dialog service (injected)
- **NotificationService** - Toast notification service (injected)

### Services (Injected)
```csharp
@inject DialogService DialogService
@inject NotificationService NotificationService
```

**Required Setup:**
1. Add `builder.Services.AddRadzenComponents();` in Program.cs
2. Add `<RadzenComponents />` at end of MainLayout.razor
3. Include Radzen CSS/JS in _Layout.cshtml

---

## Common CSS Issues & Solutions

### Issue: Compile Error "Name does not exist in current context"
**Cause**: Radzen enum property missing `@` prefix (e.g., `DisplayStyle="MenuItemDisplayStyle.IconAndText"`).

**Solution**: Always prefix enum expressions with `@`:
- ✅ `DisplayStyle="@MenuItemDisplayStyle.IconAndText"`
- ✅ `AlignItems="@AlignItems.Center"`
- ✅ `Orientation="@Orientation.Horizontal"`

### Issue: Invisible Text After Theme Change
**Cause**: Theme switch without updating custom colors.

**Solution**:
1. Verify the theme links in `Pages/_Layout.cshtml`
2. Remove or adjust hardcoded colors in `wwwroot/css/app.css`
3. Let Radzen theme variables drive component colors

### Issue: Styles Not Updating
**Cause**: Browser cache or non-hot-reloaded files.

**Solutions**:
- **For `.css` files**: Hard refresh (`Ctrl+Shift+R` or `Cmd+Shift+R`)
- **For `.cshtml` files**: Restart server (`make dev` or `make run`)

---

## Hot Reload Behavior

### What Hot Reloads (No Server Restart Needed)
- `.css` files in `wwwroot/css/`
- `.razor` component files
- C# code in components
- JavaScript files in `wwwroot/js/`

### What Requires Server Restart
- `.cshtml` files (Razor pages, `_Layout.cshtml`, `_Host.cshtml`)
- `Program.cs` configuration
- Service registrations

**Development Command**: `make dev` (uses `dotnet watch` for hot reload)

---

## CSS Best Practices for This Project

1. Prefer Radzen components over raw HTML elements when possible.
2. Use Radzen theme classes and component properties before custom CSS.
3. Keep layout containers neutral; let the theme define colors.
4. Group related styles in `app.css` with section comments when needed.
5. **Always use `@` prefix for enum properties** in Radzen components (see Radzen Component Property Syntax section above).
6. For component-specific styles, use scoped `<style>` blocks within the `.razor` component file.
7. For shared layout styles, add to `wwwroot/css/app.css`.

---

## Testing Checklist

After making CSS changes, verify:

- [ ] Text is visible on all backgrounds
- [ ] Sidebar and header align correctly at mobile sizes
- [ ] Radzen components render with expected theme colors
- [ ] Hard refresh browser to clear CSS cache

---

## Section Components Reference

This project includes several key section components for the SPA:

- `Components/Pages/SpaApp.razor` - Main SPA container with dynamic section routing (`/app`)
- `Components/Pages/GenericEntityPage.razor` - Standalone CRUD page template (`/{EntityName}`)
- `Shared/DynamicDataGrid.razor` - Reusable data grid that renders any entity from YAML definitions
- `Components/Sections/DashboardSection.razor` - Dashboard with entity count metrics
- `Components/Sections/EntitySection.razor` - Dynamic entity CRUD section (used within SPA)
- `Components/Sections/SettingsSection.razor` - Application settings interface
- `Components/Sections/SectionHeader.razor` - Reusable header component with title and loading state

These components are loaded dynamically by the main SPA page and styled with scoped CSS blocks in each `.razor` file.

---

## Common Patterns in This Project

### Dashboard Cards (DashboardSection.razor)
```razor
<RadzenRow Gap="20px">
    <RadzenColumn Size="12" Medium="6" Large="3">
        <RadzenCard>
            <RadzenStack Gap="8px">
                <RadzenText Text="Total Products" TextStyle="@TextStyle.Subtitle2" />
                <RadzenText Text="@count.ToString()" TextStyle="@TextStyle.H4" />
            </RadzenStack>
        </RadzenCard>
    </RadzenColumn>
</RadzenRow>
```

### Error Alerts (DashboardSection.razor)
```razor
@if (!string.IsNullOrEmpty(errorMessage))
{
    <RadzenAlert AlertStyle="@AlertStyle.Danger" Variant="@Variant.Flat" Shade="@Shade.Lighter">
        <RadzenText TextStyle="@TextStyle.Subtitle2" TagName="@TagName.H4">Error</RadzenText>
        <RadzenText>@errorMessage</RadzenText>
    </RadzenAlert>
}
```

### Action Buttons in DataGrid (SmartDataGrid.razor)
```razor
<RadzenDataGridColumn TItem="T" Title="Actions" Width="120px" TextAlign="@TextAlign.Center">
    <Template Context="row">
        <RadzenButton Icon="edit"
                    Size="@ButtonSize.Small"
                    Click="@(_ => OnEdit(row))"
                    ButtonStyle="@ButtonStyle.Light" />
        <RadzenButton Icon="delete"
                    Size="@ButtonSize.Small"
                    Click="@(_ => OnDelete(row))"
                    ButtonStyle="@ButtonStyle.Danger" />
    </Template>
</RadzenDataGridColumn>
```

### Form Layout (EntityEditDialog.razor)
```razor
<RadzenFieldset Text="Edit Entity">
    <RadzenStack Gap="12px">
        <div class="rz-form-group">
            <RadzenLabel Text="Name" />
            <RadzenTextBox @bind-Value="@entity.Name" />
        </div>
    </RadzenStack>
</RadzenFieldset>

<RadzenStack Orientation="@Orientation.Horizontal" JustifyContent="@JustifyContent.End" Gap="8px">
    <RadzenButton Text="Cancel" ButtonStyle="@ButtonStyle.Light" Click="@Cancel" />
    <RadzenButton Text="Save" ButtonStyle="@ButtonStyle.Primary" Click="@Save" />
</RadzenStack>
```

---

## Resources

- **Radzen Blazor Docs**: https://blazor.radzen.com/
- **Radzen Themes**: https://blazor.radzen.com/themes
- **Radzen Component API**: https://blazor.radzen.com/docs/api/
- **Project Root SKILLS.md**: `/SKILLS.md` (Blazor components and JavaScript interop)
- **Radzen Claude Code Skill**: `/.claude/skills/radzen-blazor/SKILL.md` (comprehensive Radzen component reference for Claude Code)

---

## Quick Debugging Checklist

When build fails with enum-related errors:
1. ✅ Check that all enum properties use `@` prefix (e.g., `@MenuItemDisplayStyle.IconAndText`)
2. ✅ Verify the enum name is correct (e.g., `MenuItemDisplayStyle`, not `MenuDisplayStyle`)
3. ✅ Run `make build` to validate changes
4. ✅ For hot-reload issues with `.cshtml` files, restart with `make dev`
