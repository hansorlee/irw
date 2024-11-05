## from irr package
library(irr)
library(tidyverse)

## diagnoses
## vision

## Fleiss, J.L. (1971). Measuring nominal scale agreement among many raters. Psychological Bulletin, 76, 378-382.
## Psychiatric diagnoses of n=30 patients provided by different sets of m=6 raters. Data were used by Fleiss (1971) to illustrate the computation of Kappa for m raters. A data frame with 30 observations (psychiatric diagnoses with levels 1. Depression, 2. Personality
# Disorder, 3. Schizophrenia, 4. Neurosis, 5. Other) on 6 variables representing different raters.


data("diagnoses")
x = diagnoses |> tibble()
x.raw = x
x = x |> 
  mutate(across(everything(),as.numeric)) |>
  mutate(id = 1:nrow(x)) |>
  pivot_longer(cols = -id,
               names_to = "rater",
               values_to = "resp")
x.raw = x.raw |>
  mutate(id = 1:nrow(x.raw)) |>
  pivot_longer(cols = -id,
               names_to = "rater",
               values_to = "resp_raw")

df = x |> left_join(x.raw, by = c("id","rater")) |> 
  mutate(item = "diagnosis") |> 
  select(id,item,rater,resp,resp_raw)

save(df,file="diagnoses_irr.Rdata")



# Stuart, A. (1953). The Estimation and Comparison of Strengths of Association in Contingency Tables. Biometrika, 40, 105-110.

# Case records of the eye-testing of N=7477 female employees in Royal Ordnance factories between 1943 and 1946. Data were primarily used by Stuart (1953) to illustrate the the estimation and comparison of strengths of association in contingency tables

data(vision)
x = vision |> tibble()
x.raw = x
x = x |> 
  mutate(across(everything(),as.numeric)) |>
  mutate(id = 1:nrow(x)) |>
  pivot_longer(cols = -id,
               names_to = "item",
               values_to = "resp")
x.raw = x.raw |>
  mutate(id = 1:nrow(x.raw)) |>
  pivot_longer(cols = -id,
               names_to = "item",
               values_to = "resp_raw")

df = x |> left_join(x.raw, by = c("id","item"))

save(df,file="vision_irr.Rdata")