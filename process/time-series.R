# load data
bild_online <- readRDS("./data/bild_online.rds")
bild_offline <- readRDS("./data/bild_offline.rds")
faz_online <- readRDS("./data/faz_online.rds")
faz_offline <- readRDS("./data/faz_offline.rds")
welt_online <- readRDS("./data/welt_online.rds")
welt_offline <- readRDS("./data/welt_offline.rds")
tweets_wo_afd <- readRDS("./data/tweets_wo_afd.rds")
tweets_afd <- readRDS("./data/tweets_afd.rds")

# create time series
time_series <- function (df, column) {
  ts_vec <- df %>%
    select(column) %>% 
    ts(frequency = 7) %>% 
    decompose()
  n <- length(ts_vec$random) - 3
  ts_vec$random[4:n]
}


# create time series and extract 
bild_online_ts <- data.frame(date = bild_online[4:(nrow(bild_online) - 3), 1])
bild_online_ts$health <- time_series(bild_online, "health")
bild_online_ts$energy <- time_series(bild_online, "energy")
bild_online_ts$immigration <- time_series(bild_online, "immigration")
bild_online_ts$trade <- time_series(bild_online, "trade")

bild_offline_ts <- data.frame(date = bild_offline[4:(nrow(bild_offline) - 3), 1])
bild_offline_ts$health <- time_series(bild_offline, "health")
bild_offline_ts$energy <- time_series(bild_offline, "energy")
bild_offline_ts$immigration <- time_series(bild_offline, "immigration")
bild_offline_ts$trade <- time_series(bild_offline, "trade")

saveRDS(bild_online_ts, "./data/ts/bild_online_ts.rds")
saveRDS(bild_offline_ts, "./data/ts/bild_offline_ts.rds")

faz_online_ts <- data.frame(date = faz_online[4:(nrow(faz_online) - 3), 1])
faz_online_ts$health <- time_series(faz_online, "health")
faz_online_ts$energy <- time_series(faz_online, "energy")
faz_online_ts$immigration <- time_series(faz_online, "immigration")
faz_online_ts$trade <- time_series(faz_online, "trade")

faz_offline_ts <- data.frame(date = faz_offline[4:(nrow(faz_offline) - 3), 1])
faz_offline_ts$health <- time_series(faz_offline, "health")
faz_offline_ts$energy <- time_series(faz_offline, "energy")
faz_offline_ts$immigration <- time_series(faz_offline, "immigration")
faz_offline_ts$trade <- time_series(faz_offline, "trade")

saveRDS(faz_online_ts, "./data/ts/faz_online_ts.rds")
saveRDS(faz_offline_ts, "./data/ts/faz_offline_ts.rds")

welt_online_ts <- data.frame(date = welt_online[4:(nrow(welt_online) - 3), 1])
welt_online_ts$health <- time_series(welt_online, "health")
welt_online_ts$energy <- time_series(welt_online, "energy")
welt_online_ts$immigration <- time_series(welt_online, "immigration")
welt_online_ts$trade <- time_series(welt_online, "trade")

welt_offline_ts <- data.frame(date = welt_offline[4:(nrow(welt_offline) - 3), 1])
welt_offline_ts$health <- time_series(welt_offline, "health")
welt_offline_ts$energy <- time_series(welt_offline, "energy")
welt_offline_ts$immigration <- time_series(welt_offline, "immigration")
welt_offline_ts$trade <- time_series(welt_offline, "trade")

saveRDS(welt_online_ts, "./data/ts/welt_online_ts.rds")
saveRDS(welt_offline_ts, "./data/ts/welt_offline_ts.rds")

tweets_wo_afd_ts <- data.frame(date = tweets_wo_afd[4:(nrow(tweets_wo_afd) - 3), 1])
tweets_wo_afd_ts$health <- time_series(tweets_wo_afd, "health")
tweets_wo_afd_ts$energy <- time_series(tweets_wo_afd, "energy")
tweets_wo_afd_ts$immigration <- time_series(tweets_wo_afd, "immigration")
tweets_wo_afd_ts$trade <- time_series(tweets_wo_afd, "trade")

tweets_afd_ts <- data.frame(date = tweets_afd[4:(nrow(tweets_afd) - 3), 1])
tweets_afd_ts$health <- time_series(tweets_afd, "health")
tweets_afd_ts$energy <- time_series(tweets_afd, "energy")
tweets_afd_ts$immigration <- time_series(tweets_afd, "immigration")
tweets_afd_ts$trade <- time_series(tweets_afd, "trade")

saveRDS(tweets_wo_afd_ts, "./data/ts/tweets_wo_afd_ts.rds")
saveRDS(tweets_afd_ts, "./data/ts/tweets_afd_ts.rds")
