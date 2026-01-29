# Shared Components Directory

**This directory contains reusable Radzen Blazor components.**

## When Working Here

✅ **ALWAYS consult:** `/.claude/skills/radzen-blazor/SKILL.md`

❌ **Critical Error:** Enum properties MUST use `@` prefix
```razor
@* WRONG *@ <RadzenStack Orientation="Orientation.Horizontal" />
@* RIGHT *@ <RadzenStack Orientation="@Orientation.Horizontal" />
```

## Key Files in This Directory

- **MainLayout.razor** - App layout (RadzenLayout, RadzenHeader, RadzenSidebar, RadzenBody)
  - ⚠️ MUST include `<RadzenComponents />` at end
- **NavMenu.razor** - Navigation (RadzenPanelMenu)
- **DynamicDataGrid.razor** - Generic data grid
- **GenericEntityPage.razor** - CRUD page template
- **EntityEditDialog.razor** - Edit dialog
- **SmartDataGrid.razor** - Advanced data grid with editing

## Resources

- **Radzen Skill:** `/.claude/skills/radzen-blazor/SKILL.md`
- **Component API:** `/.claude/skills/radzen-blazor/references/components-quick-ref.md`
- **Best Practices:** `/.claude/skills/radzen-blazor/references/best-practices.md`
