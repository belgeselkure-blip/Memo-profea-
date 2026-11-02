#!/bin/sh
# Enables this project's Claude Code plugins for every session of the current
# user by merging them into ~/.claude/settings.json (existing settings are kept).
set -eu

mkdir -p "$HOME/.claude"
python3 - "$HOME/.claude/settings.json" <<'EOF'
import json, os, sys

path = sys.argv[1]
settings = json.load(open(path)) if os.path.exists(path) else {}

marketplaces = {
    "superpowers-marketplace": "obra/superpowers-marketplace",
    "karpathy-skills": "forrestchang/andrej-karpathy-skills",
    "caveman": "JuliusBrussee/caveman",
    "ponytail": "DietrichGebert/ponytail",
    "ui-ux-pro-max-skill": "nextlevelbuilder/ui-ux-pro-max-skill",
    "thedotmack": "thedotmack/claude-mem",
    "headroom-marketplace": "chopratejas/headroom",
    "claude-plugins-official": "anthropics/claude-plugins-official",
}
plugins = [
    "superpowers@superpowers-marketplace",
    "andrej-karpathy-skills@karpathy-skills",
    "caveman@caveman",
    "ponytail@ponytail",
    "ui-ux-pro-max@ui-ux-pro-max-skill",
    "claude-mem@thedotmack",
    "headroom@headroom-marketplace",
    "claude-code-setup@claude-plugins-official",
]

known = settings.setdefault("extraKnownMarketplaces", {})
for name, repo in marketplaces.items():
    known[name] = {"source": {"source": "github", "repo": repo}}
enabled = settings.setdefault("enabledPlugins", {})
for plugin in plugins:
    enabled[plugin] = True

with open(path, "w") as f:
    json.dump(settings, f, indent=2)
    f.write("\n")
print(f"Enabled {len(plugins)} plugins in {path}")
EOF
