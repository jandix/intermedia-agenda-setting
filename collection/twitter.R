# load packages
library(dplyr)
library(jsonlite)
library(readr)
library(stringr)

# load external functionalities
source("./collection/helper/get_db.R")

# define dates
begin <- as.Date("2018-03-15")
end <- as.Date("2018-05-08")

# define date sequence for given time frame
dates <- seq(from = begin, 
             to = end, 
             by = 1)

# define empty df
twitter <- data.frame(date = dates,
                      stringsAsFactors = F)

# get tweets
tweets <- get_tweets()

# get mdbs
mdbs <- get_mdbs()
mdbs <- mdbs %>% 
  select(-created_at)

# replace spelling mistakes
mdbs$Partei <- str_replace(mdbs$Partei, "Die LInke", "Die Linke")
mdbs$Partei <- str_replace(mdbs$Partei, "DIe Linke", "Die Linke")

# replace column names
names(mdbs) <- c("screen_name",
                 "id",
                 "name",
                 "party",
                 "location")

# join mdbs 
tweets <- tweets %>% 
  left_join(mdbs, by = c("from_user_id" = "id"))

# get categories
categories <- get_categories()
categories <- categories %>% 
  distinct(tweet_id, .keep_all = T)

# load categories
eu_categories <- readLines("./data/eu_topics.json") %>% 
  paste(collapse = " ") %>% 
  fromJSON()

# join categories
categories <- categories %>% 
  left_join(eu_categories, by = c("major_category" = "id"))

# join tweets and categories
tweets <- left_join(tweets,
                    categories[ , c("tweet_id", "topic")],
                    by = c("id" = "tweet_id"))
tweets <- tweets %>% 
  filter(!is.na(topic)) %>% 
  distinct(id, .keep_all = T)

# add a date
tweets$date <- as.Date(tweets$created_at)

# remove cases with missing variables
tweets <- na.omit(tweets)

# save complete data set
saveRDS(tweets, "./data/tweets.rds")

# extract immigration
immigration <- tweets %>% 
  filter(topic == "Immigration") %>% 
  group_by(date) %>% 
  summarize(immigration = n())

immigration_afd <- tweets %>% 
  filter(topic == "Immigration", party == "AfD") %>% 
  group_by(date) %>% 
  summarize(immigration_afd = n())

immigration_wo_afd <- tweets %>%
  filter(topic == "Immigration", party != "AfD") %>% 
  group_by(date) %>% 
  summarize(immigration_wo_afd = n())

twitter <- twitter %>% 
  left_join(immigration) %>% 
  left_join(immigration_afd) %>% 
  left_join(immigration_wo_afd)


# replace NAs with 0 counts
twitter[is.na(twitter)] <- 0

# export counts
saveRDS(twitter, "./data/twitter.rds")








# extract health
tweets_health <- tweets[tweets$topic == "Health", ]
tweets_health <- tweets_health %>% 
  group_by(date) %>% 
  summarize(twitter_health = n())
topics_per_day <- topics_per_day %>% 
  left_join(tweets_health)

# extract energy
tweets_energy <- tweets[tweets$topic == "Energy", ]
tweets_energy<- tweets_energy %>% 
  group_by(date) %>% 
  summarize(twitter_energy = n())
topics_per_day <- topics_per_day %>% 
  left_join(tweets_energy)

# extract foreign trade
tweets_foreign_trade <- tweets[tweets$topic == "Foreign Trade", ]
tweets_foreign_trade <- tweets_foreign_trade %>% 
  group_by(date) %>% 
  summarize(twitter_foreign_trade = n())
topics_per_day <- topics_per_day %>% 
  left_join(tweets_foreign_trade)

# fill NAs
topics_per_day[is.na(topics_per_day)] <- 0

# save rds
saveRDS(topics_per_day, file = "./data/topics_per_day.rds")
