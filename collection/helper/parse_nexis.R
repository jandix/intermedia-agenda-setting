parse_nexis <- function (csv, column_name) {
  
  # load csv
  articles <- read_csv(csv)
  
  # remove unused columns and rename columns
  articles <- articles %>%
    select(date = DATE, headline = HEADLINE)
  
  # parse date
  articles$date_parsed <- articles$date %>% 
    str_replace(pattern = "^[:alpha:]+", "") %>%
    str_replace(pattern = ".\\sMai\\s", "-05-") %>%   
    str_replace(pattern = ".\\sApril\\s", "-04-") %>% 
    str_replace(pattern = ".\\sMärz\\s", "-03-") %>% 
    as.Date(format = "%d-%m-%Y")
  
  # add immigration to main df
  articles %>% 
    group_by(date_parsed) %>% 
    summarise(n = n())
}