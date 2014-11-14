# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2014                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2014                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Author(s): Marta Retkiewicz                                       #
# ###################################################################
# Simple CGE model with government sector (2x3x1)
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
cge_gov <- make_model("cge_gov_templ.gcn")

# Calibrating parameters
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

# Finding steady state
cge_gov <- steady_state(cge_gov)
values1 <- get_ss_values(cge_gov, to_tex = save_latex)

# Introducing a tax rate
cge_gov <- set_free_par(cge_gov, list(t_k = 0.25, t_l = 0.00, tau_h = 0.00, tau = 0.00))

cge_gov <- steady_state(cge_gov)
values2 <- get_ss_values(cge_gov, to_tex = save_latex)

cat("\nComparative statics:\n")
print(round(values2 - values1, digits = 2))

# ###################################################################
# ############################## END ################################
# ###################################################################
