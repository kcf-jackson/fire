## fire: convert an R function to a CLI

- This package has two functions. One converts an R function into a CLI, and the other converts a variable to accept CLI input.
- The idea is drawn from [python-fire](https://github.com/google/python-fire).
- Install the package with `remotes::install_github("kcf-jackson/fire")`; see usage below.
- Possible extensions in the future: multiple functions, logging, etc.


### Usage

#### add.R

```{r}
add <- function(x, y) {
  x + y
}

fire::fire(add)
```

If you want the function to also run in interactive mode, then provide the 
function arguments and set `run_interactive = TRUE`:
`fire::fire(add, x = 1, y = 2, run_interactive = TRUE)`.

#### At the terminal

```{bash}
Rscript add.R --x=3 --y=999
```

Use `help` to find out the function arguments:

```{bash}
Rscript add.R --help
The command-line interface expects 2 arguments: "x", "y".
```

---

#### test.R
```{r}
parameter <- fire::CLI_VAR(1, "param")
print(parameter)
```

#### At the terminal
```{bash}
Rscript test.R
[1] 1

Rscript test.R --param=999
[1] 999
```
