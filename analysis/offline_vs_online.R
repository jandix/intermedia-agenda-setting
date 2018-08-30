# load data
bild_online <- readRDS("./data/bild_online_ts.rds")
bild_offline <- readRDS("./data/bild_offline_ts.rds")
faz_online <- readRDS("./data/faz_online_ts.rds")
faz_offline <- readRDS("./data/faz_offline_ts.rds")

# compare offline and online publications
ccf(bild_offline$immigration, bild_online$immigration,
    type = "correlation")
ccf(faz_offline$immigration, faz_online$immigration,
    type = "correlation")
