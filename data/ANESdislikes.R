

d <- full_join(read_csv("https://raw.githubusercontent.com/judgelord/text/master/datasets/demdislike.csv"),
               read_csv("https://raw.githubusercontent.com/judgelord/text/master/datasets/repdislike.csv")
)

d %<>% 
  rename(dislike_about_DEM = dislikeDems) %>% 
  rename(dislike_about_GOP = dislikeReps) 

d %<>% gather(dislike_about_DEM, dislike_about_GOP,
  key = "question",
  value = "response"
  ) %>% 
  drop_na(response)

d$response %<>% str_replace_all("[^[:graph:]]", " ") 

d$response %<>% tolower()

d %<>% select(-demhatesreps, -rephatesdems)

d$response %<>% str_replace_all(c("pro |pro-" = "pro",
                                  "anti |anti-" = "anti",
                                  "multi |multi-" = "multi",
                                "health.care" = "healthcare",
                                "taxxes" = "taxes",
                                "don.t" = "dont"))

ANESdislikes <- d

save(ANESdislikes, file = here("data/ANESdislikes.Rdata"))
