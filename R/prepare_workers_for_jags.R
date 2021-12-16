#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param workers
#' @return
#' @author Nicholas Tierney
#' @export
prepare_workers_for_jags <- function(workers) {

  # omit the intercept (-1), as the model hierarchy now specifies this
  # omit the effect of days (x), as this is also specified
  X <- model.matrix(object =  ~ smoker + group -1,
                    workers)

  # make the JAGS data
  jags_dat_model <- with(workers,
                         list(y = fev1,
                              ID = id,
                              x = X))

  # set parameters
  # observations
  jags_dat_model$n_obs <- length(jags_dat_model$y)
  # number of patients
  jags_dat_model$n_patients <- n_distinct(jags_dat_model$ID)
  # The model matrix
  jags_dat_model$X = X
  # the number of parameters
  jags_dat_model$np = dim(X)[2]

  jags_dat_model

}
