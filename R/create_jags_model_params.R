#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author Nicholas Tierney
#' @export
create_jags_model_params <- function() {

  model_params <- c("y_pred", # predictions from Y
                    "mu", # mu results
                    "beta_all", #
                    "beta_d", ## instead of beta[ID[i]], is is beta_d[ID[i]]
                    "beta_0", ## instead of alpha[ID[i]], it is beta_0[ID[i]]
                    "beta_dc", # the overall intercept for the number of days
                    "beta_0c", # the overall intercept for the... intercept.
                    "tau_0", # tau_0 instead of tau_alpha
                    "tau_d", # tau_d instead of tau_beta
                    "tau_y",
                    "sigma_0", # sigma_0 instead of sigma_alpha
                    "sigma_d", # sigma_d instead of sigma_beta
                    "sigma_y")

  model_params

}
