df <- simulate_fev1(n_people = 20, max_visits = 12)

# fit with greta
library(greta)

sigma_0 <- uniform(0, 100)
sigma_t <- uniform(0, 100)
sigma_y <- uniform(0, 100)
beta_0c <- normal(0,100)
beta_tc <- normal(0,100)
# intercept <- normal(beta_0c, sigma_0, dim = n_distinct(df$id))
intercept_raw <- normal(0, 1, dim = n_distinct(df$id))
intercept <- beta_0c + intercept_raw * sigma_0
coef_time <- normal(beta_tc, sigma_t, dim = n_distinct(df$id))
coef_smoke <- normal(0,100)
sigma <- uniform(0, 100)

mu <- intercept[df$id] + coef_time[df$id] * df$time + coef_smoke * df$smoker

# # define likelihood
distribution(df$fev1) <- normal(mean = mu, sd = sigma_y)

m <- model(mu)
plot(m)
draws <- greta::mcmc(m)

plot(draws)

ggplot(df,
       aes(x = time,
           y = fev1,
           group = id)) +
  geom_line() +
  facet_wrap(~group)

