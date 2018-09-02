# load packages
library("dplyr")
library("kableExtra")
library("jsonlite")

# load data
tweets <- readRDS("./data/tweets.rds")

# CANDIDATES ----
candidates <- tweets %>% 
  distinct(from_user_id, .keep_all = T) %>% 
  group_by(party) %>% 
  summarise(accounts_sample = n())

candidates$accounts <- c(84, 62, 101, 23, 55, 65, 119)
candidates$candidates <- c(92, 67, 200, 46, 69, 80, 153)
accounts_sample_percentage <- round((candidates$accounts_sample / candidates$accounts) * 100, 2)
candidates$accounts_sample <- paste0(candidates$accounts_sample,
                                     " (",
                                     accounts_sample_percentage,
                                     "%)")
accounts_percentage <- round((candidates$accounts / candidates$candidates) * 100, 2)
candidates$accounts <- paste0(candidates$accounts,
                              " (",
                              accounts_percentage,
                              "%)")

candidates <- candidates %>% 
  select("Party" = party,
         "# of candidates" = candidates, 
         "# of twitter accounts" = accounts, 
         "# of candidates in sample" = accounts_sample)

kable(candidates,
      format = "latex",
      booktabs = T) %>% 
  kable_styling(latex_options = c("hold_position","scale_down"),
                full_width = F)

# TWEETS BY PARTY ----
party <- tweets %>% 
  group_by(party) %>% 
  summarise(tweets = n())

party <- rbind(party,
               list(party = "Total", tweets = sum(party$tweets)))

candidates <- tweets %>% 
  group_by(party, from_user_id) %>% 
  summarise(n = n()) %>% 
  group_by(party) %>% 
  summarise(mean = round(mean(n), 2), median = median(n))

party <- party %>% 
  left_join(candidates, by = c("party" = "party"))

party$percentages <- round((party$tweets / party$tweets[8]) * 100, 2)
party$tweets <- paste0(party$tweets,
                       " (",
                       party$percentages,
                       "%)")

total_candidates <- tweets %>% 
  group_by(from_user_id) %>% 
  summarise(n = n())

party$mean[8] = round(mean(total_candidates$n), 2)
party$median[8] = round(median(total_candidates$n), 2)


party <- party %>% 
  select(`# of tweets` = tweets,
         `Mean per candidate` = mean,
         `Median` = median)

# transform to tex
kable(party,
      format = "latex",
      booktabs = T) %>% 
  kable_styling(latex_options = c("hold_position","scale_down"),
                full_width = F)

# RATE AND DISTRIBUTION ----

rate <- tweets %>% 
  group_by(from_user_id) %>% 
  summarise(n = n())

# 1 = 1
# 2 = 2-9
# 3 = 10-24
# 4 = 25-49
# 5 = 50-99
# 6 = 100-199
# 7 = >199

rate$group <- ifelse(rate$n <= 1, 1, 7)
rate$group <- ifelse(rate$n > 1 & rate$n <= 9, 2, rate$group)
rate$group <- ifelse(rate$n > 9 & rate$n <= 24, 3, rate$group)
rate$group <- ifelse(rate$n > 24 & rate$n <= 50, 4, rate$group)
rate$group <- ifelse(rate$n > 49 & rate$n <= 99, 5, rate$group)
rate$group <- ifelse(rate$n > 99 & rate$n <= 199, 6, rate$group)

rate <- rate %>% 
  group_by(group) %>% 
  summarise(particpants = n(), postings = sum(n)) %>% 
  mutate(group_label = c("1",
                         "2-9",
                         "10-24",
                         "25-49",
                         "50-99",
                         "100-199",
                         ">199"))

rate$particpants_percentages <- round((rate$particpants / sum(rate$particpants)) * 100, 2)
rate$postings_percentages <- round((rate$postings / sum(rate$postings) *100), 2)
rate$postings_cumulative <- cumsum(rate$postings_percentages)
rate$particpants_cumulative <- cumsum(rate$particpants_percentages)
rate$particpants <- paste0(rate$particpants,
                           " (",
                           rate$particpants_percentages,
                           "%)")
rate$postings <- paste0(rate$postings, 
                        " (",
                        rate$postings_percentages,
                        "%)")

rate <- rate %>% 
  select(`Tweets` = group_label,
         `# of parliamentarians` = particpants,
         `Cumulative per cent` = particpants_cumulative,
         `# of postings` = postings,
         `Cumulative per cent` = postings_cumulative)

# transform to tex
kable(rate,
      format = "latex",
      booktabs = T) %>% 
  kable_styling(latex_options = c("hold_position","scale_down"),
                full_width = F)


# PARTY VS. CATEGORIES ----

# load categories
eu_categories <- readLines("./data/eu_topics.json") %>% 
  paste(collapse = " ") %>% 
  fromJSON()

# create new column with number
eu_categories$topic_label <- paste0("[", eu_categories$id, "] ", eu_categories$topic)

# join topic label
tweets <- tweets %>% 
  left_join(eu_categories,
            by = c("topic" = "topic")) %>% 
  arrange(id.y)

# categories
categories <- table(tweets$id.y, tweets$party)
categories <- rbind(categories, colSums(categories))
categories <- data.frame(categories,
                         stringsAsFactors = F)
categories <- cbind(categories, rowSums(categories))
rownames(categories) <- c(eu_categories$topic_label, "Total")
colnames(categories)[8] <- "Total" 

# transform to tex
kable(categories,
      format = "latex",
      booktabs = T) %>% 
  kable_styling(latex_options = c("hold_position","scale_down"),
                full_width = F)

