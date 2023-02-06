#' A utility tool to convert a function into a CLI
#' @name fire-package
#' @importFrom methods formalArgs
NULL


#' Convert a function into a CLI
#'
#' @param f A function; the function to be called with CLI.
#' @param ... Additional arguments to be passed to the function.
#' @param run_interactive TRUE / FALSE; whether to run the function also in
#' interactive mode. Default to FALSE.
#'
#' @examples
#' # # add.R
#' # add <- function(x, y) x + y
#' # fire::fire(add, x = 3, y = 4, TRUE)  # Generate result 1
#'
#' # # At terminal
#' # Rscript add.R --x=1 --y=2  # Reuse function to generate result 2
#' # Rscript add.R help  # Show what arguments are required
#'
#' @export
fire <- function(f, ..., run_interactive = FALSE) {
  if (interactive() && !run_interactive) {
    return(NULL)
  }

  if (interactive() && run_interactive) {
    return(do.call(f, list(...)))
  }

  # CLI call via Rscript
  cargs <- commandArgs(trailingOnly = TRUE)
  if (length(cargs) >= 1 && cargs[1] == "help") {
    fargs <- formalArgs(f)
    message(
      sprintf("The command-line interface expects %d arguments: %s.",
              length(fargs),
              paste(dQuote(fargs, "\""), collapse = ", "))
    )
    return(NULL)
  }

  args <- parse_args(cargs)
  result <- tryCatch(do.call(f, args), error = identity, warning = identity)
  result
}


# parse_args :: [string] -> list
parse_args <- function(args) {
  ret_args <- list()
  if (length(args) == 0) {
    return(ret_args)
  }
  # Example: c("--x=1", "--y=2")
  split_args <- strsplit(args, "=")
  var <- split_args |> sapply(\(x) substring(x[1], 3))
  val <- split_args |> sapply(\(x) parse_str(x[2]))
  ret_args[var] <- val
  ret_args
}


# parse_str :: string -> string | number
parse_str <- function(x) {
  y <- tryCatch(as.numeric(x), warning = identity, error = identity)
  ifelse(inherits(y, "warning"), x, y)
}
