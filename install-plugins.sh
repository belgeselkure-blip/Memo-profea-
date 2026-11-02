#!/bin/sh
# Installs this project's Claude Code plugins for the current user, so they
# apply to every session. Safe to re-run; a failing plugin does not stop the rest.

for repo in \
    forrestchang/andrej-karpathy-skills \
    JuliusBrussee/caveman \
    DietrichGebert/ponytail \
    nextlevelbuilder/ui-ux-pro-max-skill \
    thedotmack/claude-mem \
    chopratejas/headroom
do
    claude plugin marketplace add "$repo" || echo "marketplace failed: $repo"
done

for plugin in \
    andrej-karpathy-skills@karpathy-skills \
    caveman@caveman \
    ponytail@ponytail \
    ui-ux-pro-max@ui-ux-pro-max-skill \
    claude-mem@thedotmack \
    headroom@headroom-marketplace
do
    claude plugin install "$plugin" || echo "install failed: $plugin"
done
