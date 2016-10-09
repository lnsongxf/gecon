# ###################################################################
# (c) Chancellery of the Prime Minister 2012-2015                   #
#                                                                   #
# Authors: Grzegorz Klima, Anna Sowińska                            #
# ###################################################################
# Pure exchange model
# ###################################################################

# load gEcon package
library(gEcon)

# make and load the model
pe <- make_model("pure_exchange.gcn")

# set model parameters' values
pe <- set_free_par(pe, c(e_A1_calibr = 2,
                         e_A2_calibr = 0,
                         e_B1_calibr = 0,
                         e_B2_calibr = 2))
get_par_values(pe)

# find and print equilibrium values
pe <- steady_state(pe)
get_ss_values(pe, to_tex = TRUE)

# set free parameters' values different from those in the .gcn file
pe <- set_free_par(pe, free_par = list(psi_A = 2))
get_par_values(pe)
pe <- steady_state(pe)
get_ss_values(pe)

# print summary of the model results
summary(pe)
