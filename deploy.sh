#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting deployment process..."

# Build the project
echo "📦 Building the project..."
pnpm run build

# Store the current branch name
CURRENT_BRANCH=$(git branch --show-current)

# Create or checkout gh-pages branch
echo "🌿 Switching to gh-pages branch..."
if git show-ref --verify --quiet refs/heads/gh-pages; then
    git checkout gh-pages
else
    git checkout -b gh-pages
fi

# Remove everything except .git and out directory
echo "🧹 Cleaning up old files..."
git rm -rf . || true

# Move everything from out to root
echo "📂 Moving build files..."
mv out/* .

# Remove the out directory
rm -rf out

# Add all files
echo "📝 Adding files to git..."
git add .

# Commit
echo "💾 Committing changes..."
git commit -m "Deploy to GitHub Pages [skip ci]"

# Push to gh-pages branch
echo "⬆️ Pushing to gh-pages branch..."
git push origin gh-pages

# Go back to the original branch
echo "↩️ Switching back to $CURRENT_BRANCH branch..."
git checkout $CURRENT_BRANCH

echo "✅ Deployment process completed!"
echo "🌐 Your site should be live in a few minutes at: https://dizdar.github.io/dizdar-site/" 