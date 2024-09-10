# create_package.R

# Creates a package,
# must be in package directory,
# open in package Rproject

library(devtools)
# build(binary = TRUE)
build()
document()


check("C:\\Users\\Chief\\Dropbox\\graDiEnt_N")

# remove.packages("roxygen2")
# remove.packages("graDiEnt")
#
# pack_names <- installed.packages()
#
# pack_names |> View()

