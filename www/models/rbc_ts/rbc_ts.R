# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2014                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2014                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Author(s): Anna Sowińska                                          #
# ###################################################################
# Basic RBC model with two sectors (consumption and investment goods)
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
rbc_ts <- make_model('rbc_ts.gcn')

# Finding steady state
rbc_ts <- steady_state(rbc_ts)
get_ss_values(rbc_ts, to_tex = save_latex)
get_parameter_vals(rbc_ts)

# Perturbation solution
rbc_ts <- solve_pert(rbc_ts, norm_tol = 1e-6, loglin = TRUE)
get_pert_solution(rbc_ts, to_tex = save_latex)

# Stochastic simulation
shock_info(rbc_ts, all_shocks = TRUE)
rbc_ts <- set_shock_distr_par(rbc_ts, 
                             distr_par = list("var(epsilon_Z)" = 0.005))
rbc_ts <- compute_corr(rbc_ts, ref_var='Y')

get_moments(model = rbc_ts, 
            var_names = c("p", "r", "C", "I", "I_s", "K_s", "L_s", 
                          "U", "W", "Y"),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            var_dec = FALSE,
            autocorrelations = TRUE,
            to_tex = save_latex)

get_moments(model = rbc_ts, 
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE,
            to_tex = save_latex)

# Computing and drawing impulse response functions
get_var_names(rbc_ts)
plotirf <- compute_irf(rbc_ts, var_list = c('C', 'r', 'W', 'I', 'Y', 'K_s'))
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(rbc_ts)
summary(rbc_ts)
show(rbc_ts)

# ###################################################################
# ############################## END ################################
# ###################################################################
