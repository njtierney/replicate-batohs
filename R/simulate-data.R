simulate_fev1 <- function(n_people = 10,
                          max_visits = 10,
                          fev1_mu = 100,
                          fev1_sigma = 10){

  df <- tibble(
    id = vec_rep_each(x = seq_len(n_people),
                      times = sample(x = seq_len(max_visits),
                                     size = n_people,
                                     replace = TRUE))
  ) %>%
    group_by(id) %>%
    mutate(time = seq_len(n()),
           .after = id) %>%
    mutate(mu = rnorm(n = n(),
                      mean = fev1_mu,
                      sd = fev1_sigma),
           sigma = runif(n = n(),
                         min = 5,
                         max = 10)) %>%
    mutate(
      group = sample(
        x = c("Admin",
            "Emergency",
            "Maintenance",
            "Technician",
            "Field",
            "Technology"),
        size = 1
        ),
      smoker = sample(
        x = c(1,
              0),
        size = 1
      )
      ) %>%
    mutate(fev1_dist = dist_normal(mu = mu,
                                   sigma = sigma),
           fev1 = generate(fev1_dist, times = 1)) %>%
    unnest(cols = fev1)

  df

}
