options(stringsAsFactors = F)

## Add any R packages you require. 
## Here are some we will use in 811:
requires <- c("tidyverse", # tidyverse includes dplyr and ggplot2
              "magrittr",
              "foreign",
              "readstata13",
              "sf",
              "here")

## Install any you don't have
to_install <- c(requires %in% rownames(installed.packages()) == FALSE)
install.packages(c(requires[to_install], "NA"), repos = "https://cloud.r-project.org/" )

## Load all required R packages
library(tidyverse)
library(ggplot2); theme_set(theme_bw())
library(magrittr)
library(foreign)
library(readstata13)
library(sf)
library(here)

# Xaringan settings
# remotes::install_github('gadenbuie/xaringanthemer')
# remotes::install_github('yihui/xaringan')
library("xaringan")
library("xaringanthemer")