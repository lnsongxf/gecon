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
# RBC model with monopolistic competition
# ###################################################################

# ###################################################################
# ########################### SETTINGS ##############################
# ###################################################################

# Are the results to be saved to *.tex file or displayed the console?
save_latex <- FALSE

# Sourcing R - code
library(gEcon)

# ###################################################################
# ############################# MODEL ###############################
# ###################################################################

# Building model from the *.gcn file
mc <- make_model('rbc_mc.gcn')

# Finding steady state
mc <- set_free_par(mc, c(beta = 0.99))
mc <- initval_var(mc, list(L_s = 0.1))
mc <- steady_state(mc, calibration = TRUE)
get_ss_values(mc, to_tex = save_latex)

# Perturbation solution
mc <- solve_pert(mc, loglin = TRUE)
get_pert_solution(mc, to_tex = save_latex)
summary(mc)

# Stochastic simulation
mc <- set_shocks(mc, matrix(c(1), 1, 1), shock_order = "epsilon_Z")
mc <- compute_corr(mc, filter = TRUE)
get_moments(mc, 
            var_names = c("C", "I", "K", "L_s",   
                          "U", "W", "Y", "Z"),
            var_dec = FALSE,
            to_tex = save_latex)

mc_sim <- compute_corr(mc, sim = TRUE, filter = FALSE)
get_moments(mc, 
            var_names = c("C", "I", "K", "L_s",  
                          "U", "W", "Y", "Z"),
            var_dec = FALSE,
            to_tex = save_latex)

# computing and drawing impulse response functions
irfplot <- compute_irf(mc, var_list = c('C', 'Z', 'Y', 'L_s', 'W', 'K'))
plot_simulation(irfplot, to_tex = save_latex)

# Simulating model based on randomly generated sequence of shocks
simplot <- random_path(mc, path_length = 100,
                       var_list = c('C', 'Z', 'Y', 'L_s', 'W', 'K'))
plot_simulation(simplot, to_tex = save_latex)

# diagnostics - structure and results of the model
print(mc)
summary(mc)
show(mc)

# ###################################################################
# ############################## END ################################
# ###################################################################
