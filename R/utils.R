style_name <- function(...) {
  x <- paste0(...)

  if (!is_installed("crayon")) {
    x
  } else {
    crayon::blue(x)
  }
}

invert <- function(x) {
  if (length(x) == 0) return()
  stacked <- utils::stack(x)
  tapply(as.character(stacked$ind), stacked$values, list)
}
