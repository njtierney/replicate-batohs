model_string <- paste0(
  "model {
       for(i in 1:n_obs){

       y[i] ~ dnorm(mu[i], tau_y)

       y_pred[i] ~ dnorm(mu[i], tau_y)

       for (r in 1:np){

       vec[i,r] <- beta_all[r]*X[i,r]

       }
       mu[i] <- sum(vec[i,1:np]) + beta_0[ID[i]] + beta_d[ID[i]] * x[i]
           ## instead of alpha[ID[i]], it is beta_0[ID[i]]
           ## instead of beta[ID[i]], is is beta_d[ID[i]]

       }

       for(j in 1:n_patients){

       # alpha[j] ~ dnorm(0, tau_0)
       # centering around beta_0c
       beta_0[j] ~ dnorm(beta_0c, tau_0)


       # beta[j] ~ dnorm(0, tau_d)
       # centering around beta_dc
       beta_d[j] ~ dnorm(beta_dc, tau_d)

       }

       # for(r in 1:3){
       for (r in 1:np){

       beta_all[r] ~ dnorm(0.0, 1.0e-3)

       }
       # for(r in 4:np){
       # #  test to shrink SEG to 0 so that I can search for problems
       # beta_all[r] ~ dnorm(0.0,1.0e12)
       # #
       # }

       beta_0c ~ dnorm(0.0, 1.0e-3)
       beta_dc ~ dnorm(0.0, 1.0e-3)
       sigma_y ~ dunif(0, ",
  prior_sigmas,
  ")
       sigma_d ~ dunif(0, ",
  prior_sigmas,
  ")
       sigma_0 ~ dunif(0, ",
  prior_sigmas,
  ")
       tau_y <- 1 / pow(sigma_y, 2)
       tau_d <- 1 / pow(sigma_0, 2)
       tau_0 <- 1 / pow(sigma_d, 2)

       }"
)

sprintf("running model with %s adaptive iterations",
        params$n_iterations_adapt)

library(rjags)
jags_model_adapt <- jags.model(
  textConnection(model_string),
  data = jags_dat_model,
  n.chains = params$n_chains,
  inits = jags_inits,
  n.adapt = params$n_iterations_adapt
)

sprintf("running model with %s burnin iterations",
        params$n_iterations_burnin)

jags_model_burnin <- coda.samples(
  model = jags_model_adapt,
  variable.names = model_params,
  n.iter = params$n_iterations_burnin
)

sprintf("running model with %s iterations", params$n_iterations_model)

jags_model_fit <- coda.samples(
  model = jags_model_adapt,
  variable.names = model_params,
  thin = params$n_thin,
  n.iter = params$n_iterations_model
)
