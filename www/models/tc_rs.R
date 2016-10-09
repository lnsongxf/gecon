# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# Two-country model with perfect risk sharing
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
tc_rs <- make_model("tc_rs.gcn")

# find and print steady-state values
tc_rs <- steady_state(tc_rs)
get_ss_values(tc_rs, to_tex = TRUE)
get_par_values(tc_rs)

# find and print perturbation solution
tc_rs <- solve_pert(tc_rs, loglin = FALSE)
get_pert_solution(tc_rs, to_tex = TRUE)

# set the shock distribution parameters
tc_rs <- set_shock_distr_par(tc_rs, 
                             distr_par = list("var(epsilon_Z)" = 0.005,
                                              "var(epsilon_G)" = 0.005,
                                              "var(epsilon_Z_ast)" = 0.01,
                                              "var(epsilon_G_ast)" = 0.01,
                                              "cor(epsilon_Z, epsilon_G)" = 0.5,
                                              "cor(epsilon_Z_ast, epsilon_G_ast)" = 0.5))
shock_info(tc_rs, all = TRUE)

# compute and print correlations
tc_rs <- compute_model_stats(tc_rs, ref_var="Y")

get_model_stats(model = tc_rs, 
                variables = c("r", "C", "G_d", "H", 
                              "I", "K", "TR", "U",
                              "W", "Y", "Z"),
                var_dec = TRUE,
                to_tex = TRUE)

# compute and print the IRFs 
plotirf <- compute_irf(tc_rs, 
                       variables = c("C", "C_ast", "H", 
                                     "H_ast", "TR", "Y"),
                       sim_length = 30, 
                       shocks = c("epsilon_Z", "epsilon_Z_ast"))
plot_simulation(plotirf, to_eps = TRUE)

# print summary of the model results
summary(tc_rs)
