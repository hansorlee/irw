## from irrCAC package
library(irrCAC)
library(tidyverse)

## cac.raw4raters
## cac.raw5obser


## Gwet, K.L. (2014) Handbook of Inter-Rater Reliability, 4th Edition, page #120. Advanced Analytics, LLC.
# This dataset contains data from a reliability experiment where 5 observers scored 15 units on a 4-point numeric scale based on the values 0, 1, 2 and 3.
## This dataset contains ratings obtained from an experiment where 4 raters classified 12 subjects into 5 possible categories labeled as 1, 2, 3, 4, and 5. None of the 4 raters scored all 12  units. Therefore, some missing ratings in the form of "NA" appear in each of the columns associated with the 4 raters. Note that only the the 4 last columns are to be used with the functions included in this package. The first column only plays a descriptive role and is not used in any calculation.

data("cac.raw4raters")
x = cac.raw4raters |> tibble()
x.raw = x
x = x |> 
  mutate(across(everything(),as.numeric)) |>
  mutate(id = 1:nrow(x)) |>
  pivot_longer(cols = -id,
               names_to = "rater",
               values_to = "resp")

df = x |> 
  mutate(item = "category") |> 
  select(id,item,rater,resp)

save(df,file="raw4raters_irrcac.Rdata")


## Gwet, K.L. (2014) Handbook of Inter-Rater Reliability, 4th Edition, page #120. Advanced Analytics, LLC.
# This dataset contains data from a reliability experiment where 5 observers scored 15 units on a 4-point numeric scale based on the values 0, 1, 2 and 3.
## This dataset has 15 rows (for the 15 subjects) and 6 columns. Only the last 5 columns associated with the 5 observers are used in the calculations. Of the 5 observers, only observer 3 scored all 15 units. Therefore, some missing ratings in the form of "NA" appear in the columns associated with the remaining 4 observers. This dataset contains data from a reliability experiment where 5 observers scored 15 units on a 4-point numeric scale based on the values 0, 1, 2 and 3.

data("cac.raw5obser")
x = cac.raw5obser |> tibble()
x.raw = x
x = x |> 
  mutate(across(everything(),as.numeric)) |>
  mutate(id = 1:nrow(x)) |>
  pivot_longer(cols = -id,
               names_to = "rater",
               values_to = "resp") |> 
  mutate(item = "unit")

df = x |>
  select(id,item,rater,resp)

save(df,file="raw5obser_irrcac.Rdata")

