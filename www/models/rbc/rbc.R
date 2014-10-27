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
# Basic RBC model
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
rbc <- make_model("rbc.gcn")

# Finding steady state
rbc <- steady_state(rbc)
get_ss_values(rbc, to_tex = save_latex)

# Perturbation solution
rbc <- solve_pert(model = rbc, loglin = TRUE)
get_pert_solution(rbc, to_tex = save_latex)
get_parameter_vals(rbc)

# Stochastic simulation
rbc <- set_shocks(rbc, shock_matrix = matrix(c(0.01), 1, 1),
                  shock_order = c("epsilon_Z"))
shock_info(rbc, all_shocks = TRUE)
rbc <- compute_corr(rbc, ref_var = 'Y', n_leadlags = 5)

get_moments(model = rbc, 
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = FALSE,
            to_tex = save_latex)

get_moments(model = rbc, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE,
            to_tex = save_latex)

# Computing and drawing impulse response functions
rbc_irf <- compute_irf(rbc, 
                       var_list = c('r', 'C', 'K_s', 'Y', 'L_s', 'I'))
plot_simulation(rbc_irf, to_tex = save_latex)

# Diagnostics - structure and results of the model
print(rbc)
summary(rbc)
show(rbc)

# ###################################################################
# ############################## END ################################
# ###################################################################
