% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fire.R
\name{CLI_VAR}
\alias{CLI_VAR}
\title{CLI variable}
\usage{
CLI_VAR(default, flag)
}
\arguments{
\item{default}{The default value.}

\item{flag}{A character string; the name of the flag.}
}
\description{
Make a variable accept CLI input.
}
\examples{
# # test.R
# parameter <- fire::CLI_VAR(1, "param")
# print(parameter)

# # At terminal
# Rscript test.R
# Rscript test.R --param=999

}
