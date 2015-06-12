# ###################################################################
# (c) Chancellery of the Prime Minister 2012-2015                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Authors: Grzegorz Klima, Karol Podemski,                          #
#          Kaja Retkiewicz-Wijtiwiak, Anna Sowińska                 #
# ###################################################################

library(gEcon)

sw_gecon <- make_model('SW_03.gcn')

initv <- list(z = 1, z_f = 1, Q = 1, Q_f = 1, pi = 1, pi_obj = 1,
              epsilon_b = 1, epsilon_L = 1, epsilon_I = 1, epsilon_a = 1, epsilon_G = 1,
              r_k = 0.01, r_k_f = 0.01)
sw_gecon <- initval_var(sw_gecon, init_var = initv)

sw_gecon <- steady_state(sw_gecon)

sw_gecon <- solve_pert(sw_gecon, loglin = TRUE)

summary(sw_gecon)

a <- c(eta_b = 0.336 ^ 2, eta_L = 3.52 ^ 2, eta_I = 0.085 ^ 2, eta_a = 0.598 ^ 2,
       eta_w = 0.6853261 ^ 2, eta_p = 0.7896512 ^ 2,
       eta_G = 0.325 ^ 2, eta_R = 0.081 ^ 2, eta_pi = 0.017 ^ 2)
sw_gecon  <- set_shock_cov_mat(sw_gecon, shock_matrix = diag(a), shock_order = names(a))

shock_info(sw_gecon, all_shocks = TRUE)

sw_gecon <- compute_moments(sw_gecon)

get_moments(sw_gecon)

sw_gecon_irf <- compute_irf(sw_gecon, var_list = c('C', 'Y', 'K', 'I', 'L'), chol = T,
                            shock_list = list('eta_a', 'eta_R'), path_length = 40)
plot_simulation(sw_gecon_irf)