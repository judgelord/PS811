## Run this script with `source(here("setup.R"))`

options(stringsAsFactors = F)

## Add any R packages you require. 
## Here are some we will use in 811:
requires <- c("tidyverse", # tidyverse includes dplyr and ggplot2
              "broom",
              "magrittr",
              "foreign",
              "readstata13",
              "maps",
              "sf",
              "here")

## Install any you don't have
to_install <- c(requires %in% rownames(installed.packages()) == FALSE)
install.packages(c(requires[to_install], "NA"), repos = "https://cloud.r-project.org/" )

## Load all required R packages
library(tidyverse)
library(broom)
library(ggplot2); theme_set(theme_bw())
library(magrittr)
library(foreign)
library(readstata13)
library(maps)
library(sf)
library(here)

# Xaringan settings
# remotes::install_github('gadenbuie/xaringanthemer')
# remotes::install_github('yihui/xaringan')
library("xaringan")
library("xaringanthemer")

## Sets defaults for R chunks
knitr::opts_chunk$set(echo = TRUE, # echo = TRUE means that your code will show
                      warning=FALSE,
                      message=FALSE,
                      fig.retina = 2,
                      fig.align = "center", 
                      dpi = 100,
                      fig.path='Figs/', ## where to save figures
                      fig.height = 3,
                      fig.width = 3)