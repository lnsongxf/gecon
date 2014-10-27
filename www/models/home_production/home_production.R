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
hp <- make_model("home_production.gcn")

# Finding steady state
hp <- initval_var(hp, list(N = 0.5,
                           N_h = 0.25,
                           N_m = 0.25))
hp <- steady_state(hp)
get_ss_values(hp, to_tex = save_latex)

# Perturbation solution - log-linearisation
hp <- solve_pert(model = hp, loglin = TRUE)
get_pert_solution(hp, to_tex = save_latex)
get_parameter_vals(hp)

# Stochastic simulation
hp <- set_shocks(hp, shock_matrix = matrix(c(0.49, 0.33, 0.33, 0.49), 2, 2),
                 shock_order = c("epsilon_h", "epsilon_m"))
hp <- compute_corr(hp, ref_var = 'Y')

get_moments(model = hp, 
            var_names = c("r", "C_m", "C_h", "I", "I_m", "I_h", "K", 
                          "N", "N_m", "N_h", "W", "Y"),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = TRUE, 
            to_tex = save_latex)

get_moments(model = hp, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE, 
            to_tex = save_latex)

# Computing and drawing impulse response functions
hp_irf <- compute_irf(model = hp, 
                      var_list = c('C_m', 'C_h', 'Y', 
                                   'K_m', 'K_h', 'N_m', 'N_h', 'W'))
plot_simulation(hp_irf, to_tex = save_latex)
shock_info(hp, all_shocks = TRUE)

# Diagnostics - structure and results of the model
print(hp)
summary(hp)
show(hp)

# ###################################################################
# ############################## END ################################
# ###################################################################
