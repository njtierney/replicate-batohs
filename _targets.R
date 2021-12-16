## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

  workers = simulate_fev1(n_people = 20, max_visits = 12),
  workers_jags = prepare_workers_for_jags(workers),
  jags_model_string = create_jags_model_string(),
  jags_model_params = create_jags_model_params(),
  jags_initial_values = create_jags_initial_values(workers_jags),
  run_jags = run_jags_model(workers_jags,
                            jags_model_string,
                            n_chains = 4,
                            model_params,
                            jags_initial_values,
                            n_iterations_adapt = 100,
                            n_iterations_burnin = 100,
                            n_iterations_model = 100,
                            n_thin = 1)
)
#
