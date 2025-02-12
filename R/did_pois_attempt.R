
# install.packages("dpm")
# library(dpm)

## DID calls DRDID to run 2X2 --> I updated outcome regression in DRDID to Poisson
## I downloaded my versions of DID and DRDID
library(stats)
library(tidyverse)
library(utils)
library(data.table)
library(BMisc)
library(dpm)

# Load packages from did without changing anything
## We use version 2 to avoid issues with get_wide_data() call
source("R/att_gt.R")
source("R/pre_process_did2.R")
source("R/DIDparams2.R")
source("R/compute.att_gt2.R")
source("R/process_attgt.R")
source("R/mboot.R")
source("R/MP.R")
source("R/compute.aggte.R")
source("R/AGGTEobj.R")
source("~/Dropbox (Personal)/Research/Projects/CSDID_Pois/reg_did_panel.R") # Load script from DRDID that changes model to poisson glm

load("~/Dropbox (Personal)/Research/Projects/CSDID_Pois/mpdta.rda")
mpdta <- mpdta %>%
  mutate(population = 100000)
data_in = mpdta
yname = "lemp"; tname = "year"; idname = "countyreal"; gname = "first.treat"; data = mpdta; est_method = "reg"; i.weights = "population"; control_group="notyettreated"

MP <- att_gt(yname = "lemp",
       tname = "year",
       idname = "countyreal",
       gname = "first.treat",
       data = mpdta,
       est_method = "reg",
       weightsname = "population",
       control_group="notyettreated",
       faster_mode = TRUE)


cs_result <- compute.aggte(MP,type = "group")
