# CSS & UI Styling Guide

This guide covers CSS, Bootstrap, and Radzen Blazor theme integration for the DotNetWebApp project. Read this BEFORE making CSS or visual styling changes.

---

## Critical Context: Theme Conflicts

### The Problem
This project uses **Bootstrap defaults** (light theme) with **Radzen Blazor components**. Mismatched themes cause invisible text and UI elements:
- Light text on light backgrounds = invisible
- Dark backgrounds with dark text = invisible

### The Solution
**Always maintain theme consistency across all CSS files and component configurations.**

---

## CSS File Structure

```
wwwroot/css/
├── app.css                          # Custom application styles (THIS FILE)
└── bootstrap/
    └── bootstrap.min.css           # Minimal Bootstrap CSS (INCOMPLETE)
```

### app.css (Custom Styles)
**Location**: `/wwwroot/css/app.css`

**Purpose**: All custom application styling including:
- Layout structure (`.page`, `.sidebar`, `.top-row`)
- Navigation styling (`.nav-item`, `.navbar-brand`)
- Bootstrap component supplements (`.navbar-toggler-icon`, `.navbar-dark .navbar-toggler`)
- CSS animations (`@keyframes pulse`, `spin`, `slideIn`)

**Key Rule**: Never add hardcoded `background-color` or `color` to layout containers (`.top-row`, `.page`, etc.) that might conflict with theme classes.

### bootstrap.min.css (Minimal Bootstrap)
**Location**: `/wwwroot/css/bootstrap/bootstrap.min.css`

**Status**: Intentionally minimal - only includes basic utility classes.

**What's MISSING** (must be added to `app.css` if needed):
- `.navbar-toggler-icon` - hamburger menu icon SVG
- `.navbar-dark` variants - dark navbar button/link styling
- Full button styles
- Form controls
- Grid system
- Most Bootstrap components

**First line comment**: `/* Minimal Bootstrap CSS - replace with full Bootstrap if needed */`

---

## Radzen Blazor Theme Configuration

### Theme Files
**Location**: `Pages/_Layout.cshtml` (lines 10-11)

**Current Configuration** (Light Theme):
```html
<link href="_content/Radzen.Blazor/css/material-base.css" rel="stylesheet" />
<link href="_content/Radzen.Blazor/css/material.css" rel="stylesheet" />
```

### Theme Options

**Light Theme** (current):
```html
<link href="_content/Radzen.Blazor/css/material-base.css" rel="stylesheet" />
<link href="_content/Radzen.Blazor/css/material.css" rel="stylesheet" />
```
- ✓ Compatible with Bootstrap defaults (white background, dark text)
- ✓ Good for projects using standard light mode

**Dark Theme** (causes conflicts):
```html
<link href="_content/Radzen.Blazor/css/material-dark-base.css" rel="stylesheet" />
<link href="_content/Radzen.Blazor/css/material-dark.css" rel="stylesheet" />
```
- ✗ Light text on Bootstrap's light background = invisible
- ✗ Requires dark background throughout application
- ⚠️ Only use if entire app is dark-themed

### Other Radzen Themes
Radzen offers multiple theme families:
- `material` / `material-dark`
- `default` / `default-dark`
- `humanistic` / `humanistic-dark`
- `software` / `software-dark`

**Rule**: Choose theme based on your Bootstrap/global background color.

---

## Bootstrap Integration

### Default Bootstrap Behavior
- **Background**: White (`#fff`)
- **Text**: Dark (`#212529`)
- **Links**: Blue (`#0d6efd`)

### Minimal Bootstrap CSS Included
Our `bootstrap.min.css` only includes:
```css
.container-fluid, .navbar, .navbar-dark, .navbar-brand, .navbar-toggler,
.nav-link, .alert, .alert-secondary, .btn, .mt-4, .px-3, .px-4, .me-2,
.flex-column, .collapse, .d-flex, .text-nowrap
```

### Bootstrap Components That Need Custom CSS

#### 1. Navbar Toggler (Hamburger Menu)
**Problem**: Minimal Bootstrap CSS lacks `.navbar-toggler-icon` styling.

**Solution** (in `app.css`):
```css
.navbar-toggler-icon {
    display: inline-block;
    width: 1.5em;
    height: 1.5em;
    vertical-align: middle;
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.85%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: center;
    background-size: 100%;
}
```

**Key Points**:
- Uses SVG data URI for hamburger icon (three horizontal lines)
- Stroke color is `rgba(255, 255, 255, 0.85)` for dark navbars
- Change stroke color if using light navbar theme

#### 2. Dark Navbar Styling
**Problem**: `.navbar-dark` class doesn't style the toggler button in minimal Bootstrap.

