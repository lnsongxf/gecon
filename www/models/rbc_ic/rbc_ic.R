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
# RBC model with installation costs
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
rbc_ic <- make_model("rbc_ic.gcn")
parameter_info(rbc_ic, all_parameters = TRUE)

# Finding steady state
rbc_ic <- initval_calibr_par(rbc_ic, calibr_par = list(alpha = 0.5))
rbc_ic <- steady_state(rbc_ic)
get_ss_values(rbc_ic, to_tex = save_latex)

# Perturbation solution
rbc_ic <- solve_pert(model = rbc_ic, loglin = TRUE)
get_pert_solution(rbc_ic)

# Stochastic simulation
rbc_ic <- set_shocks(rbc_ic, shock_matrix = matrix(c(0.01), 1, 1))
rbc_ic <- compute_corr(rbc_ic, ref_var = 'Y')

get_moments(model = rbc_ic, 
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = FALSE, 
            to_tex = save_latex)

get_moments(model = rbc_ic, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE, 
            to_tex = save_latex)

# Computing and drawing impulse response functions
rbc_ic_irf <- compute_irf(rbc_ic, 
                          var_list = c('C', 'K_s', 'Y', 'L_s', 'I', 'W'))
plot_simulation(rbc_ic_irf, to_tex = save_latex)

# Diagnostics - structure and results of the model
print(rbc_ic)
summary(rbc_ic)
show(rbc_ic)

# ###################################################################
# ############################## END ################################
# ###################################################################
