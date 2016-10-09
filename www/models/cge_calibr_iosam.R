# ############################################################################
# This file is a part of gEcon.iosam.                                        #
#                                                                            #
# (c) Chancellery of the Prime Minister of the Republic of Poland 2014-2015  #
# (c) Marta Retkiewicz 2015-2016                                             #
# Licence terms can be found in the file:                                    #
# http://gecon.r-forge.r-project.org/files/gEcon.iosam_licence.txt           #
#                                                                            #
# Author: Marta Retkiewicz                                                   #
# ############################################################################
# Example for gEcon.iosam package: calibration of a CGE model
# ############################################################################


# Loading gEcon.iosam (and gEcon) package
library(gEcon.iosam)


# Importing data
data_file <- file.path(system.file("extdata", package = "gEcon.iosam"),
                       "calibr_sam.csv")
map_file <- file.path(system.file("extdata", package = "gEcon.iosam"),
                      "calibr_map.csv")

flowdata <- read_iosam(data_file,
                       nproducts = c(8, 8),
                       table_ind = c(2, 2),
                       data_ind = c(3, 3),
                       data_dim = c(18, 18),
                       products_ind = c(10, 10))
map <- read.csv(map_file, header = FALSE, sep = ";")
sam <- aggregate_iosam(flowdata, map)
sam <- sam / 1e6
summary(sam)


# Building model from the .gcn file
model <- make_model("cge_calibr_iosam.gcn")


# Calibration
sam_prod <- c("ProductsA", "ProductsB", "ProductsC")
gcn_prod <- c("A", "B", "C")
n <- length(gcn_prod)
sam_hhds <- c("Small_hh", "Large_hh")
gcn_hhds <- c("s", "l")
m <- length(gcn_hhds)
scale_h <- c(10, 4)


# Setting free parameters' values
model <- set_free_par(model, c(k_f_data    = sam["Firms", "K"],
                               ks_data     = sam["SUM", "K"],
                               ls_data     = sam["SUM", "L"],
                               omega       = 2,
                               get_flow_values(sam["L", sam_prod], "l_data", gcn_prod),
                               get_flow_values(sam["SUM", sam_prod], "y_data", gcn_prod),
                               get_flow_values(sam[sam_prod, sam_prod], "x_data", gcn_prod, gcn_prod),
                               get_flow_values(sam["Large_hh", "Firms"], "cap_data", "l"),
                               get_flow_values(sam["Large_hh", "L"], "l_data", "l"),
                               get_flow_values(scale_h, "scale",  gcn_hhds),
                               get_flow_values(sam[sam_hhds, "K"], "k_data", gcn_hhds),
                               get_flow_values(sam[7:8, sam_hhds], "d_data", c("B", "C"), gcn_hhds)
                               ))


# Setting initial values for calibrated parameters
model <- initval_calibr_par(model, c(get_flow_values(rep(1/2, n), "beta_k", gcn_prod),
                                     get_flow_values(rep(1/2, n), "beta_l", gcn_prod),
                                     get_flow_values(matrix(4, n, n), "beta_x", gcn_prod, gcn_prod),
                                     get_flow_values(rep(10, n), "gamma_yva", gcn_prod)
                                     ))


# Setting initial values for all variables
varnames <- get_var_names(model)
varlist <- rep(40, length(varnames))
varlist <- as.list(varlist)
names(varlist) <- varnames
model <- initval_var(model, varlist)


# Finding equilibrium
model <- steady_state(model)
ss <- get_ss_values(model, to_tex = TRUE)
par <- get_par_values(model, to_tex = TRUE)

