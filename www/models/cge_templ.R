# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Marta Retkiewicz                                                  #
# ############################################################################
# Simple CGE model
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
cge_templ <- make_model("cge_templ.gcn")

# set model parameters' values
cge_templ <- set_free_par(cge_templ, 
                          free_par = list(alpha__1__A = 0.306,
                                         alpha__1__B = 0.177,
                                         alpha__1__C = 0.354,
                                         alpha__2__A = 0.306,
                                         alpha__2__B = 0.177,
                                         alpha__2__C = 0.354,
                                         par_k__1 = 20,
                                         par_k__2 = 20,
                                         par_l__1 = 10,
                                         par_l__2 = 30,
                                         phi__1 = 0.25,
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

# find and print equilibrium values
cge_templ <- steady_state(cge_templ)
get_ss_values(cge_templ, to_tex = TRUE)
