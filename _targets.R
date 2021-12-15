## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

  workers = simulate_fev1(n_people = 20, max_visits = 12),
  workers_jags = prepare_workers_for_jags(workers),
  jags_model_string = create_jags_model_string(),
  run_jags = run_jags_model(workers_jags,
                            jags_model_string),
  jags_initial_values = create_jags_initial_values(),
  jags_model_params = create_jags_model_params()

)

ggplot(df,
       aes(x = time,
           y = fev1,
           group = id)) +
  geom_line() +
  facet_wrap(~group)

