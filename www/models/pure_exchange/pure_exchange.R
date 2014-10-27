# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2014                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2014                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Author(s): Grzegorz Klima, Anna Sowińska                          #
# ###################################################################
# Pure exchange model
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
pe <- make_model('pure_exchange.gcn')

# Finding steady state
pe <- steady_state(pe)
get_ss_values(pe, to_tex = save_latex)
get_parameter_vals(pe)

# Overwriting parameter values specified in the *.gcn file
pe <- set_free_par(pe, free_par = list(psi_A = 2))
get_parameter_vals(pe)
pe <- steady_state(pe)
get_ss_values(pe)

# Restoring parameter values set in the *.gcn file
pe <- set_free_par(pe, reset = TRUE)
get_parameter_vals(pe)

# Diagnostics - structure and results of the model
print(pe)
summary(pe)
show(pe)

# ###################################################################
# ############################## END ################################
# ###################################################################
