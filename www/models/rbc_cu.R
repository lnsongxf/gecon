# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# Basic RBC model with capacity utilization
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
rbc_cu <- make_model("rbc_cu.gcn")

# find and print steady-state values and calibrated parameter values
rbc_cu <- steady_state(rbc_cu)
get_ss_values(rbc_cu, to_tex = TRUE)
get_par_values(rbc_cu)

# find and print perturbation solution
rbc_cu <- solve_pert(rbc_cu, tol = 1e-6, loglin = TRUE)
get_pert_solution(rbc_cu, to_tex = TRUE)

# set the shock distribution parameters
shock_info(rbc_cu, all = TRUE)
rbc_cu <- set_shock_distr_par(rbc_cu, 
                             distr_par = list("var(epsilon_Z)" = 0.005))

# compute and print correlations
rbc_cu <- compute_model_stats(rbc_cu, ref_var = "Y")

get_model_stats(model = rbc_cu, 
                basic_stats = TRUE, 
                corr = TRUE, 
                var_dec = FALSE,
                autocorr = TRUE, 
                to_tex = TRUE)

# compute and print the IRFs
get_var_names(rbc_cu)
plotirf <- compute_irf(rbc_cu, variables = c("C", "K", "CapUt", "W", "I", "Y"))
print(plotirf)
plot_simulation(plotirf, to_eps = TRUE)

# print summary of the model results
summary(rbc_cu)
