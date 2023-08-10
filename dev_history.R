#*******************************************************************************
#
# README
#
# The intention of this file is to collect all the commands you usually put
# directly into the console, e.g. `usethis::use_package()` etc.
#
# This should help not to forget to run some commands for initializing/updating
# package/project structure.
#
# See the dev_history.R of package mdseasy for some useful commands:
# https://gitlab.com/addium/software/data-science/packages/mdseasy/-/blob/main/dev_history.R
#
# The idea is to start a new section for each day you work on the package and
# write all your commands there.
#
#*******************************************************************************

# 2023-08-10 ----

# behavior of renv v1.0.0 ----
packageVersion("renv")

renv::snapshot(
  lockfile = "renv_cran.lock",
  type = "explicit",
  repos = getOption("repos")["CRAN"]
)

status = renv::status(lockfile = "renv_cran.lock")
status$synchronized

# behavior of renv github version ----
renv::install("rstudio/renv")
packageVersion("renv")

renv::snapshot(
  lockfile = "renv_github.lock",
  type = "explicit",
  repos = getOption("repos")["CRAN"]
)


# Fork ----
renv::install("cstepper/renv")
packageVersion("renv")

renv::snapshot(
  lockfile = "renv_fork_main.lock",
  type = "explicit",
  repos = getOption("repos")["CRAN"]
)


# PR ----
renv::install("cstepper/renv@explicit_snapshot")
packageVersion("renv")

renv::snapshot(
  lockfile = "renv_pr_snapshot.lock",
  type = "explicit",
  repos = getOption("repos")["CRAN"],
  dev = TRUE
)


# comparison ----
fls = dir(pattern = "*.lock") |>
  purrr::set_names() |>
  purrr::map(renv::lockfile_read)

# compare Github and local main
waldo::compare(fls$renv_github.lock, fls$renv_pr_snapshot.lock)

# status checks ----
renv::status(lockfile = "renv_pr_snapshot.lock", dev = TRUE)




# # workaround to include *Suggests* dependencies to lockfile ----
# packages = desc::desc_get_deps()
# # packages = renv:::renv_dependencies_impl(file.path("DESCRIPTION"), dev = TRUE)
# deps = c("renv", packages$package)
#
# renv::snapshot(
#   repos = getOption("repos")["CRAN"],
#   packages = deps,
#   lockfile = "renv_incl_dev.lock"
# )
#
# status = renv::status(lockfile = "renv_incl_dev.lock")
# status$synchronized
#
#
# # compare ----
# fls = dir(pattern = "*.lock") |>
#   purrr::set_names() |>
#   purrr::map(renv::lockfile_read)
#
# waldo::compare(fls$renv_incl_dev.lock, fls$renv.lock)
#
#
#
#
# # ----
# devtools::load_all("~/cstepper/mischmasch/renv/")
# packageVersion("renv")
#
# renv::snapshot(
#   repos = getOption("repos")["CRAN"],
#   lockfile = "renv_pr_snapshot.lock",
#   type = "explicit"# ,
#   # dev = TRUE
# )
#
# fls = dir(pattern = "*.lock") |>
#   purrr::set_names() |>
#   purrr::map(renv::lockfile_read)
#
# waldo::compare(fls$renv_incl_dev.lock, fls$renv_pr_snapshot.lock)


# 2023-08-02 ----

# checks for renv unloading issue
# https://github.com/rstudio/renv/issues/1621

rcmdcheck::rcmdcheck(
  args = c('--no-manual', '--no-build-vignettes', '--ignore-vignettes'),
  build_args = c('--no-manual', '--no-build-vignettes'),
  error_on = 'warning'
)


# 3) renv from github, NAMESPACE not filled --> OK
remotes::install_github("rstudio/renv")
packageDescription("renv")

rcmdcheck::rcmdcheck(
  args = c('--no-manual', '--no-build-vignettes', '--ignore-vignettes'),
  build_args = c('--no-manual', '--no-build-vignettes'),
  error_on = 'warning'
)


# 4) renv from github, NAMESPACE filled --> FAIL
remotes::install_github("rstudio/renv")
packageDescription("renv")

rcmdcheck::rcmdcheck(
  args = c('--no-manual', '--no-build-vignettes', '--ignore-vignettes'),
  build_args = c('--no-manual', '--no-build-vignettes'),
  error_on = 'warning'
)

