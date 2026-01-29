# Radzen Components Directory

**This directory uses Radzen Blazor components for all UI.**

## When Working Here

✅ **ALWAYS consult:** `/.claude/skills/radzen-blazor/SKILL.md`

❌ **Common Error:** Enum properties MUST use `@` prefix
```razor
@* WRONG *@ <RadzenButton ButtonStyle="ButtonStyle.Primary" />
@* RIGHT *@ <RadzenButton ButtonStyle="@ButtonStyle.Primary" />
```

## Directory Structure

```
Components/
├── Pages/              # Routable pages (@page directive)
├── Sections/           # SPA section components
└── Shared/             # Reusable components
```

## Resources

- **Radzen Skill:** `/.claude/skills/radzen-blazor/SKILL.md`
- **Component API:** `/.claude/skills/radzen-blazor/references/components-quick-ref.md`
- **Best Practices:** `/.claude/skills/radzen-blazor/references/best-practices.md`