**Solution** (in `app.css`):
```css
.navbar-dark .navbar-toggler {
    color: rgba(255, 255, 255, 0.85);
    border-color: rgba(255, 255, 255, 0.5);
    background-color: rgba(255, 255, 255, 0.08);
}

.navbar-dark .navbar-toggler:hover,
.navbar-dark .navbar-toggler:focus {
    border-color: rgba(255, 255, 255, 0.75);
    background-color: rgba(255, 255, 255, 0.15);
}
```

**Key Points**:
- Default state: visible border (50% opacity) and subtle background (8% opacity)
- Hover/focus state: brighter border (75% opacity) and more prominent background (15% opacity)
- Ensures button is always visible, not just on interaction

---

## Common CSS Issues & Solutions

### Issue 1: Invisible Text After Theme Change
**Symptoms**: Text appears very light gray or invisible.

**Causes**:
- Radzen dark theme (light text) with Bootstrap light background
- Hardcoded `background-color` in CSS overriding theme colors
- `.top-row` or container divs with fixed colors

**Solution**:
1. Check `Pages/_Layout.cshtml` for Radzen theme files
2. Verify theme matches your Bootstrap background (light or dark)
3. Remove hardcoded `background-color` from layout containers in `app.css`
4. Let theme classes and component styles handle colors

### Issue 2: Invisible Navbar Toggler Button
**Symptoms**: Button shows as empty box or light gray box.

**Causes**:
- Missing `.navbar-toggler-icon` SVG background-image
- Wrong stroke color in SVG (dark stroke on dark background)
- Missing border or background styling

**Solution**:
1. Add `.navbar-toggler-icon` styling with SVG (see Bootstrap Components section)
2. Add `.navbar-dark .navbar-toggler` styling for visibility
3. Ensure stroke color contrasts with navbar background

### Issue 3: CSS Changes Not Appearing
**Causes**:
- Browser CSS cache
- `.cshtml` files require server restart (not hot-reloadable)
- Old CSS still served

**Solutions**:
- **For `.css` files**: Hard refresh browser (`Ctrl+Shift+R` or `Cmd+Shift+R`)
- **For `.cshtml` files**: Stop server (`Ctrl+C`) and restart with `make dev` or `make run`
- **Clear browser cache**: DevTools > Network tab > "Disable cache" checkbox

### Issue 4: Layout Containers Forcing Wrong Colors
**Symptoms**: Theme changes don't affect certain sections.

**Causes**:
- Hardcoded `background-color` or `color` in CSS
- Example: `.top-row { background-color: #f7f7f7; }`

**Solution**:
- Remove hardcoded colors from layout containers
- Let Bootstrap classes (`.navbar-dark`, `.bg-*`) and Radzen themes control colors
- Only add colors to specific components, not layout wrappers

---

## Blazor Component Styling

### Where Styles Are Applied

```
Pages/
  _Layout.cshtml          <- Loads CSS files, sets <head>
Shared/
  MainLayout.razor        <- Uses .page, .sidebar, .top-row
  NavMenu.razor           <- Uses .navbar-dark, .navbar-toggler
Components/Pages/
  Home.razor              <- Inherits MainLayout styles
  SpaApp.razor            <- Inherits MainLayout styles
```

### CSS Class Hierarchy
1. **Radzen theme** (loaded first in `_Layout.cshtml`)
2. **Bootstrap** (loaded second)
3. **Custom app.css** (loaded last, overrides above)

**Rule**: Specific selectors in `app.css` override generic Radzen/Bootstrap styles.

### Component-Specific Styling

**NavMenu.razor** uses:
- `.top-row` - header bar in sidebar
- `.navbar-dark` - dark theme navbar
- `.navbar-toggler` - hamburger menu button
- `.navbar-brand` - app name/logo
- `.nav-item`, `.nav-link` - navigation links

**MainLayout.razor** uses:
- `.page` - root container
- `.sidebar` - left navigation panel
- `.top-row` - top bar in main content area

---

## Hot Reload Behavior

### What Hot Reloads (No Server Restart Needed)
- ✓ `.css` files in `wwwroot/css/`
- ✓ `.razor` component files
- ✓ C# code in components
- ✓ JavaScript files in `wwwroot/js/`

### What Requires Server Restart
- ✗ `.cshtml` files (Razor pages, `_Layout.cshtml`, `_Host.cshtml`)
- ✗ `Program.cs` configuration
- ✗ Service registrations

**Development Command**: `make dev` (uses `dotnet watch` for hot reload)

**Production-like Command**: `make run` (no hot reload)

---

## CSS Best Practices for This Project

### 1. Theme Consistency
- Keep Radzen theme aligned with Bootstrap background expectations
- Test UI changes with both light and dark themes if supporting both
- Never mix light theme text colors with dark theme backgrounds

