# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# RBC model with installation costs
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
rbc_ic <- make_model("rbc_ic.gcn")
par_info(rbc_ic, all = TRUE)

# set initial values for calibrated parameter
rbc_ic <- initval_calibr_par(rbc_ic, calibr_par = list(alpha = 0.5))

# find and print steady-state values
rbc_ic <- steady_state(rbc_ic)
get_ss_values(rbc_ic, to_tex = TRUE)

# find and print perturbation solution
rbc_ic <- solve_pert(model = rbc_ic, loglin = TRUE)
get_pert_solution(rbc_ic, to_tex = TRUE)

# set the shock distribution parameters
rbc_ic <- set_shock_cov_mat(rbc_ic, cov_matrix = matrix(c(0.01), 1, 1))

# compute and print correlations
rbc_ic <- compute_model_stats(rbc_ic, ref_var = "Y")

get_model_stats(model = rbc_ic, 
                basic_stats = TRUE, 
                corr = TRUE, 
                autocorr = TRUE, 
                var_dec = FALSE, 
                to_tex = TRUE)

# compute and print the IRFs
rbc_ic_irf <- compute_irf(rbc_ic, 
                          variables = c("C", "K_s", "Y", "L_s", "I", "W"))
plot_simulation(rbc_ic_irf, to_eps = TRUE)

# print summary of the model results
summary(rbc_ic)
