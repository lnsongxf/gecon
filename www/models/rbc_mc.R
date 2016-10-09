# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# RBC model with monopolistic competition
# ############################################################################

# load gEcon package
library(gEcon)

# ###################################################################
# ############################# MODEL ###############################
# ###################################################################

# make and load the model
mc <- make_model("rbc_mc.gcn")

# set free parameter values and initial values for parameters
mc <- set_free_par(mc, c(beta = 0.99))
mc <- initval_var(mc, list(L_s = 0.1))

# find and print steady-state values
mc <- steady_state(mc, calibration = TRUE)
get_ss_values(mc, to_tex = TRUE)

# find and print perturbation solution
mc <- solve_pert(mc, loglin = TRUE)
get_pert_solution(mc, to_tex = TRUE)

# set the shock distribution parameters
mc <- set_shock_cov_mat(mc, matrix(c(1), 1, 1), shock_order = "epsilon_Z")
                              
# compute and print correlations (for HP-filtered variables)
mc <- compute_model_stats(mc)
get_model_stats(mc, 
                variables = c("C", "I", "K", "L_s",   
                              "U", "W", "Y", "Z"),
                var_dec = FALSE,
                to_tex = TRUE)
                              
# compute and print correlations (for non-filtered variables)
mc_non_hp <- compute_model_stats(mc, lambda = 0)
get_model_stats(mc_non_hp, 
                variables = c("C", "I", "K", "L_s",   
                              "U", "W", "Y", "Z"),
                var_dec = FALSE,
                to_tex = TRUE)

# compute and print the IRFs
irfplot <- compute_irf(mc, variables = c("C", "Z", "Y", "L_s", "W", "K"))
plot_simulation(irfplot, to_eps = TRUE)

# perform simulation and plot the results
simplot <- random_path(mc, sim_length = 100,
                       variables = c("C", "Z", "Y", "L_s", "W", "K"))
plot_simulation(simplot, to_eps = TRUE)

# print summary of the model results
summary(mc)
