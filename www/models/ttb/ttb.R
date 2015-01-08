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
# Time-to-build model
# Calibration based on Backus, Kehoe and Kydland (1992): 
# "International Real Business Cycles", Journal of Political Economy
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
ttb <- make_model('ttb.gcn')

# Finding steady state
ttb <- steady_state(ttb)
get_ss_values(ttb, to_tex = save_latex, 
              var_names = setdiff(get_var_names(ttb), 
                                  c("lambda__FIRM_2",
                                    "lambda__FIRM_S__lag_1",
                                    "lambda__FIRM_S__lag_2")))
get_par_values(ttb)

# Perturbation solution
ttb <- solve_pert(ttb, norm_tol = 1e-6, loglin = TRUE)
get_pert_solution(ttb, to_tex = save_latex)

# Stochastic simulation
shock_info(ttb, all_shocks = TRUE)
ttb <- set_shock_cov_mat(ttb, matrix(c(0.1), 1, 1))
ttb <- compute_moments(ttb, ref_var='Y')

get_moments(model = ttb, 
            var_names = c('C', 'K', 'L', 'LAMBDA', 'N', 'U', 'Y', 'W'),
            relative_to = FALSE, 
            moments = TRUE, 
            correlations = TRUE, 
            autocorrelations = TRUE, 
            var_dec = FALSE,
            to_tex = save_latex)

get_moments(model = ttb, 
            var_names = c('C', 'K', 'L', 'LAMBDA', 'N', 'U', 'Y', 'W'),
            relative_to = TRUE, 
            moments = TRUE, 
            correlations = TRUE,
            to_tex = save_latex)

# Computing and drawing impulse response functions
var_info(ttb, all_variables = TRUE)
plotirf <- compute_irf(ttb, var_list = c('C', 'K', 'L', 'S', 'Y', 'N'), 
                       shock_list = 'epsilon_LAMBDA',
                       path_length = 20)
plot_simulation(plotirf, to_tex = save_latex)
print(plotirf)

# Diagnostics - structure and results of the model
print(ttb)
summary(ttb)
show(ttb)

# ###################################################################
# ############################## END ################################
# ###################################################################
