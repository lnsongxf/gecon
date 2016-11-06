# ############################################################################
# (c) Karol Podemski 2016                                                    #
#                                                                            #
# Authors: Karol Podemski                                                    #
# ############################################################################
# Example for gEcon.estimation package: estimation of SW'03 model.
# 
# This script performs estimation of an DSGE model written 
# in gEcon language using the gEcon.estimation package. 
# When analysing model and estimation results the user has to realize 
# that models written in gEcon language as optimisation problems 
# are not modified before estimation. In contrast many authors, 
# removes all coefficients standing in front of shocks before estimation. 
# The normalisation influences both magnitude of shocks and values of 
# estimated parameters. As an example, in SW'03 the expression: 
# (epsilon_b[] - E[][epsilon_b[1]]) * (1 - h) / ((1 + h) * sigma_c) 
# was replaced by epsilon_b[] in log-linearised version of model.
# In this particular case, the modification influenced 
# both magnitude of shocks and estimate of h. 
#
# This example shows, however, that even though standard deviation and
# autocorrelation of shock estimates may differ significantly in two approaches, 
# the deep parameters remain similiar with or without normalisation
# (compare the script SW_03_loglin_est.R). The likelihood function computed 
# for the mode of the posterior kernel is similiar for both approaches too.
# ############################################################################

# load gEcon.estimation package
library(gEcon.estimation)

# create and solve the model
SW_03 <- make_model("SW_03_est.gcn")

initv <- list(z = 1, z_f = 1, Q = 1, Q_f = 1, pi = 1, 
              pi_obj = 1, epsilon_b = 1, epsilon_L = 1, 
              epsilon_I = 1, epsilon_a = 1, epsilon_G = 1,
              r_k = 0.01, r_k_f = 0.01)
SW_03 <- initval_var(SW_03, init_var = initv)

SW_03 <- steady_state(SW_03)

SW_03 <- solve_pert(SW_03, loglin = TRUE)

# declare prior distribution for the model parameter
SW_03_prior <- gecon_prior(prior_list = list(
    list(par = "sd(eta_a)", type = "inv_gamma",
         mean = 0.4, sd = 2, lower_bound = 0.001, upper_bound  = 2, initial = 0.535),
    list(par = "sd(eta_pi)", type = "inv_gamma",
         mean = 0.02, sd = 10, lower_bound = 0.001, upper_bound  = 3, initial = 0.0092),
    list(par = "sd(eta_b)", type = "inv_gamma",
          mean = 2, sd = 0.5, lower_bound = 0.2, upper_bound  = 20, initial = 2.099),
     list(par = "sd(eta_G)", type = "inv_gamma",
          mean = 1.6, sd = 0.5, lower_bound = 0.1, upper_bound  = 3, initial = 1.923),
     list(par = "sd(eta_L)", type = "inv_gamma",
         mean = 1, sd = 2, lower_bound = 1, upper_bound  = 6, initial = 2.348),
     list(par = "sd(eta_I)", type = "inv_gamma",
          mean = 2, sd = 0.5, lower_bound = 0.001, upper_bound  = 20, initial = 1.868),
     list(par = "sd(eta_R)", type = "inv_gamma",
          mean = 0.1, sd = 2, lower_bound = 0.01, upper_bound  = 2, initial = 0.106),
     list(par = "sd(eta_p)", type = "inv_gamma",
          mean = 0.15, sd = 2, lower_bound = 0.01, upper_bound  = 20, initial = 1.033),
     list(par = "sd(eta_w)", type = "inv_gamma",
          mean = 0.2, sd = 2, lower_bound = 0.001, upper_bound  = 70, initial = 0.411),
    list(par = "rho_a", type = "beta",
         mean = 0.85, sd = 0.1, lower_bound = 0.1, upper_bound  = 0.9999, initial = 0.935),
    list(par = "rho_pi_bar", type = "beta",
         mean = 0.85, sd = 0.1, lower_bound = 0.1, upper_bound  = 0.999, initial = 0.922),
    list(par = "rho_b", type = "beta",
         mean = 0.80, sd = 0.1, lower_bound = 0.1, upper_bound  = 0.99, initial = 0.79),
     list(par = "rho_G", type = "beta",
          mean = 0.85, sd = 0.1, lower_bound = 0.1, upper_bound  = 0.9999, initial = 0.957),
     list(par = "rho_L", type = "beta",
          mean = 0.85, sd = 0.1, lower_bound = 0.01, upper_bound  = 0.9999, initial = 0.927),
     list(par = "rho_I", type = "beta",
          mean = 0.85, sd = 0.1, lower_bound = 0.1, upper_bound  = 0.99, initial = 0.502),
     list(par = "varphi", type = "normal",
          mean = 4, sd = 1.5, lower_bound = 1, upper_bound  = 15, initial = 6.699),
     list(par = "sigma_c", type = "normal",
          mean = 1, sd = 0.375, lower_bound = 0.25, upper_bound  = 3, initial = 1.311),
     list(par = "h", type = "beta",
          mean = 0.7, sd = 0.1, lower_bound = 0.3, upper_bound  = 0.95, initial = 0.579),
     list(par = "sigma_l", type = "normal",
          mean = 2, sd = 0.75, lower_bound = 0.2, upper_bound  = 5, initial = 1.927),
     list(par = "xi_e", type = "beta",
            mean = 0.5, sd = 0.15, lower_bound = 0.1, upper_bound  = 0.95, initial = 0.563),
     list(par = "psi", type = "normal",
          mean = 0.2, sd = 0.075, lower_bound = 0.01, upper_bound  = 2, initial = 0.338),
     list(par = "xi_w", type = "beta",
           mean = 0.75, sd = 0.05, lower_bound = 0.3, upper_bound  = 0.9, initial = 0.638),
     list(par = "xi_p", type = "beta",
          mean = 0.75, sd = 0.05, lower_bound = 0.3, upper_bound  = 0.99, initial = 0.906),
     list(par = "gamma_w", type = "beta",
          mean = 0.75, sd = 0.15, lower_bound = 0.1, upper_bound  = 0.99, initial = 0.686),
     list(par = "gamma_p", type = "beta",
          mean = 0.75, sd = 0.15, lower_bound = 0.1, upper_bound  = 0.99, initial = 0.414),
     list(par = "r_pi", type = "normal",
          mean = 1.7, sd = 0.1, lower_bound = 1, upper_bound  = 3, initial = 1.700),
     list(par = "r_Delta_pi", type = "normal",
          mean = 0.3, sd = 0.1, lower_bound = 0.01, upper_bound  = 0.5, initial = 0.167),
     list(par = "rho", type = "beta",
          mean = 0.8, sd = 0.1, lower_bound = 0.5, upper_bound  = 0.99, initial = 0.948),
     list(par = "r_Y", type =  "normal",
         mean = 0.125, sd = 0.05, lower_bound = 0.001, upper_bound  = 0.5, initial = 0.096),
     list(par = "r_Delta_y", type = "normal",
          mean = 0.0625, sd = 0.05, lower_bound = 0.001, upper_bound  = 0.5, initial = 0.171)
    ),
    model = SW_03
)

