# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# Two-country model with perfect risk sharing (formulated using templates)
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
tc_rs_templ <- make_model("tc_rs_templ.gcn")

# set free parameter values
tc_rs_templ <- set_free_par(tc_rs_templ, free_par = list(alpha__F = 0.4,
                                                         beta     = 0.99,
                                                         eta      = 2,
                                                         mu       = 0.3,
                                                         alpha__H = 0.4,
                                                         delta__F = 0.025,
                                                         delta__H = 0.025,
                                                         phi_G__F = 0.95,
                                                         phi_G__H = 0.95,
                                                         phi_Z__F = 0.95,
                                                         phi_Z__H = 0.95,
                                                         psi__F   = 0.8,
                                                         psi__H   = 0.8))

# find and print steady-state values
tc_rs_templ <- steady_state(tc_rs_templ)
get_ss_values(tc_rs_templ, to_tex = TRUE)
get_par_values(tc_rs_templ)

# find and print perturbation solution
tc_rs_templ <- solve_pert(tc_rs_templ, loglin = FALSE)
get_pert_solution(tc_rs_templ, to_tex = TRUE)

# set the shock distribution parameters
tc_rs_templ <- set_shock_distr_par(tc_rs_templ,
                                   distr_par = list("var(epsilon_Z__F)" = 0.005,
                                                    "var(epsilon_Z__H)" = 0.005,
                                                    "var(epsilon_G__F)" = 0.005,
                                                    "var(epsilon_G__H)" = 0.005,
                                                    "cor(epsilon_Z__F, epsilon_G__F)" = 0.5,
                                                    "cor(epsilon_Z__H, epsilon_G__H)" = 0.5))
shock_info(tc_rs_templ, all = TRUE)

# compute and print correlations
tc_rs_templ <- compute_model_stats(tc_rs_templ, 
                                   n_leadlags = 4,
                                   ref_var = "Y__H")

get_model_stats(model = tc_rs_templ,
                variables = setdiff(get_var_names_by_index(tc_rs_templ, "H"),
                                    "lambda_c__H"),
                to_tex = TRUE)

# compute and print the IRFs 
plotirf <- compute_irf(tc_rs_templ, 
                       variables = c("C__F", "C__H", "H__F", "H__H",
                                     "TR__H", "Y__F", "Y__H"),
                       sim_length = 30, 
                       shocks = c("epsilon_Z__F", "epsilon_Z__H"))
plot_simulation(plotirf, to_eps = TRUE)

# print summary of the model results
summary(tc_rs_templ)
