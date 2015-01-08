# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2015                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2015                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Author(s): Grzegorz Klima, Karol Podemski,                        #
#            Kaja Retkiewicz-Wijtiwiak                              #
# ###################################################################
# Two-country model with perfect risk sharing
# ###################################################################

# ###################################################################
# ########################### SETTINGS ##############################
# ###################################################################

# Are the results to be saved to *.tex file or displayed in the console?
save_latex <- FALSE

# Sourcing R - code
library(gEcon)


# ###################################################################
# ############################# MODEL ###############################
# ###################################################################

# Bulding model from the *.gcn file
tc_rs_templ <- make_model('tc_rs_templ.gcn')

# Setting parameters
tc_rs_templ <- set_free_par(tc_rs_templ, free_par=list(alpha__F = 0.4,
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

# Finding steady state
tc_rs_templ <- steady_state(tc_rs_templ)
get_ss_values(tc_rs_templ, to_tex = save_latex)
get_par_values(tc_rs_templ)

# Perturbation solution
tc_rs_templ <- solve_pert(tc_rs_templ, norm_tol = 1e-6, loglin = FALSE)
get_pert_solution(tc_rs_templ, to_tex = save_latex)

# Stochastic simulation
shock_info(tc_rs_templ, all_shocks = TRUE)

tc_rs_templ <- set_shock_distr_par(tc_rs_templ,
                                   distr_par = list("var(epsilon_Z__F)" = 0.005,
                                                    "var(epsilon_Z__H)" = 0.005,
                                                    "var(epsilon_G__F)" = 0.005,
                                                    "var(epsilon_G__H)" = 0.005,
                                                    "cor(epsilon_Z__F, epsilon_G__F)" = 0.5,
                                                    "cor(epsilon_Z__H, epsilon_G__H)" = 0.5))

tc_rs_templ <- compute_moments(tc_rs_templ, ref_var="Y__H")

get_moments(model = tc_rs_templ, 
            var_names = setdiff(get_var_names_by_index(tc_rs_templ, 'H'), "lambda_c__H"),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = TRUE,
            to_tex = save_latex)

get_moments(model = tc_rs_templ, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE,
            to_tex = save_latex)

# Computing and drawing impulse response functions
get_var_names(tc_rs_templ)
plotirf <- compute_irf(tc_rs_templ, var_list = c("C__F", "C__H", "H__F", "H__H",
                                                 "TR__H", "Y__F", "Y__H"),
                       path_length = 30, shock_list = c("epsilon_Z__F", "epsilon_Z__H"))
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(tc_rs_templ)
summary(tc_rs_templ)
show(tc_rs_templ)

# ###################################################################
# ############################## END ################################
# ###################################################################

