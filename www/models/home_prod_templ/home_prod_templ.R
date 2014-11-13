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
# RBC Model with home production based on Benhabib J., 
# Rogerson R. & Wright R. "Homework in macroeconomics: 
# Household production and aggregate fluctuations." (1991)
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

# Building model from the *.gcn file
hp_templ <- make_model("home_prod_templ.gcn")

# Finding steady state
hp_templ <- initval_var(hp_templ, list(N = 0.5,
                                       N__H = 0.25,
                                       N__M = 0.25))
hp_templ <- steady_state(hp_templ)
get_ss_values(hp_templ, to_tex = save_latex)

# Perturbation solution - log-linearisation
hp_templ <- solve_pert(model = hp_templ, loglin = TRUE)
get_pert_solution(hp_templ, to_tex = save_latex)
get_par_values(hp_templ)

# Stochastic simulation
hp_templ <- set_shock_cov_mat(hp_templ, shock_matrix = matrix(c(0.49, 0.33, 0.33, 0.49), 2, 2),
                       shock_order = c("epsilon__H", "epsilon__M"))
hp_templ <- compute_moments(hp_templ, ref_var = 'Y')

get_moments(model = hp_templ, 
            var_names = c("r", "C__M", "I", "I__M", "I__H", "K", 
                          "N", "N__M", "N__H", "W", "Y"),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = TRUE, 
            to_tex = save_latex)

get_moments(model = hp_templ, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE, 
            to_tex = save_latex)

# Computing and drawing impulse response functions
hp_templ_irf <- compute_irf(model = hp_templ,
                            var_list = c('C__M', 'C__H', 'Y',
                                         'K__M', 'K__H', 'N__M', 'N__H', 'W'))
plot_simulation(hp_templ_irf, to_tex = save_latex)
shock_info(hp_templ, all_shocks = TRUE)

# Diagnostics - structure and results of the model
print(hp_templ)
summary(hp_templ)
show(hp_templ)

# ###################################################################
# ############################## END ################################
# ###################################################################
