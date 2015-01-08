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
# Simple CGE model (2x3x2) with Cobb-Douglas production function
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
cge_cd <- make_model("cge_cd.gcn")

# Calibration
cge_cd <- set_free_par(cge_cd, c(omega          = 2,
                               pi_h__2          = 0.5,
                               d_data__B__1     = 11.700,
                               d_data__B__2     = 30.790,
                               d_data__C__1     = 18.600,
                               d_data__C__2     = 43.600,
                               ls_data__1       = 18.170,
                               ls_data__2       = 70.070,
                               ks_data__1       = 65.070,
                               ks_data__2       = 68.770,
                               l_data__A        = 9.440,
                               l_data__B        = 31.600,
                               l_data__C        = 47.200,
                               x_data__A__A     = 68.400,
                               x_data__A__B     = 131.010,
                               x_data__A__C     = 28.280,
                               x_data__B__A     = 111.910,
                               x_data__B__B     = 92.300,
                               x_data__B__C     = 86.920,
                               x_data__C__A     = 117.230,
                               x_data__C__B     = 43.700,
                               x_data__C__C     = 111.650,
                               y_data__A        = 345.080,
                               y_data__B        = 333.620,
                               y_data__C        = 334.780
                               ))

cge_cd <- initval_calibr_par(cge_cd, c(beta_x__A__A   = 1/5,
                                     beta_x__A__B     = 1/5,
                                     beta_x__A__C     = 1/5,
                                     beta_x__B__A     = 1/5,
                                     beta_x__B__B     = 1/5,
                                     beta_x__B__C     = 1/5,
                                     beta_x__C__A     = 1/5,
                                     beta_x__C__B     = 1/5,
                                     beta_x__C__C     = 1/5,
                                     beta_k__A        = 1/5,
                                     beta_k__B        = 1/5,
                                     beta_k__C        = 1/5,
                                     beta_l__A        = 1/5,
                                     beta_l__B        = 1/5,
                                     beta_l__C        = 1/5,
                                     gamma__A         = 4,
                                     gamma__B         = 4,
                                     gamma__C         = 4
                                     ))

# Finding steady state
cge_cd <- steady_state(cge_cd)

get_ss_values(cge_cd, to_tex = save_latex)
get_par_values(cge_cd, to_tex = save_latex)

# ###################################################################
# ############################## END ################################
# ###################################################################
