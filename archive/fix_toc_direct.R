#!/usr/bin/env Rscript
# TOC HTML files direct fix script
# Replaces JavaScript method with direct HTML manipulation after bookdown render

# Chapter mapping from data-level to correct filenames
level_to_file <- list(
  "1" = "index.html",
  "2" = "01-descritive.html",
  "3" = "02-inference.html", 
  "4" = "03-linear_algebra_1.html",
  "5" = "04-linear_algebra_2.html",
  "6" = "05-single_regression_1.html",
  "7" = "06-single_regression_2.html",
  "8" = "07-multi-regression_1.html",
  "9" = "08-multi-regression_2.html",
  "10" = "09-multi-regression_3.html",
  "11" = "10-logistic-regression_1.html",
  "12" = "11-logistic-regression_2.html"
)

fix_toc_in_file <- function(filepath) {
  # Read HTML file
  content <- readLines(filepath, encoding = "UTF-8", warn = FALSE)
  content <- paste(content, collapse = "\n")
  
  original_content <- content
  fixed_count <- 0
  
  # Fix each chapter by data-level
  for (level in names(level_to_file)) {
    correct_file <- level_to_file[[level]]
    
    # Pattern to match: <li class="chapter" data-level="4" data-path="anything"><a href="anything">
    # Replace both data-path and href with correct filename
    pattern <- paste0(
      '(<li class="chapter"[^>]*data-level="', level, '"[^>]*data-path=")[^"]*',
      '("[^>]*><a[^>]*href=")[^"]*',
      '(")'
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