### 2. Color Usage
- Avoid hardcoded hex colors in layout containers
- Use `rgba()` with opacity for overlays and subtle backgrounds
- Use CSS custom properties (`--variable-name`) for repeated colors

### 3. Component Styling
- Check minimal Bootstrap CSS first before adding styles
- Add missing Bootstrap component styles to `app.css`
- Document why custom styles are needed (comment in CSS)

### 4. Browser Compatibility
- Test navbar toggler on mobile viewport (< 768px)
- Use vendor prefixes for animations if needed
- Test hard refresh behavior after CSS changes

### 5. Maintenance
- Keep comment at top of `bootstrap.min.css`: `/* Minimal Bootstrap CSS - replace with full Bootstrap if needed */`
- Group related styles in `app.css` with section comments
- Document theme conflicts and resolutions in this file

---

## Testing Checklist

After making CSS changes, verify:

- [ ] Text is visible on all backgrounds (light and dark areas)
- [ ] Navbar toggler button shows hamburger icon
- [ ] Navbar toggler button visible in default state (not just hover)
- [ ] Hover states provide visual feedback
- [ ] Hard refresh browser to clear CSS cache
- [ ] Test on mobile viewport (< 768px) if navbar-related
- [ ] Check browser console for CSS errors or warnings
- [ ] Verify no theme conflicts (light text on light bg, etc.)

---

## Quick Reference: Current Configuration

### Active Theme
- **Radzen**: Material Light (`material-base.css`, `material.css`)
- **Bootstrap**: Default light theme (white background, dark text)
- **Compatibility**: ✓ Matched

### Custom CSS Location
- **File**: `/wwwroot/css/app.css`
- **Purpose**: Layout, navigation, Bootstrap supplements, animations

### Bootstrap Supplements in app.css
- `.navbar-toggler-icon` - Hamburger menu SVG (lines 31-40)
- `.navbar-dark .navbar-toggler` - Dark navbar button visibility (lines 42-52)

### Key Containers
- `.page` - Root flex container
- `.sidebar` - Left nav with gradient background
- `.top-row` - Top bar (no hardcoded background color)

### Known Limitations
- Minimal Bootstrap CSS lacks most components
- Must add component styles to `app.css` as needed
- `.cshtml` changes require server restart

---

## History of Issues & Resolutions

### Jan 2, 2026 - Theme Conflict Resolution
**Issue**: "Hello, SPA!" text invisible on home page, navbar toggler showing as grey box.

**Root Causes**:
1. `Pages/_Layout.cshtml` had Radzen dark theme CSS (light text)
2. Bootstrap defaults use white background
3. `.top-row` in `app.css` had hardcoded `background-color: #f7f7f7`
4. Minimal Bootstrap CSS missing `.navbar-toggler-icon` and `.navbar-dark` variants

**Resolutions**:
1. Changed `_Layout.cshtml` to Radzen light theme (`material.css` instead of `material-dark.css`)
2. Removed `background-color: #f7f7f7` from `.top-row` in `app.css`
3. Added `.navbar-toggler-icon` with white SVG hamburger icon to `app.css`
4. Added `.navbar-dark .navbar-toggler` styling with visible border/background to `app.css`

**Lesson**: Always match Radzen theme to Bootstrap background expectations. Remove hardcoded colors from layout containers.

---

## Future Considerations

### If Switching to Full Bootstrap
1. Replace `wwwroot/css/bootstrap/bootstrap.min.css` with full Bootstrap 5 CSS
2. Remove Bootstrap supplement styles from `app.css` (navbar-toggler-icon, etc.)
3. Test for style conflicts between full Bootstrap and Radzen
4. Update this guide with new configuration

### If Adding Dark Mode Toggle
1. Create separate Radzen dark theme CSS references
2. Add JavaScript to swap stylesheets dynamically
3. Store user preference in localStorage
4. Update all hardcoded colors to use CSS custom properties
5. Test navbar toggler SVG stroke color for both themes

### If Adding Custom Radzen Theme
1. Follow Radzen theme customization guide
2. Ensure base colors match Bootstrap or override Bootstrap defaults
3. Test all Radzen components (DataGrid, Dialog, Notification, etc.)
4. Document theme files in this guide

---

## Resources

- **Radzen Blazor Docs**: https://blazor.radzen.com/
- **Radzen Themes**: https://blazor.radzen.com/themes
- **Bootstrap 5 Docs**: https://getbootstrap.com/docs/5.0/
- **Blazor CSS Isolation**: https://learn.microsoft.com/en-us/aspnet/core/blazor/components/css-isolation
- **Project Root SKILLS.md**: `/SKILLS.md` (Blazor components and JavaScript interop)
