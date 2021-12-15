#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title

#' @return
#' @author Nicholas Tierney
#' @export
create_jags_model_string <- function() {

  model_string <- "model {

       for(i in 1:n_obs){
         y[i] ~ dnorm(mu[i], tau_y)
         y_pred[i] ~ dnorm(mu[i], tau_y)

         for (r in 1:np){
           vec[i,r] <- beta_all[r]*X[i,r]
         }

         mu[i] <- sum(vec[i,1:np]) + beta_0[ID[i]] + beta_d[ID[i]] * x[i]
       }

       for(j in 1:n_patients){
         # centering around beta_0c and beta_dc
         beta_0[j] ~ dnorm(beta_0c, tau_0)
         beta_d[j] ~ dnorm(beta_dc, tau_d)
       }

       for (r in 1:np){
         beta_all[r] ~ dnorm(0.0, 1.0e-3)
       }

       beta_0c ~ dnorm(0.0, 1.0e-3)
       beta_dc ~ dnorm(0.0, 1.0e-3)
       sigma_y ~ dunif(0, 100)
       sigma_d ~ dunif(0, 100)
       sigma_0 ~ dunif(0, 100)
       tau_y <- 1 / pow(sigma_y, 2)
       tau_d <- 1 / pow(sigma_0, 2)
       tau_0 <- 1 / pow(sigma_d, 2)

       }"

  model_string

}
