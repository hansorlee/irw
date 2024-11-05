## from rater package
library(rater)
library(tidyverse)

## anesthesia
## caries

## anesthesia
## Dawid, A. P., and A. M. Skene. "Maximum Likelihood Estimation of Observer Error-Rates Using the EM Algorithm." Applied Statistics 28, no. 1 (1979): 20.
## PThe data consist of ratings, on a 4-point scale, made by five anaesthetists of patients’ pre-operative health. The ratings were based on the anaesthetists assessments of a standard form completed for all of the patients. There are 45 patients (items) and five anaesthetists (raters) in total. The first anaesthetist assessed the forms a total of three times, spaced several weeks apart. The other anaesthetists each assessed the forms once. The data is in ’long’ format.

data("anesthesia", package = "rater")
x = anesthesia |> tibble()
x = x |> 
  rename(id = item, resp=rating) |> 
  mutate(item = "preoperative_health") 
df = select(id,item,rater,resp) 

save(df,file="anesthesia_rater.Rdata")



# Espeland, Mark A., and Stanley L. Handelman. “Using Latent Class Models to Characterize and Assess Relative Error in Discrete Measurements.” Biometrics 45, no. 2 (1989): 587–99.

# It consists of binary ratings, made by 5 dentists, of whether a given tooth was healthy (sound) or had caries, also known as cavities. The ratings were performed using X-ray only, which was thought to be more error-prone than visual/tactile assessment of each tooth. In total 3,689 ratings were made.This data is in ’grouped’ format. Each row is one of the ’pattern’ with the final columns being a tally of how many times that pattern occurs in the dataset.

data("caries", package = "rater")
x = caries |> tibble()
## expand the table x by creating the number of rows indicated in column "n" for each patter
x = x |> uncount(n)|>
  mutate(id = 1:n()) |>
  pivot_longer(cols = -id,
               names_to = "rater",
               values_to = "resp") |> 
  mutate(item = "tooth")
df = x |> select(id,item,rater,resp)

save(df,file="caries_rater.Rdata")
