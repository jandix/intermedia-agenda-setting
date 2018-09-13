# load packages
library(gridExtra)

# load functions
source("./tables/helper/plot_series.R")

# load data
bild_online <- readRDS("./data/bild_online.rds")
bild_offline <- readRDS("./data/bild_offline.rds")
faz_online <- readRDS("./data/faz_online.rds")
faz_offline <- readRDS("./data/faz_offline.rds")
welt_online <- readRDS("./data/welt_online.rds")
welt_offline <- readRDS("./data/welt_offline.rds")
twitter_wo_afd <- readRDS("./data/tweets_wo_afd.rds")
twitter_afd <- readRDS("./data/tweets_afd.rds")

# TWITTER VS. AFD TWITTER
health <- ts_plot_twitter(twitter_wo_afd = twitter_wo_afd$health,
                          twitter_afd = twitter_afd$health,
                          title = "Health")
energy <- ts_plot_twitter(twitter_wo_afd = twitter_wo_afd$energy,
                          twitter_afd = twitter_afd$energy,
                          title = "Energy")
immigration <- ts_plot_twitter(twitter_wo_afd = twitter_wo_afd$immigration,
                               twitter_afd = twitter_afd$immigration,
                               title = "Immigration")
trade <- ts_plot_twitter(twitter_wo_afd = twitter_wo_afd$trade,
                         twitter_afd = twitter_afd$trade,
                         title = "Foreign Trade")

ggsave("./tables/tweets.pdf", 
       width = 12,
       height = 5 * 2,
       units = "in",
       bg = "transparent",
       grid.arrange(health, energy, immigration, trade, nrow = 2, ncol = 2))


# HEALTH ----
b_on <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$health,
                                    twitter_afd = twitter_afd$health,
                                    newspaper = bild_online$health,
                                    "Bild.de")
b_off <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$health,
                                     twitter_afd = twitter_afd$health,
                                     newspaper = bild_online$health,
                                     "Bild Bund & Bild am Sonntag")
f_on <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$health,
                                    twitter_afd = twitter_afd$health,
                                    newspaper = faz_online$health,
                                    "Frankfurter Allgemeine Online")
f_off <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$health,
                                     twitter_afd = twitter_afd$health,
                                     newspaper = faz_offline$health,
                                     "Frankfurter Allgemeine Zeitung & Frankfurter Allgemeine Sonntagszeitung")
w_on <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$health,
                                    twitter_afd = twitter_afd$health,
                                    newspaper = welt_online$health,
                                    "Welt Online")
w_off <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$health,
                                     twitter_afd = twitter_afd$health,
                                     newspaper = welt_offline$health,
                                     "Die Welt & Welt am Sonntag")

ggsave("./tables/health.pdf", 
       width = 12,
       height = 5 * 3,
       units = "in",
       bg = "transparent",
       grid.arrange(b_on, b_off, f_on, f_off, w_on, w_off, nrow = 3, ncol = 2))

## ENERGY ----
b_on <- ts_plot_newspaper_newspaper(twitter_wo_afd = twitter_wo_afd$energy,
                                    twitter_afd = twitter_afd$energy,
                                    newspaper = bild_online$energy,
                                    "Bild.de")
b_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$energy,
                           twitter_afd = twitter_afd$energy,
                           newspaper = bild_online$energy,
                           "Bild Bund & Bild am Sonntag")
f_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$energy,
                          twitter_afd = twitter_afd$energy,
                          newspaper = faz_online$energy,
                          "Frankfurter Allgemeine Online")
f_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$energy,
                           twitter_afd = twitter_afd$energy,
                           newspaper = faz_offline$energy,
                           "Frankfurter Allgemeine Zeitung & Frankfurter Allgemeine Sonntagszeitung")
w_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$energy,
                          twitter_afd = twitter_afd$energy,
                          newspaper = welt_online$energy,
                          "Welt Online")
w_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$energy,
                           twitter_afd = twitter_afd$energy,
                           newspaper = welt_offline$energy,
                           "Die Welt & Welt am Sonntag")

ggsave("./tables/energy.pdf", 
       width = 12,
       height = 5 * 3,
       units = "in",
       bg = "transparent",
       grid.arrange(b_on, b_off, f_on, f_off, w_on, w_off, nrow = 3, ncol = 2))

## IMMIGRATION ----
b_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$immigration,
                          twitter_afd = twitter_afd$immigration,
                          newspaper = bild_online$immigration,
                          "Bild.de")
b_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$immigration,
                           twitter_afd = twitter_afd$immigration,
                           newspaper = bild_online$immigration,
                           "Bild Bund & Bild am Sonntag")
f_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$immigration,
                          twitter_afd = twitter_afd$immigration,
                          newspaper = faz_online$immigration,
                          "Frankfurter Allgemeine Online")
f_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$immigration,
                           twitter_afd = twitter_afd$immigration,
                           newspaper = faz_offline$immigration,
                           "Frankfurter Allgemeine Zeitung & Frankfurter Allgemeine Sonntagszeitung")
w_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$immigration,
                          twitter_afd = twitter_afd$immigration,
                          newspaper = welt_online$immigration,
                          "Welt Online")
w_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$immigration,
                           twitter_afd = twitter_afd$immigration,
                           newspaper = welt_offline$immigration,
                           "Die Welt & Welt am Sonntag")

ggsave("./tables/immigration.pdf", 
       width = 12,
       height = 5 * 3,
       units = "in",
       bg = "transparent",
       grid.arrange(b_on, b_off, f_on, f_off, w_on, w_off, nrow = 3, ncol = 2))

## TRADE ----
b_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$trade,
                          twitter_afd = twitter_afd$trade,
                          newspaper = bild_online$trade,
                          "Bild.de")
b_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$trade,
                           twitter_afd = twitter_afd$trade,
                           newspaper = bild_online$trade,
                           "Bild Bund & Bild am Sonntag")
f_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$trade,
                          twitter_afd = twitter_afd$trade,
                          newspaper = faz_online$trade,
                          "Frankfurter Allgemeine Online")
f_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$trade,
                           twitter_afd = twitter_afd$trade,
                           newspaper = faz_offline$trade,
                           "Frankfurter Allgemeine Zeitung & Frankfurter Allgemeine Sonntagszeitung")
w_on <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$trade,
                          twitter_afd = twitter_afd$trade,
                          newspaper = welt_online$trade,
                          "Welt Online")
w_off <- ts_plot_newspaper(twitter_wo_afd = twitter_wo_afd$trade,
                           twitter_afd = twitter_afd$trade,
                           newspaper = welt_offline$trade,
                           "Die Welt & Welt am Sonntag")

ggsave("./tables/trade.pdf", 
       width = 12,
       height = 5 * 3,
       units = "in",
       bg = "transparent",
       grid.arrange(b_on, b_off, f_on, f_off, w_on, w_off, nrow = 3, ncol = 2))
