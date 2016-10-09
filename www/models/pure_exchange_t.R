# ############################################################################
# (c) Chancellery of the Prime Minister 2012-2015                            #
#                                                                            #
# Authors: Grzegorz Klima, Karol Podemski, Kaja Retkiewicz-Wijtiwiak         #
# ############################################################################
# Pure exchange model with two consumers and three goods 
# (formulated using templates)
# ############################################################################

# load gEcon package
library(gEcon)

# make and load the model
pure_exchange_t <- make_model("pure_exchange_t.gcn")

# set model parameters' values
pure_exchange_t <- set_free_par(pure_exchange_t, 
                                    free_par= c("alpha__A__1" = 0.3, "alpha__A__2" = 0.4,
                                                "alpha__A__3" = 0.3, "alpha__B__1" = 0.3,
                                                "alpha__B__2" = 0.4, "alpha__B__3" = 0.3,
                                                "e_calibr__A__1" = 3, "e_calibr__B__1" = 1,
                                                "e_calibr__A__2" = 2, "e_calibr__B__2" = 1,
                                                "e_calibr__A__3" = 1, "e_calibr__B__3" = 3))

# find equilibrium
pure_exchange_t <- steady_state(pure_exchange_t)

# model summary
summary(pe)

# index sets
cat("\nIndex sets used in the model:\n")
print(get_index_sets(pure_exchange_t))

agent_A_vars <- get_var_names_by_index(pure_exchange_t, index_names=c("A"))
agent_B_vars <- get_var_names_by_index(pure_exchange_t, index_names=c("B"))

# agent A
cat("\nVariables related to the agent A:\n")
get_ss_values(pure_exchange_t, variables = agent_A_vars, to_tex = TRUE)

# agent B
cat("\nVariables related to the agent B:\n")
get_ss_values(pure_exchange_t, variables = agent_B_vars, to_tex = TRUE)
