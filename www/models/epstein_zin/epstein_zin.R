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
# Stochastic growth model with Epstein-Zin preferences
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
ez <- make_model('epstein_zin.gcn')

# Finding steady state and internally calibrating the "alpha" parameter...
ez <- initval_calibr_par(ez, c(alpha = 0.4))
ez <- steady_state(ez) 
get_ss_values(ez)
get_par_values(ez)

# ... or treating "alpha" as a free parameter
ez <- initval_calibr_par(ez, c(alpha = 0.4))
ez <- steady_state(ez, calibration = FALSE)
get_ss_values(ez)
get_ss_values(ez, to_tex = save_latex)
get_par_values(ez)

# Perturbation solution
ez <- solve_pert(ez, norm_tol = 1e-6, loglin = TRUE)
get_pert_solution(ez, to_tex = save_latex)

# Stochastic simulation
ez <- set_shock_cov_mat(ez, matrix(c(1), 1, 1), shock_order = "epsilon_Z")
ez <- compute_moments(ez, ref_var='Y')

get_moments(model = ez, 
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = FALSE, 
            to_tex = save_latex)

get_moments(model = ez, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE, 
            to_tex = save_latex)

# Computing and drawing impulse response functions
plotirf <- compute_irf(ez, var_list = c('C', 'K_s', 'W', 'I', 'r', 'Y'))
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(ez)
summary(ez)
show(ez)

# ###################################################################
# ############################## END ################################
# ###################################################################