# load model data
raw_data <- read.csv(file = "SW_03_data.csv", row.names = NULL)
SW_03_data <- ts(data = raw_data, 
                 start = c(1970, 3), 
                 frequency = 4)
SW_03_estimation_data <- window(SW_03_data, 
                                start = c(1980, 2), 
                                end = c(1999,4))

observables_names <- c("C", "Emp", "I" , "pi",
                       "R", "W", "Y")

# estimate the model
estimation_result <- bayesian_estimation(model = SW_03,
                                         prior = SW_03_prior,
                                         data_set = SW_03_estimation_data, 
                                         mcmc_options_list = list(chain_length = 10000, 
                                                                  burn = 2000,
                                                                  scale = rep(0.3, 30),
                                                                  cores = 3, chains = 3),
                                         observables = observables_names)

plot_posterior(estimation_result, to_eps = TRUE)

est_par <- get_estimated_par(estimation_result)
free_par <- est_par$free_par
shock_distr_par <- est_par$shock_distr_par

# update the model
estimated_SW_03 <- set_free_par(SW_03, free_par = free_par)
estimated_SW_03 <- set_shock_distr_par(estimated_SW_03, distr_par = shock_distr_par)

# solve the updated model
estimated_SW_03 <- steady_state(estimated_SW_03)
estimated_SW_03 <- solve_pert(estimated_SW_03, loglin = TRUE)

# forecast based on data
sw_forecast <- forecast_posterior(est_results = estimation_result, 
                                  posterior_sample = 1000,
                                  data_set = SW_03_estimation_data, 
                                  variables = observables_names, 
                                  observables = observables_names, 
                                  horizon = 4)

# plot forecasts
plot_forecast(sw_forecast, to_eps = TRUE)

# perform and plot historical shock decomposition
dsge_shock_decomposition <- shock_decomposition(model = estimated_SW_03, 
                                                data_set =  window(SW_03_estimation_data,
                                                                   start = c(1990, 1), 
                                                                   end = c(1999,4)), 
                                                observables =  observables_names, 
                                                variables = c("K", "I", "Y"))
plot_shock_decomposition(dsge_shock_decomposition, to_eps = TRUE)
