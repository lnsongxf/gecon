# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Marta Retkiewicz                                                  #
# ############################################################################
# Simple CGE model with Leontief production function
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
cge_leontief <- make_model("cge_calibration.gcn")

# set model parameters' values (SAM data)
free_par <- c(omega        = 2,
              pi_h__2      = 0.5,
              d_data__B__1 = 11.700,
              d_data__B__2 = 30.790,
              d_data__C__1 = 18.600,
              d_data__C__2 = 43.600,
              ls_data__1   = 18.170,
              ls_data__2   = 70.070,
              ks_data__1   = 65.070,
              ks_data__2   = 68.770,
              l_data__A    = 9.440,
              l_data__B    = 31.600,
              l_data__C    = 47.200,
              x_data__A__A = 68.400,
              x_data__A__B = 131.010,
              x_data__A__C = 28.280,
              x_data__B__A = 111.910,
              x_data__B__B = 92.300,
              x_data__B__C = 86.920,
              x_data__C__A = 117.230,
              x_data__C__B = 43.700,
              x_data__C__C = 111.650,
              y_data__A    = 345.080,
              y_data__B    = 333.620,
              y_data__C    = 334.780)
cge_leontief <- set_free_par(cge_leontief, free_par = free_par)

# set calibrated parameters' initial values
cge_leontief <- initval_calibr_par(cge_leontief, 
                                   c(beta_x__A__A = 4,
                                     beta_x__A__B = 4,
                                     beta_x__A__C = 4,
                                     beta_x__B__A = 4,
                                     beta_x__B__B = 4,
                                     beta_x__B__C = 4,
                                     beta_x__C__A = 4,
                                     beta_x__C__B = 4,
                                     beta_x__C__C = 4,
                                     gamma_yva__A = 10,
                                     gamma_yva__B = 10,
                                     gamma_yva__C = 10))

# find and print equilibrium values
cge_leontief <- steady_state(cge_leontief)
get_ss_values(cge_leontief, to_tex = TRUE)

# print calibrated parameters' values
calibr_par <- setdiff(get_par_names(cge_leontief), names(free_par))
get_par_values(cge_leontief, parameters = calibr_par, to_tex = TRUE)
