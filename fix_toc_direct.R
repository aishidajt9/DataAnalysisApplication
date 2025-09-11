#!/usr/bin/env Rscript
# TOC HTML files direct fix script
# Replaces JavaScript method with direct HTML manipulation after bookdown render

# Chapter mapping from titles to correct filenames
chapter_mapping <- list(
  "イントロダクション" = "index.html",
  "記述統計の復習" = "01-descritive.html",
  "推測統計の復習" = "02-inference.html", 
  "線形代数の基礎(1)" = "03-linear_algebra_1.html",
  "線形代数の基礎(2)" = "04-linear_algebra_2.html",
  "単回帰分析(1)" = "05-single_regression_1.html",
  "単回帰分析(2)" = "06-single_regression_2.html",
  "重回帰分析(1)" = "07-multi-regression_1.html",
  "重回帰分析(2)" = "08-multi-regression_2.html",
  "重回帰分析(3)" = "09-multi-regression_3.html",
  "ロジスティック回帰分析(1)" = "10-logistic-regression_1.html",
  "ロジスティック回帰分析(2)" = "11-logistic-regression_2.html"
)

fix_toc_in_file <- function(filepath) {
  # Read HTML file
  content <- readLines(filepath, encoding = "UTF-8", warn = FALSE)
  content <- paste(content, collapse = "\n")
  
  original_content <- content
  fixed_count <- 0
  
  # Fix each chapter mapping
  for (title in names(chapter_mapping)) {
    correct_file <- chapter_mapping[[title]]
    
    # Pattern to match chapter list items with this title
    # Matches: <li class="chapter" data-level="2" data-path="index.html"><a href="#アンカー">2 タイトル</a>
    pattern <- paste0(
      '(<li class="chapter"[^>]*data-path=")[^"]*',
      '("[^>]*><a[^>]*href=")[^"]*',  # href might be anchor link
      '("[^>]*>\\s*<i[^>]*></i>\\s*<b>\\d+</b>\\s*',
      gsub("([()\\[\\]])", "\\\\\\1", title),  # Escape special regex characters
      ')'
    )
    
    replacement <- paste0("\\1", correct_file, "\\2", correct_file, "\\3")
    
    new_content <- gsub(pattern, replacement, content, perl = TRUE)
    
    if (new_content != content) {
      fixed_count <- fixed_count + 1
      content <- new_content
    }
  }
  
  # Write back if changes were made
  if (content != original_content) {
    writeLines(content, filepath, useBytes = TRUE)
    cat("Fixed", fixed_count, "TOC links in:", basename(filepath), "\n")
    return(fixed_count)
  }
  
  return(0)
}

main <- function() {
  output_dir <- "../aishidajt9.github.io/DataAnalysisApplication"
  
  if (!dir.exists(output_dir)) {
    cat("Error: Output directory", output_dir, "does not exist\n")
    return(1)
  }
  
  # Find all HTML files in output directory
  html_files <- list.files(output_dir, pattern = "\\.html$", full.names = TRUE)
  
  if (length(html_files) == 0) {
    cat("No HTML files found in", output_dir, "\n")
    return(1)
  }
  
  total_fixes <- 0
  for (html_file in html_files) {
    fixes <- fix_toc_in_file(html_file)
    total_fixes <- total_fixes + fixes
  }
  
  cat("\nTotal: Fixed", total_fixes, "TOC links across", length(html_files), "HTML files\n")
  return(0)
}

# Run main function if script is executed directly
if (!interactive()) {
  quit(status = main())
}