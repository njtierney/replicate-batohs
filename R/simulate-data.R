library(distributional)
library(vctrs)
library(tidyverse)

df <- expand_grid(
  id = vec_rep_each(1L:100L, times = sample(x = 1:10,
                                            size = 1,
                                            replace = TRUE))
) %>%
  group_by(id) %>%
  mutate(group = sample(
    x = c("Admin",
                   "Emergency",
                   "Maintenance",
                   "Technician",
                   "Field",
                   "Technology"),
    size = 1
         ))

fev1_normal <- dist_normal(mu = 100, sigma = 10)

df %>%
  group_by(id) %>%
  mutate(fev1 = generate(fev1_normal, times = n()))
