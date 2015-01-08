# ###################################################################
# (c) Kancelaria Prezesa Rady Ministrów 2012-2015                   #
# Treść licencji w pliku:                                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# (c) Chancellery of the Prime Minister 2012-2015                   #
# Licence terms can be found in the file:                           #
# http://gecon.r-forge.r-project.org/files/gEcon_licence.txt        #
#                                                                   #
# Author(s): Grzegorz Klima, Karol Podemski,                        #
#            Kaja Retkiewicz-Wijtiwiak                              #
# ###################################################################
# Pure exchange model with two consumers and three goods
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
pure_exchange_t <- make_model("pure_exchange_t.gcn")

# Setting parameter values
pure_exchange_t <- set_free_par(pure_exchange_t, 
                                    free_par= c("alpha__A__1" = 0.3, "alpha__A__2" = 0.4,
                                                "alpha__A__3" = 0.3, "alpha__B__1" = 0.3,
                                                "alpha__B__2" = 0.4, "alpha__B__3" = 0.3,
                                                "e_calibr__A__1" = 3, "e_calibr__B__1" = 1,
                                                "e_calibr__A__2" = 2, "e_calibr__B__2" = 1,
                                                "e_calibr__A__3" = 1, "e_calibr__B__3" = 3))

# Finding equilibrium
pure_exchange_t <- steady_state(pure_exchange_t)


# Diagnostics - structure and results of the model
print(pure_exchange_t)
summary(pure_exchange_t)
show(pure_exchange_t)


# Analysing results

# index sets
cat("\nIndex sets used in the model:\n")
print(get_index_sets(pure_exchange_t))

agent_A_vars <- get_var_names_by_index(pure_exchange_t, index_names=c('A'))
agent_B_vars <- get_var_names_by_index(pure_exchange_t, index_names=c('B'))

# Agent A
cat("\nVariables related to agent A:\n")
get_ss_values(pure_exchange_t, var_names = agent_A_vars, to_tex = save_latex)

# Agent B
cat("\nVariables related to agent B:\n")
get_ss_values(pure_exchange_t, var_names = agent_B_vars, to_tex = save_latex)

# ###################################################################
# ############################## END ################################
# ###################################################################
