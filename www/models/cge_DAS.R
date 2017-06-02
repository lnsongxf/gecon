# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2015-2017                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/DAS_licence.txt          #
#                                                                   #
# (c) Chancellery of the Prime Minister 2015-2017                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/DAS_licence.txt          #
#                                                                   #
# Author(s):    Marta Retkiewicz                                    #
#                - first generic model                              #
#               Rafał Głąbski                                       #
#                - model development                                #
#                - calibration                                      #
#               Michał Opuchlik                                     #
#                - calibration                                      #
#                - model & scenarios testing                        #
#               Maciej Zdrolik                                      #
#                - model development                                #
#                - calibration                                      #
#                - model testing                                    #
# ###################################################################
# CGE model for fiscal policy analyses                              #
# 10 types of HHDs & 11 sectors                                     #
# Neoclassical labor market closure                                 #
# ###################################################################

# Load libraries
library(gEcon)
library(gEcon.iosam)


# ####################################################################
# #######################  MAKE BASE MODEL ###########################
# ####################################################################

# Build model
model <- make_model("cge_DAS.gcn")

# # Load parameters and inital values
# load('parameters_final.RData')
# model <- set_free_par(model, param_final)
# model <- initval_var(model, initval_final)
#
# # Solve for equilibrium
# model <- steady_state(model, options_list = list(max_iter = 200, tol = 1e-6))
#
# # Equilibrium values and parameters for the base model
# ss_values <- get_ss_values(model)
# par_values <- get_par_values(model)
#
# # ######################################################################
# # ######################  SCENARIOS ANALYSES  ##########################
# # ######################################################################
#
# # # ######################## Scenario 1 ################################
# # # ############ Increase of the capital supply to 850 units ###########
#
# # Build new model
# model1 <- set_free_par(model, c(k_total_data = 850))
# model1 <- initval_var(model1, initval_final)
# model1 <- steady_state(model1, options_list = list(max_iter = 2, tol = 1e-6))
#
# ss_values <- get_ss_values(model1)
#
# # ########################## Scenario 2 ##############################
# # ###################### Set new VAT rates ###########################
#
# # decrease effective VAT rates by 10% for each good type
# # effective model VAT rates are based on the model structure and SAM matrix
# #
# # to apply more sophisticated scenarios one needs real effective VAT rates aggregated
# # to sectors implemented in the model
#
# model_vat10perc <- set_free_par(model, c(vat__A =  0.081 * 9/10,
#                                          vat__B =  0.400 * 9/10,
#                                          vat__C =  0.125 * 9/10,
#                                          vat__D =  0.040 * 9/10,
#                                          vat__E =  0.188 * 9/10,
#                                          vat__F =  0.206 * 9/10,
#                                          vat__G =  0.479 * 9/10,
#                                          vat__H =  0.084 * 9/10,
#                                          vat__I =  0.064 * 9/10,
#                                          vat__J =  0.078 * 9/10,
#                                          vat__K =  0.000 * 9/10))
#
# model_vat10perc <- initval_var(model_vat10perc, initval_final)
# model_vat10perc <- steady_state(model_vat10perc)
#
# # ########################## Scenario 3 ##############################
# # ###################### decrease PIT by 10%  ########################
#
# # effective PIT rates are different for each household type
# # exact values of PIT rates are derived directly from SAM matrix
#
# model_pit10perc <- set_free_par(model, c(pit_tax__1 = 0.119 * 9/10,
#                                          pit_tax__2 = 0.125 * 9/10,
#                                          pit_tax__3 = 0.076 * 9/10,
#                                          pit_tax__4 = 0.115 * 9/10,
#                                          pit_tax__5 = 0.029 * 9/10,
#                                          pit_tax__6 = 0.024 * 9/10,
#                                          pit_tax__7 = 0.062 * 9/10,
#                                          pit_tax__8 = 0.061 * 9/10,
#                                          pit_tax__9 = 0.053 * 9/10,
#                                          pit_tax__10 = 0.050 * 9/10))
#
# model_pit10perc <- initval_var(model_pit10perc, initval_final)
# model_pit10perc <- steady_state(model_pit10perc)
