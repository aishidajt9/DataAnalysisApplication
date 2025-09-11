---
description: Complete bookdown render-to-publish workflow
argument-hint: [optional commit message]
allowed-tools: Bash
---

Complete workflow to render bookdown project and publish to GitHub Pages:

1. Render the bookdown project using `bookdown::render_book()`
2. Add all changes to git staging area
3. Commit changes with timestamp (or use custom message: $ARGUMENTS)
4. Push to main repository
5. Navigate to and push the rendered GitHub Pages repository

Execute this complete sequence:
```bash
Rscript -e "bookdown::render_book()" && git add . && git commit -m "${ARGUMENTS:-"Update content and render $(date '+%Y-%m-%d %H:%M')"}" && git push origin main && git -C "../aishidajt9.github.io/DataAnalysisApplication" add . && git -C "../aishidajt9.github.io/DataAnalysisApplication" commit -m "Update rendered site $(date '+%Y-%m-%d %H:%M')" && git -C "../aishidajt9.github.io/DataAnalysisApplication" push origin master
```

This ensures both the source repository and the GitHub Pages site are updated in one command.