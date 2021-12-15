#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param workers_jags
#' @param jags_model_string
#' @return
#' @author Nicholas Tierney
#' @export
run_jags_model <- function(workers_jags,
                           jags_model_string,
                           n_chains = 4,
                           model_params,
                           jags_initial_values,
                           n_iterations_adapt,
                           n_iterations_burnin,
                           n_iterations_model,
                           n_thin) {

  glue("running model with {n_iterations_adapt} adaptive iterations")

  jags_model_adapt <- jags.model(
    textConnection(jags_model_string),
    data = workers_jags,
    n.chains = n_chains,
    inits = jags_initial_values,
    n.adapt = n_iterations_adapt
  )

  glue("running model with {n_iterations_burnin} burnin iterations")

  jags_model_burnin <- coda.samples(
    model = jags_model_adapt,
    variable.names = model_params,
    n.iter = n_iterations_burnin
  )

  glue("running model with {n_iterations_model} iterations")

  jags_model_fit <- coda.samples(
    model = jags_model_adapt,
    variable.names = model_params,
    thin = n_thin,
    n.iter = n_iterations_model
  )

  jags_model_fit

}
