# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# Basic RBC model with habit formation
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
rbc_hf <- make_model("rbc_hf.gcn")

# find and print steady-state values and calibrated parameter values
rbc_hf <- steady_state(rbc_hf)
get_ss_values(rbc_hf, to_tex = TRUE)
get_par_values(rbc_hf)

# find and print perturbation solution
rbc_hf <- solve_pert(rbc_hf, tol = 1e-6, loglin = FALSE)
get_pert_solution(rbc_hf, to_tex = TRUE)

# set the shock distribution parameters
shock_info(rbc_hf, all = TRUE)
rbc_hf <- set_shock_distr_par(rbc_hf, 
                              distr_par = list("var(epsilon_Z)" = 0.005))
                              
# compute and print correlations
rbc_hf <- compute_model_stats(rbc_hf, ref_var = "Y", n_leadlags = 5)

get_model_stats(model = rbc_hf, 
                variables = setdiff(get_var_names(rbc_hf), "lambda__CONSUMER_2"),
                basic_stats = TRUE, 
                corr = TRUE, 
                autocorr = TRUE, 
                var_dec = FALSE, 
                to_tex = TRUE)

# compute and print the IRFs
plotirf <- compute_irf(rbc_hf, variables = c("C", "H", "L_s", "W", "I", "Y"))
plot_simulation(plotirf, to_eps = TRUE)
print(plotirf)

# print summary of the model results
summary(rbc_hf)
