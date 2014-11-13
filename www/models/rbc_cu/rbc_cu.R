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
# Basic RBC model with capacity utilization
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
rbc_cu <- make_model('rbc_cu.gcn')

# Finding steady state
rbc_cu <- steady_state(rbc_cu)
get_ss_values(rbc_cu, to_tex = save_latex)
get_par_values(rbc_cu)

# Perturbation solution
rbc_cu <- solve_pert(rbc_cu, norm_tol = 1e-6, loglin = TRUE)
get_pert_solution(rbc_cu, to_tex = save_latex)

# Stochastic simulation
shock_info(rbc_cu, all_shocks = TRUE)
rbc_cu <- set_shock_distr_par(rbc_cu, 
                             distr_par = list("var(epsilon_Z)" = 0.005))
rbc_cu <- compute_moments(rbc_cu, ref_var='Y')

get_moments(model = rbc_cu, 
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            var_dec = FALSE,
            autocorrelations = TRUE, 
            to_tex = save_latex)

get_moments(model = rbc_cu, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE, 
            to_tex = save_latex)

# Computing and drawing impulse response functions
get_var_names(rbc_cu)
plotirf <- compute_irf(rbc_cu, var_list = c('C', 'K', 'CapUt', 'W', 'I', 'Y'))
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(rbc_cu)
summary(rbc_cu)
show(rbc_cu)

# ###################################################################
# ############################## END ################################
# ###################################################################
