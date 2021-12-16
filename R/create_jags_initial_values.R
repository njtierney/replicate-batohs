#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author Nicholas Tierney
#' @export
create_jags_initial_values <- function(workers_jags) {

  # function to set the betas to be zero.
  jags_inits <- function(){
    list("beta_all" = c(rep(0, dim(workers_jags$X)[2])))
  }

  jags_inits

}
