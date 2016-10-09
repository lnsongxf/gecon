# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# Stochastic growth model with Epstein-Zin preferences
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
ez <- make_model("epstein_zin.gcn")

# set initial value for calibrated parameter alpha
ez <- initval_calibr_par(ez, c(alpha = 0.4))

# find and print steady-state values for parameter 
# alpha as calibrated parameter
ez <- steady_state(ez) 
get_ss_values(ez)
get_par_values(ez)

# set initial value for alpha back to 0.4
ez <- initval_calibr_par(ez, c(alpha = 0.4))

# find and print steady-state values with
# parameter alpha as free parameter
ez <- steady_state(ez, calibration = FALSE)
get_ss_values(ez, to_tex = TRUE)
get_par_values(ez, to_tex = TRUE)

# find and print perturbation solution
ez <- solve_pert(ez, loglin = TRUE)
get_pert_solution(ez, to_tex = TRUE)

# set the shock distribution parameters
ez <- set_shock_cov_mat(ez, matrix(c(1), 1, 1),
                       shock_order = "epsilon_Z")

# compute and print correlations 
ez <- compute_model_stats(ez, ref_var="Y")

get_model_stats(model = ez,
                variables = c("C", "K_s", "W", 
                              "I", "r", "Y"),
                var_dec = FALSE, 
                to_tex = TRUE)

# compute and print the IRFs
plotirf <- compute_irf(ez, variables = c("C", "K_s", "W", 
                                         "I", "r", "Y"))
print(plotirf)
plot_simulation(plotirf, to_eps = TRUE)

# print summary of the model results
summary(ez)
