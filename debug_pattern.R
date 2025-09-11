#!/usr/bin/env Rscript
# Debug pattern matching

content <- readLines("../aishidajt9.github.io/DataAnalysisApplication/index.html", encoding = "UTF-8", warn = FALSE)
content <- paste(content, collapse = "\n")

title <- "線形代数の基礎(1)"
escaped_title <- gsub("([()\\[\\]])", "\\\\\\1", title)

cat("Title:", title, "\n")
cat("Escaped title:", escaped_title, "\n")

# Let's test step by step
simple_pattern <- "線形代数の基礎\\(1\\)"
cat("Simple pattern:", simple_pattern, "\n")
simple_match <- grepl(simple_pattern, content, perl = TRUE)
cat("Simple pattern matches:", simple_match, "\n\n")

# Test pattern - match exactly: <i class="fa fa-check"></i>
pattern <- paste0(
  '(<li class="chapter"[^>]*data-path=")[^"]*',
  '("[^>]*><a[^>]*href=")[^"]*',
  '("[^>]*><i class="fa fa-check"></i><b>\\d+</b>\\s*',
  escaped_title,
  '</a>)'
)

cat("Pattern:", pattern, "\n\n")

# Extract the actual line to see what we're matching against
actual_line <- regmatches(content, regexpr('<li class="chapter"[^>]*>.*線形代数の基礎\\(1\\).*</a>', content, perl = TRUE))
cat("Actual HTML:\n", actual_line, "\n\n")

# Test if pattern matches
matches <- grepl(pattern, content, perl = TRUE)
cat("Pattern matches:", matches, "\n")

if (matches) {
  cat("SUCCESS: Pattern matches!\n")
} else {
  cat("FAIL: Pattern does not match\n")
}