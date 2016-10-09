# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Marta Retkiewicz                                                  #
# ############################################################################
# Simple CGE model with government
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
cge_gov <- make_model("cge_gov_templ.gcn")

# set model parameters' values
cge_gov <- set_free_par(cge_gov, list(omega = 2,
                                      par_k = 40,         par_l = 40,
                                      t_k = 0,            t_l = 0,
                                      tau_h = 0,          tau = 0,
                                      alpha__A = 0.612,   alpha__B = 0.354,   alpha__C = 0.707,
                                      beta_va__A = 0.655, beta_va__B = 0.707, beta_va__C = 0.535,
                                      beta_ci__A = 0.756, beta_ci__B = 0.707, beta_ci__C = 0.845,
                                      beta_k__A = 0.816,  beta_k__B = 0.577,  beta_k__C = 0.707,
                                      beta_l__A = 0.577,  beta_l__B = 0.816,  beta_l__C = 0.707,
                                      gamma__A = 2,       gamma__B = 2,       gamma__C = 2,
                                      chi__A__A = 0.500,  chi__A__B = 0.577,  chi__A__C = 0.632,
                                      chi__B__A = 0.707,  chi__B__B = 0.577,  chi__B__C = 0.632,
                                      chi__C__A = 0.500,  chi__C__B = 0.577,  chi__C__C = 0.447))

# find and print equilibrium values
cge_gov <- steady_state(cge_gov)
values1 <- get_ss_values(cge_gov, to_tex = TRUE)

# introduce tax rates and recompute equilibrium values
cge_gov <- set_free_par(cge_gov, list(t_k = 0.25, t_l = 0.00, tau_h = 0.00, tau = 0.00))
cge_gov <- steady_state(cge_gov)
values2 <- get_ss_values(cge_gov, to_tex = TRUE)

# print comparative statics of the models with and without taxes
cat("\nComparative statics:\n")
print(round(values2 - values1, digits = 2))
