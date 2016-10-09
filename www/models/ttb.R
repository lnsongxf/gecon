# ###################################################################
# (c) Chancellery of the Prime Minister 2012-2015                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence_models.txt #
#                                                                   #
# Author(s): Grzegorz Klima, Karol Podemski,                        #
#            Kaja Retkiewicz-Wijtiwiak                              #
# ###################################################################
# Time-to-build model
# Calibration based on Backus, Kehoe and Kydland (1992): 
# "International Real Business Cycles", Journal of Political Economy
# ###################################################################

# load gEcon package
library(gEcon)

# make and load the model
ttb <- make_model("ttb.gcn")

# find and print steady-state values
ttb <- steady_state(ttb)
get_ss_values(ttb, to_tex = TRUE, 
              variables = setdiff(get_var_names(ttb), 
                                  c("lambda__FIRM_2",
                                    "lambda__FIRM_S__lag_1",
                                    "lambda__FIRM_S__lag_2")))
get_par_values(ttb)

# find and print perturbation solution
ttb <- solve_pert(ttb, loglin = TRUE)
get_pert_solution(ttb, to_tex = TRUE)

# set the shock distribution parameters
ttb <- set_shock_cov_mat(ttb, matrix(c(0.1), 1, 1))

# compute and print correlations 
ttb <- compute_model_stats(ttb, ref_var = "Y")

get_model_stats(model = ttb, 
                variables = c("C", "K", "L", 
                              "LAMBDA", "N", 
                              "U", "Y", "W"),
                var_dec = FALSE,
                to_tex = TRUE)

# compute and print the IRFs for the epsilon_LAMBDA shock
plotirf <- compute_irf(ttb, variables = c("C", "K", "L", 
                                          "S", "Y", "N"), 
                       shocks = "epsilon_LAMBDA",
                       sim_length = 20)
plot_simulation(plotirf, to_eps = TRUE)

# print summary of the model results
summary(ttb)
