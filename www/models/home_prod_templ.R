# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# RBC Model with home production based on Benhabib J., 
# Rogerson R. & Wright R. "Homework in macroeconomics: 
# Household production and aggregate fluctuations." (1991)
# (formulated using templates)
#
# Due to the expression 'log(1 - N_m[] - N_h[])' finding model 
# steady state requires setting initial values 
# for the following variables: N_h, N_m, N and N_m_d. 
# A sample set of initial values: N = 0.5, N_h = 0.25, N_m = 0.25.
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
hp_templ <- make_model("home_prod_templ.gcn")

# set initial values
hp_templ <- initval_var(hp_templ, list(N = 0.5,
                                       N__H = 0.25,
                                       N__M = 0.25))

# find and print steady-state values
hp_templ <- steady_state(hp_templ)
get_ss_values(hp_templ, to_tex = TRUE)

# find and print perturbation solution
hp_templ <- solve_pert(model = hp_templ, loglin = TRUE)
get_pert_solution(hp_templ, to_tex = TRUE)

# set the shock distribution parameters
hp_templ <- set_shock_cov_mat(hp_templ, 
                              cov_matrix = matrix(c(0.49, 0.33, 0.33, 0.49), 2, 2),
                              shock_order = c("epsilon__H", "epsilon__M"))
shock_info(hp_templ, all = TRUE)

# compute and print correlations 
hp_templ <- compute_model_stats(hp_templ, ref_var = "Y")

get_model_stats(model = hp_templ, 
                variables = c("C__M", "C__H", "Y", "I__M",
                              "I__H", "K__M", "K__H", "N__M", 
                              "N__H", "W"),
                corr = TRUE, 
                autocorr = TRUE, 
                var_dec = TRUE, 
                to_tex = TRUE)

# compute and print the IRFs
hp_templ_irf <- compute_irf(model = hp_templ,
                variables = c("C__M", "C__H", "Y", "I__M",
                              "I__H", "K__M", "K__H", "N__M",
                              "N__H", "W"))
plot_simulation(hp_templ_irf, to_eps = TRUE)

# print summary of the model results
summary(hp_templ)
