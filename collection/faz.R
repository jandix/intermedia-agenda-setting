# load packages
library(dplyr)

# load functions
source("./collection/helper/get_faz.R")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
timeframe <- seq(from = begin, 
                 to = end, 
                 by = 1)

# define empty dfs
faz_online <- data.frame(date = timeframe,
                         stringsAsFactors = F)

faz_offline <- data.frame(date = timeframe,
                          stringsAsFactors = F)

## immigration ----

# define key words
keywords <- c("Flüchtlinge", 
              "Grenzkontrolle", 
              "Asyl")
query <- paste(keywords, collapse = " OR ")

# define new columns
faz_online$immigration <- NA
faz_offline$immigration <- NA

# setup progressbar
pb <- txtProgressBar(min = 0, max = nrow(faz_online), style = 3)

# get and count articles 
for (i in 1:nrow(faz_online)) {
  date <- format(faz_online$date[i], "%d.%m.%Y")
  articles <- get_faz_archive(q = query,
                              date = date)
  if (is.na(articles)) {
    faz_online$immigration[i] <- faz_offline$immigration[i] <- 0
    next
  }
    
  faz_online$immigration[i] <- articles %>% 
    filter(source) %>% 
    nrow()
  faz_offline$immigration[i] <- articles %>% 
    filter(!source) %>% 
    nrow()
  # update progressbar
  setTxtProgressBar(pb, i)
}

# save dataframes
saveRDS(faz_online, "./data/faz_online.rds")
saveRDS(faz_offline, "./data/faz_offline.rds")
