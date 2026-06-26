#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# Boundary Builder — GitHub push script
# ─────────────────────────────────────────────────────────────────

set -e

echo ""
echo "🌿 Cleaning up lock files..."
rm -f .git/HEAD.lock .git/refs/heads/master.lock .git/objects/maintenance.lock
find .git -name "*.lock" -delete 2>/dev/null || true

echo "🌿 Renaming branch to main..."
git branch -m master main 2>/dev/null || true

echo ""
echo "You need a GitHub Personal Access Token to push."
echo "Get one at: https://github.com/settings/tokens"
echo "(Tokens classic → Generate new → check 'repo' scope → Generate)"
echo ""
echo "Paste your token here (it WILL be visible — that's intentional):"
read -r TOKEN

echo ""
echo "🌿 Setting up remote with token..."
git remote remove origin 2>/dev/null || true
git remote add origin "https://ahappyhippiewraps:${TOKEN}@github.com/ahappyhippiewraps/boundaries-builder.git"

echo "🌿 Pushing to GitHub..."
git push -u origin main

# Store cleanly in keychain, remove token from remote URL
git remote set-url origin https://github.com/ahappyhippiewraps/boundaries-builder.git

echo ""
echo "✅ Done! https://github.com/ahappyhippiewraps/boundaries-builder"
echo "Next: connect Netlify to this repo for auto-deploys."
