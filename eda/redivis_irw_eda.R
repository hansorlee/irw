library(tidyverse)
library(irw)



# get the data
datasource = redivis::user("datapages")$dataset("item_response_warehouse")



tabs = read.csv(
  "/Users/mhardy/Library/CloudStorage/OneDrive-Stanford/STATS290/Redivis-tables-2024-11-01.csv"
) |> as_tibble()

tab_names = tabs$Name
err_tables = c("DART_Brysbaert_2020_3.4.5"
               ,"LSHS-E_Quidaja_2022.csv"
               ,"promis_BrummerHoffman_2021.csv"
               ,"QaSLu_lopez_2024.csv"
               ,"Veterans.Affairs.SSVF.Survey.2016-17"
               ,"Veterans.Affairs.SSVF.Survey.2018-20"
               ,"WMD_bartczuk_2023.csv"
               # ,
               # "internet_use_malawi",
               # "_metadata",
               # "slingshot"
)
tab_names = tab_names[-which(tab_names %in% err_tables)]



## set up empty dataframe
vardf = tibble(tab_name = character(),
               var_name = character(),
               var_type = character())


## fill data frame with variable information

for (tab_name in tab_names) {
  vars = datasource$table(tab_name)$list_variables()
  nvars = length(vars)
  for (var in vars) {
    # kind = var$properties$kind
    name = var$properties$name
    type = var$properties$type
    vardf = vardf |> add_row(tibble_row(
      tab_name = tab_name,
      var_name = name,
      var_type = type
    ))
  }
}

vardf = vardf |> mutate(old_var_name = var_name, var_name=tolower(var_name))

vardf |> write_csv(
  "/Users/mhardy/Library/CloudStorage/OneDrive-Stanford/STATS290/Redivis-variables-2024-11-01.csv"
)

vardf = read_csv(
  "/Users/mhardy/Library/CloudStorage/OneDrive-Stanford/STATS290/Redivis-variables-2024-11-01.csv"
)

vardf |>
  group_by(var_name) |>
  filter(2 <= n_distinct(var_type)) |>
  group_by(var_name, var_type) |>
  summarise(n = n()) |>
  ungroup() |>
  pivot_wider(names_from = var_type, values_from = n)

vardf |>
  group_by(var_name) |>
  filter(2 <= n_distinct(old_var_name)) |>
  group_by(var_name, old_var_name) |>
  summarise(n = n()) |>
  ungroup() |>
  pivot_wider(names_from = var_type, values_from = n)

str_resp_tab = vardf |>
  filter(var_name=="resp",var_type=="string") |>
  pull(tab_name)

vardf |> filter(str_detect(var_name,"qmatrix")) |> pull(tab_name) |> unique()

check_resp_strings = F
## all of these are ints where "NA" made them all strings, correction with as.numeric

if (check_resp_strings) {
  ## empty list to hold response values
  str_resp_tab_df = tibble(tab = character(), resp = character())

  for (i in str_resp_tab) {
    datasource$table(i)$to_tibble()$resp |> unique() |> print()
  }
}




# str_resp_tab_df = datasource$table(i)$to_tibble()$resp |> unique() print()


# asdf = datasource$table("16_personalityfactors")$to_tibble()
# asdf = datasource$table("5personalityfactors")$to_tibble()
# asdf = datasource$table("artistic_preferences")$to_tibble()
# asdf = datasource$table("brain_hemisphere")$to_tibble()
# asdf = datasource$table("close_relationships")$to_tibble()

asdf$resp |> unique()

asdf |> mutate(resp = as.numeric(resp)) |> skim()




