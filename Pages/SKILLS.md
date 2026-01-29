# Pages Directory (Razor Pages)

**This directory contains Blazor host pages with Radzen CSS/JS references.**

## When Working Here

✅ **ALWAYS consult:** `/.claude/skills/radzen-blazor/SKILL.md`

⚠️ **Important:** Changes to `.cshtml` files require server restart (`make dev`)

## Key Files

### _Layout.cshtml
Contains Radzen theme CSS/JS references:
```html
<head>
    <link href="_content/Radzen.Blazor/css/material-base.css" rel="stylesheet" />
    <link href="_content/Radzen.Blazor/css/material.css" rel="stylesheet" />
</head>
<body>
    <script src="_framework/blazor.server.js"></script>
    <script src="_content/Radzen.Blazor/Radzen.Blazor.js"></script>
</body>
```

**Current Theme:** Material Light (v7.1.0)

**Load Order Matters:**
1. Radzen base CSS → theme CSS → app.css
2. blazor.server.js → Radzen.Blazor.js

### _Host.cshtml
Main Blazor Server entry point

## Theme Switching

Available themes: `material`, `default`, `humanistic`, `software` (each has `-dark` variant)

Change both references in `_Layout.cshtml` and restart server.

## Resources

- **Radzen Skill:** `/.claude/skills/radzen-blazor/SKILL.md`
- **Setup & Themes:** `/.claude/skills/radzen-blazor/references/setup-patterns.md`
- **Official Themes:** https://blazor.radzen.com/themes
