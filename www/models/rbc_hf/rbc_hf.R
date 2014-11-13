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
# Basic RBC model with habit formation
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
rbc_hf <- make_model('rbc_hf.gcn')

# Finding steady state
rbc_hf <- steady_state(rbc_hf)
get_ss_values(rbc_hf, to_tex = save_latex)
get_par_values(rbc_hf)

# Perturbation solution
rbc_hf <- solve_pert(rbc_hf, norm_tol = 1e-6, loglin = FALSE)
get_pert_solution(rbc_hf, to_tex = save_latex)

# Stochastic simulation
shock_info(rbc_hf, all_shocks = TRUE)
rbc_hf <- set_shock_distr_par(rbc_hf, 
                             distr_par = list("var(epsilon_Z)" = 0.005))
rbc_hf <- compute_moments(rbc_hf, ref_var='Y', n_leadlags = 5)

get_moments(model = rbc_hf, 
            var_names = setdiff(get_var_names(rbc_hf), "lambda__CONSUMER_2"),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = FALSE, 
            to_tex = save_latex)

get_moments(model = rbc_hf, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE,
            to_tex = save_latex)

# Computing and drawing impulse response functions
get_var_names(rbc_hf)
plotirf <- compute_irf(rbc_hf, var_list = c('C', 'H', 'L_s', 'W', 'I', 'Y'))
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(rbc_hf)
summary(rbc_hf)
show(rbc_hf)

# ###################################################################
# ############################## END ################################
# ###################################################################
