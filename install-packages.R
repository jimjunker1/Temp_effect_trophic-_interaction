# Install pacman if it isn't alread installed 
if('pacman' %in% rownames(installed.packages()) == FALSE) install.packages('pacman')

# Install packages required for analysis
# Add any packages required for your data cleaning and manipulation to the
# `p_load` function call below
# Do not remove the packages already listed here
# they are important for running the livedat repository
# OG package list: pacman::p_load(git2r, httr, semver, testthat, yaml)

pacman::p_load(tidyverse, deSolve, meteor, scales)

pacman::p_load_gh(c("jimjunker1/junkR"))#, "ropensci/rfishbase"))

# theme_mod <<- theme_bw() %+replace% theme(panel.grid = element_blank())
theme_set(theme_mod)

'%ni%' <<- Negate('%in%')