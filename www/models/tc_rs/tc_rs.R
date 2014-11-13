# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2014                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2014                   #
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
tc_rs <- make_model('tc_rs.gcn')

# Finding steady state
tc_rs <- steady_state(tc_rs)
get_ss_values(tc_rs, to_tex = save_latex)
get_par_values(tc_rs)

# Perturbation solution
tc_rs <- solve_pert(tc_rs, norm_tol = 1e-6, loglin = FALSE)
get_pert_solution(tc_rs, to_tex = save_latex)

# Stochastic simulation
shock_info(tc_rs, all_shocks = TRUE)
tc_rs <- set_shock_distr_par(tc_rs, 
                             distr_par = list("var(epsilon_Z)" = 0.005,
                                              "var(epsilon_G)" = 0.005,
                                              "var(epsilon_Z_ast)" = 0.01,
                                              "var(epsilon_G_ast)" = 0.01,
                                              "cor(epsilon_Z, epsilon_G)" = 0.5,
                                              "cor(epsilon_Z_ast, epsilon_G_ast)" = 0.5))
tc_rs <- compute_moments(tc_rs, ref_var='Y')

get_moments(model = tc_rs, 
            var_names = c("r", "C", "G_d", "H", "I", "K", "TR", "U",
                          "W", "Y", "Z"),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = TRUE,
            to_tex = save_latex)

get_moments(model = tc_rs, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE,
            to_tex = save_latex)

# Computing and drawing impulse response functions
get_var_names(tc_rs)
plotirf <- compute_irf(tc_rs, var_list = c('C', 'C_ast', 'H', 'H_ast', 
                                           'TR', 'Y'),
                       path_length = 30, shock_list = c("epsilon_Z", "epsilon_Z_ast"))
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(tc_rs)
summary(tc_rs)
show(tc_rs)

# ###################################################################
# ############################## END ################################
# ###################################################################
