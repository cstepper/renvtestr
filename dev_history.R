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

