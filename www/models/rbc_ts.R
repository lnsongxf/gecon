# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Author(s): Anna Sowińska                                                   #
# ############################################################################
# Basic RBC model with two sectors (consumption and investment goods)
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
rbc_ts <- make_model("rbc_ts.gcn")

# set initial values
rbc_ts <- initval_var(rbc_ts, init_var = c(K_C_d = 0.5, L_C_d = 0.5))

# find and print steady-state values
rbc_ts <- steady_state(rbc_ts)
get_ss_values(rbc_ts, to_tex = TRUE)
get_par_values(rbc_ts)

# find and print perturbation solution
rbc_ts <- solve_pert(rbc_ts, loglin = TRUE)
get_pert_solution(rbc_ts, to_tex = TRUE)

# set the shock distribution parameters
rbc_ts <- set_shock_distr_par(rbc_ts, 
                             distr_par = list("var(epsilon_Z)" = 0.005))                           
                              
# compute and print correlations
rbc_ts <- compute_model_stats(rbc_ts, ref_var = "Y")

get_model_stats(model = rbc_ts, 
                variables = c("p", "r", "C", "I", "I_s", "K_s", "L_s", 
                              "U", "W", "Y"),
                corr = TRUE,
                var_dec = FALSE,
                to_tex = TRUE)

# compute and print the IRFs
plotirf <- compute_irf(rbc_ts, variables = c("C", "r", "W", "I", "Y", "K_s"))
print(plotirf)
plot_simulation(plotirf, to_eps = TRUE)

# print summary of the model results
summary(rbc_ts)
