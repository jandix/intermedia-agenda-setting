# load data
bild_online <- readRDS("./data/bild_online.rds")
bild_offline <- readRDS("./data/bild_offline.rds")
faz_online <- readRDS("./data/faz_online.rds")
faz_offline <- readRDS("./data/faz_offline.rds")

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
bild_online_ts$immigration <- time_series(bild_online, "immigration")

bild_offline_ts <- data.frame(date = bild_offline[4:(nrow(bild_offline) - 3), 1])
bild_offline_ts$immigration <- time_series(bild_offline, "immigration")

saveRDS(bild_online_ts, "./data/bild_online_ts.rds")
saveRDS(bild_offline_ts, "./data/bild_offline_ts.rds")

faz_online_ts <- data.frame(date = faz_online[4:(nrow(faz_online) - 3), 1])
faz_online_ts$immigration <- time_series(faz_online, "immigration")

faz_offline_ts <- data.frame(date = faz_offline[4:(nrow(faz_offline) - 3), 1])
faz_offline_ts$immigration <- time_series(faz_offline, "immigration")

saveRDS(faz_online_ts, "./data/faz_online_ts.rds")
saveRDS(faz_offline_ts, "./data/faz_offline_ts.rds")
