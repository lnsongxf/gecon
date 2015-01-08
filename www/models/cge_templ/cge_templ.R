# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2015                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2015                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Author(s): Marta Retkiewicz                                       #
# ###################################################################
# Simple CGE model (2x3x2)
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
cge_templ <- make_model("cge_templ.gcn")

# Calibrating parameters
cge_templ <- set_free_par(cge_templ, free_par=list(alpha__1__A = 0.306,
                                                   alpha__1__B = 0.177,
                                                   alpha__1__C = 0.354,
                                                   alpha__2__A = 0.306,
                                                   alpha__2__B = 0.177,
                                                   alpha__2__C = 0.354,
                                                   par_k__1 = 20,
                                                   par_k__2 = 20,
                                                   par_l__1 = 10,
                                                   par_l__2 = 30,
                                                   phi__2 = 0.75,
                                                   omega = 2,
                                                   gamma__A = 4.711,
                                                   gamma__B = 4.762,
                                                   gamma__C = 4.711,
                                                   beta_k__A = 0.286,
                                                   beta_l__A = 0.143, 
                                                   beta_k__B = 0.167,
                                                   beta_l__B = 0.333,
                                                   beta_k__C = 0.143,
                                                   beta_l__C = 0.143,
                                                   beta_x__A__A = 0.143,
                                                   beta_x__A__B = 0.286,
                                                   beta_x__A__C = 0.143,
                                                   beta_x__B__A = 0.167,
                                                   beta_x__B__B = 0.167,
                                                   beta_x__B__C = 0.167,
                                                   beta_x__C__A = 0.286,
                                                   beta_x__C__B = 0.286,
                                                   beta_x__C__C = 0.143))

# Finding steady state
cge_templ <- steady_state(cge_templ)
get_ss_values(cge_templ, to_tex = save_latex)

# ###################################################################
# ############################## END ################################
# ###################################################################
